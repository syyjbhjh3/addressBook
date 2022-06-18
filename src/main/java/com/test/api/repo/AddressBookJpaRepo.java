package com.test.api.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.test.api.entity.AddressBook;

@Repository
public interface AddressBookJpaRepo extends JpaRepository<AddressBook, String> {
}