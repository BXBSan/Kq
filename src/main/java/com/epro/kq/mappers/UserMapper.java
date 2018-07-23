package com.epro.kq.mappers;

import com.epro.kq.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2016/5/9.
 */

@Repository
//@Transactional
public interface UserMapper {
    // 列表
    List<User> getUserAll();
    // 新增
    void insertUser(User user);
    // 删除
    void deleteUser(User user);
    // 修改
    void updateUser(User user);
}
