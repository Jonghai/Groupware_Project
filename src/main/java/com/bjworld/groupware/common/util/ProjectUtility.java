package com.bjworld.groupware.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.imgscalr.Scalr;
import org.jsoup.Jsoup;
import org.jsoup.Connection.Method;
import org.jsoup.Connection.Response;
import org.springframework.core.env.Environment;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.bjworld.groupware.adminuser.service.impl.AdminUserVO;
import com.bjworld.groupware.common.SystemConstant;
import com.bjworld.groupware.common.exception.ProjectException;

public class ProjectUtility {

	public static String getPageNavigatorHtml(int totalItemCount, int currentPageNum, int pageSize) {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		String currentUrl = req.getServletPath();
		String queryString = "";
		for (String param : req.getParameterMap().keySet()) {
			if (!param.equals("pn")) {
				if (EgovStringUtil.isEmpty(queryString))
					queryString = "?";
				queryString += param + "=" + req.getParameter(param) + "&";
			}
		}
		
		if(!EgovStringUtil.isEmpty(queryString))
			queryString = queryString.substring(0, queryString.lastIndexOf("&"));

		if (EgovStringUtil.isEmpty(queryString))
			currentUrl = currentUrl + "?";
		else
			currentUrl = currentUrl + queryString;

		int pagingCount = 5;

		int lastPage = 0;

		if (totalItemCount % pageSize == 0) {
			lastPage = (totalItemCount / pageSize);
		} else {
			lastPage = (totalItemCount / pageSize) + 1;
		}

		int firstPage = currentPageNum > pagingCount ? (((currentPageNum - 1) / pagingCount) * pagingCount) + 1 : 1;

		if (firstPage + pagingCount < lastPage)
			lastPage = firstPage + pagingCount;
		
		String pagingItemHtmlFormat = "<li class='%s'><a href='%s&pn=%s'>%s</a></li>";
		
		String pagingItemHtml = "";
		String html = "<ul class='un-styled clearfix pagination d-flex justify-content-center'>";
		html += "<li><a href='%s' title='???????????????'><img alt='?????? ????????? ?????? ?????????' src='/css/egovframework/img/userpage/list-prev.png'></a></li>";
		html += "<li><a href='%s' title='???????????????'><img alt='?????? ????????? ?????? ?????????' src='/css/egovframework/img/userpage/list-p.png'></a></li>";
		html += "%s"; 
		html += "<li><a href='%s' title='???????????????'><img alt='?????? ????????? ?????? ?????????' src='/css/egovframework/img/userpage/list-n.png'></a></li>";
		html += "<li><a href='%s' title='???????????????'><img alt='?????? ????????? ?????? ?????????' src='/css/egovframework/img/userpage/list-next.png'></a></li>";
		html += "</ul>";
		
		int pagingLastNum = 0;
		for (int i = firstPage; i < firstPage + pagingCount; i++) {
			if (i - 1 == lastPage) {
				pagingLastNum = i - 1;
				break;
			}

			String active = "";
			if (i == currentPageNum)
				active = "active";
			
			pagingItemHtml += String.format(pagingItemHtmlFormat, active, currentUrl,String.valueOf(i), String.valueOf(i));
		}

		if(totalItemCount == 0) {
			lastPage = 1;
			
			pagingItemHtml += String.format(pagingItemHtmlFormat, "active", currentUrl, "1", "1");
		}
			
		String lastHref = totalItemCount == 0 ? "#!" : currentUrl + "&pn=" + String.valueOf(lastPage);
		if(pagingLastNum == lastPage)
		{
			lastHref = "#!";
		}

		return String.format(
				html, 
				(
					totalItemCount == 0 ? "#!" : currentUrl + "&pn=" + String.valueOf(firstPage > pagingCount ? firstPage - pagingCount : 1)), 
					currentUrl + "&pn=" + String.valueOf(currentPageNum == 1 ? 1 : currentPageNum - 1),
					pagingItemHtml, 
					currentUrl + "&pn=" + String.valueOf(currentPageNum == lastPage ? lastPage : currentPageNum + 1), 
					lastHref
				);
	}

	public static String getRemoteIp(HttpServletRequest request) {

		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null) {

			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null) {
			ip = request.getHeader("WL-Proxy-Client-IP"); // ?????????
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null) {
			ip = request.getRemoteAddr();
		}
		return ip;

	}
	
	public static List<HashMap<String, String>> excelDataToList(InputStream excelFileStream, int rowStartIndex, String[] columns, int sheetIndex) throws Exception
    {
		List<HashMap<String, String>> excelList = new ArrayList<>();
    	try(XSSFWorkbook workbook = new XSSFWorkbook(excelFileStream)) {
    		
            int rowindex=0;
            int columnindex=0;
            //?????? ??? (??????????????? ??????????????? 0??? ??????)
            //?????? ??? ????????? ?????????????????? FOR?????? ????????? ????????????
            XSSFSheet sheet=workbook.getSheetAt(sheetIndex);
            //?????? ???
            int rows=sheet.getPhysicalNumberOfRows();
            for(rowindex=rowStartIndex;rowindex<rows;rowindex++){
            	HashMap<String, String> rowMap = new HashMap<String, String>();
                //???????????????
                XSSFRow row=sheet.getRow(rowindex);
                if(row !=null){
                    //?????? ???
                    int cells=columns.length-1;
                    for(columnindex=0; columnindex<=cells; columnindex++){
                        //????????? ?????????
                        XSSFCell cell=row.getCell(columnindex);
                        String value="";
                        //?????? ?????????????????? ?????? ?????????
                        if(cell==null){
                        	//rowMap.put(columns[columnindex], value);
                        	continue;
                        }else{
                            //???????????? ?????? ??????
                            switch (cell.getCellType()){
                            case XSSFCell.CELL_TYPE_FORMULA:
                                value=cell.getCellFormula();
                                break;
                            case XSSFCell.CELL_TYPE_NUMERIC:
                            	if(columnindex == 24 || columnindex == 25) {
                            		if(DateUtil.isCellDateFormatted(cell)) {
                            			Date date = cell.getDateCellValue();
                        				value = new SimpleDateFormat("yyyyMMdd").format(date);
                            		}
                            		else
                            			value = NumberToTextConverter.toText(cell.getNumericCellValue());
                            	}
                            	else
                            		value=NumberToTextConverter.toText(cell.getNumericCellValue());
                                break;
                            case XSSFCell.CELL_TYPE_STRING:
                                value=cell.getStringCellValue()+"";
                                if(value.endsWith(".0"))
                                	value = value.substring(0, value.lastIndexOf(".0"));
                                break;
                            case XSSFCell.CELL_TYPE_BLANK:
                                value="";
                                break;
                            case XSSFCell.CELL_TYPE_ERROR:
                                value=cell.getErrorCellValue()+"";
                                break;
                            }
                        }
                        
                        rowMap.put(columns[columnindex], value.trim());
                        
                    }
                    excelList.add(rowMap);
 
                }
            }
            
            return excelList;
 
        }catch(IOException ie) {
            throw ie;
        }
    	catch(Exception e) {
            throw e;
        }
    }	
	
	public static List<String> conversionPdf2Img(InputStream is, String saveFolder) throws Exception {
        List<String> savedImgList = new ArrayList<>(); //????????? ????????? ????????? ???????????? List ??????
        PDDocument pdfDoc = PDDocument.load(is); //Document ??????
        PDFRenderer pdfRenderer = new PDFRenderer(pdfDoc);
        
        String resultImgPath = saveFolder;

        String saveFileName = UUID.randomUUID().toString().replace("-", "");
        //???????????? ???????????? ?????? ??????
        for (int i=0; i<pdfDoc.getPages().getCount(); i++) {
            String imgFileName = resultImgPath + File.separator + saveFileName + "_" + i + ".png";
				
            //DPI ??????
            BufferedImage bim = pdfRenderer.renderImageWithDPI(i, 300, ImageType.RGB);

            // ???????????? ?????????.
            ImageIOUtil.writeImage(bim, imgFileName , 300);

            //?????? ????????? ???????????? list??? ????????????.
            savedImgList.add(saveFileName + "_" + i + ".png");
        }
        pdfDoc.close(); //?????? ????????? PDF ????????? ?????????.
        return savedImgList;
    }
	
	public static String resizeImage(String oriFilePath, int width) throws Exception {
		// ?????? ????????? ?????????.
		BufferedImage srcImg = ImageIO.read(new File(oriFilePath));
		
		String saveFolder = oriFilePath.substring(0, oriFilePath.lastIndexOf(File.separator));
		String extension = oriFilePath.substring(oriFilePath.lastIndexOf('.'));

		// ????????????(????????? ??????)
		BufferedImage destImg = Scalr.resize(srcImg, Scalr.Method.ULTRA_QUALITY, Scalr.Mode.FIT_TO_WIDTH, width);

		String saveFileName = UUID.randomUUID().toString().replace("-","") + extension;
		// ????????? ??????
		String thumbName = saveFolder + File.separator + saveFileName;
		File thumbFile = new File(thumbName);
		ImageIO.write(destImg, extension.replace(".",  ""), thumbFile);
		
		return saveFileName;
	}
	
	public static String getSiteBaseUrl() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String url = request.getScheme()+"://"+request.getServerName();
		if(!(request.getServerPort() == 80 || request.getServerPort() == 443)) {
			url += ":"+request.getServerPort();
		}
		
		return url;
	}
	
	public static void fileExtensionCheck(String extension, MultipartFile uploadFile) throws ProjectException {
		String checkExtension = extension.toUpperCase();
		String contentType = uploadFile.getContentType();
		//.xlsx,.xls,image/*,.doc, .docx,.ppt, .pptx,.txt,.pdf,.hwp
		
		if(!(checkExtension.equals(".XLSX")
	    		||checkExtension.equals(".XLS")
	    		||checkExtension.equals(".DOC")
	    		||checkExtension.equals(".DOCX")
	    		||checkExtension.equals(".PPT")
	    		||checkExtension.equals(".PPTX")
	    		||checkExtension.equals(".TXT")
	    		||checkExtension.equals(".PDF")
	    		||checkExtension.equals(".HWP")
	    		||contentType.startsWith("image")
	    		||checkExtension.equals(".ZIP")
	    		))
	    		throw new ProjectException("??????????????? ??????(.xlsx, .xls), ??????(.docx, .doc), ????????????(.hwp), ?????????(?????????????????????), TXT(.txt), ZIP(.zip) ????????? ????????? ??? ????????????.", 1);
	}
	
	public static UploadFileVO uploadFileHandler(MultipartFile uploadFile, String saveFolder) throws Exception {
		if(uploadFile == null || uploadFile.getSize() == 0)
			return null;
		
		UploadFileVO returnValue = new UploadFileVO();
		
		String fileName = uploadFile.getOriginalFilename();
    	String extension = fileName.substring(fileName.lastIndexOf("."));
    	
    	if(fileName.lastIndexOf(".") < 0)
    		throw new Exception("not valid filename,required file extension");
    	
    	try {
    		ProjectUtility.fileExtensionCheck(extension, uploadFile);
    	}
    	catch(ProjectException ce) {
    		throw new Exception(ce.getMessage());
    	}
    	
		byte[] bytes = uploadFile.getBytes();
		String uploadPath = saveFolder;
		
		File saveFile = new File(uploadPath);
		if(!saveFile.exists()){
			saveFile.mkdirs();
		}
       
        String saveFileName = UUID.randomUUID().toString().replaceAll("-", "") + extension;
        
		uploadPath = uploadPath + File.separator + saveFileName;
		
		try(OutputStream out = new FileOutputStream(new File(uploadPath))) {
	        out.write(bytes);
	        out.flush();
	        
	        returnValue.setOriginalFileName(fileName);
	        returnValue.setSaveFileName(saveFileName);
	        returnValue.setSaveFullPath(uploadPath);
	        returnValue.setFileSize(String.valueOf(bytes.length));
	        
	        return returnValue;
		}
		catch(Exception ex) {
			throw new Exception(ex);
		}
	}
	
	public static String maskingName(String name){
		String replaceString = name;

		String pattern = "";
		if(name.length() == 2) {
			pattern = "^(.)(.+)$";
		} else {
			pattern = "^(.)(.+)(.)$";
		}

		Matcher matcher = Pattern.compile(pattern).matcher(name);

		if(matcher.matches()) {
			replaceString = "";

			for(int i=1;i<=matcher.groupCount();i++) {
				String replaceTarget = matcher.group(i);
				if(i == 2) {
					char[] c = new char[replaceTarget.length()];
					Arrays.fill(c, '*');

					replaceString = replaceString + String.valueOf(c);
				} else {
					replaceString = replaceString + replaceTarget;
				}

			}
		}
		return replaceString;
	}

	public static AdminUserVO getSessionAdminUser() throws Exception {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return (AdminUserVO) EgovSessionCookieUtil.getSessionAttribute(req, SystemConstant.ADMIN_USER_LOGIN_SESSION_KEY);
	}
	
	public static void writeResponseMessage(HttpServletResponse response, String responseMessage) throws Exception {
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			out = response.getWriter();
			out.write(responseMessage);
			out.flush();
		}
		catch(Exception e)
		{
			throw e;
		}
		finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	public static String getImgSrc(String html) {
		Pattern nonValidPattern = Pattern.compile("(?i)< *[IMG][^\\>]*[src] *= *[\"\']{0,1}([^\"\'\\ >]*)");
		int imgCnt = 0;
		String content = "";
		Matcher matcher = nonValidPattern.matcher(html);
		while (matcher.find()) {
			content = matcher.group(1);
			imgCnt++;
			if (imgCnt == 1) {
				break;
			}
		}
		return content;
	}
	
	public static List<String> getImgSrcList(String html) {
  		Pattern nonValidPattern = Pattern
  				.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
  		
		List<String> result = new ArrayList<>();
  		Matcher matcher = nonValidPattern.matcher(html);
  		while (matcher.find()) {
  			result.add(matcher.group(1));
  		}
  		
  		return result;
  	}

	public static String getHomeTaxCompanyStatus(String businessRegNo) {
		String companyStatus = "";
		if (null == businessRegNo || "".equals(businessRegNo)) {
			throw new RuntimeException("????????? ???????????????????????? ????????????.");
		}
		String txprDscmNo = EgovStringUtil.replace(businessRegNo, "-", "");
		if (txprDscmNo.length() != 10) {
			throw new RuntimeException("????????? ???????????????????????? ????????? ??????????????????.");
		}
		String dongCode = txprDscmNo.substring(3, 5);
		String url = "https://teht.hometax.go.kr/wqAction.do?actionId=ATTABZAA001R08&screenId=UTEABAAA13&popupYn=false&realScreenId=";
		Map<String, String> headers = new HashMap<>();
		headers.put("Accept", "application/xml; charset=UTF-8");
		headers.put("Accept-Encoding", "gzip, deflate, br");
		headers.put("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
		headers.put("Connection", "keep-alive");
		headers.put("Content-Length", "257");
		headers.put("Content-Type", "application/xml; charset=UTF-8");
		headers.put("Host", "teht.hometax.go.kr");
		headers.put("Origin", "https://teht.hometax.go.kr");
		headers.put("Referer", "https://teht.hometax.go.kr/websquare/websquare.html?w2xPath=/ui/ab/a/a/UTEABAAA13.xml");
		headers.put("Sec-Fetch-Mode", "cors");
		headers.put("Sec-Fetch-Site", "same-origin");
		headers.put("User-Agent",
				"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36");
		final String CRLF = "\n";
		StringBuffer sb = new StringBuffer();
		sb.append("<map id=\"ATTABZAA001R08\">" + CRLF);
		sb.append(" <pubcUserNo/>" + CRLF);
		sb.append(" <mobYn>N</mobYn>" + CRLF);
		sb.append(" <inqrTrgtClCd>1</inqrTrgtClCd>" + CRLF);
		sb.append(" <txprDscmNo>" + txprDscmNo + "</txprDscmNo>" + CRLF);
		sb.append(" <dongCode>" + dongCode + "</dongCode>" + CRLF);
		sb.append(" <psbSearch>Y</psbSearch>" + CRLF);
		sb.append(" <map id=\"userReqInfoVO\"/>" + CRLF);
		sb.append("</map>" + CRLF);
		String body = sb.toString();
		
		String responseBody = "";
		
		try {
			Response res = Jsoup.connect(url).headers(headers).requestBody(body).timeout(3000).method(Method.POST)
					.execute();
			
			responseBody = res.body();
			
			companyStatus = responseBody.substring(responseBody.indexOf("<trtCntn>")).replace("<trtCntn>", "").replace("</trtCntn></map>", "");
			
			
		} catch (Exception ex) {
			EgovBasicLogger.info(ex.getMessage());
		}
		return companyStatus;
	}
		
}


