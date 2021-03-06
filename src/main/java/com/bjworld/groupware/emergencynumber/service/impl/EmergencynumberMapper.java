package com.bjworld.groupware.emergencynumber.service.impl;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("emergencynumberMapper")
public interface EmergencynumberMapper {

	void mergeEmergencynumber(EmergencynumberVO paramVO);
	
	List<EmergencynumberVO> selectEmergencynumberList(EmergencynumberVO paramVO) throws Exception;

	void updateEmergencynumber(EmergencynumberVO paramVO);

	Integer selectEmergencynumberListTotCnt(EmergencynumberVO paramVO);

	void deleteEmergencynumber(EmergencynumberVO paramVO);

	EmergencynumberVO selectEmergencynumber(EmergencynumberVO paramVO);

	

	



	

	

	
		
	
}


