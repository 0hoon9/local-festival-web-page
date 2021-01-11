package com.project.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class DataVO {
	Long fnum;
	String festival_name;
	String fesival_place;
	Date start_date;
	Date finish_date;
	String festival_contents;
	String auspice_agency;
	String manage_agency;
	String phone_num;
	String page_address;
	String address_two;
	String address;
}
