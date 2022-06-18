package com.test.api.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "addressBook")
public class AddressBook {
	@Id
	@Column(nullable = false, length = 3)
    private Long no;
	
	@Column(nullable = false, length = 10)
	private String name;

    @Column(nullable = false, length = 3)
    private Integer age;
    
    @Column(nullable = false, length = 11)
    private String phone_num;
}
