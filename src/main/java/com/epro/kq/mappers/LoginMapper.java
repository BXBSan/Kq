package com.epro.kq.mappers;

import com.epro.kq.domain.Employee;
import com.epro.kq.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2016/5/9.
 */

@Repository
//@Transactional
public interface LoginMapper {
    public Employee select(String phoneno);
}
