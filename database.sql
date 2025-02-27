-- 创建数据库
DROP DATABASE IF EXISTS travel_db;
CREATE DATABASE travel_db;
USE travel_db;

-- 创建用户表
CREATE TABLE user (
    user_id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    is_admin BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 创建城市表
CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 创建景点表
CREATE TABLE attractions (
    attraction_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 创建评价表
CREATE TABLE visits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    attraction_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL,
    comment TEXT,
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (attraction_id) REFERENCES attractions(attraction_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 插入默认管理员账号
INSERT INTO user (user_id, username, password, is_admin) 
VALUES ('admin', 'Administrator', 'admin123', true);

-- 插入示例城市数据
INSERT INTO cities (name) VALUES 
('北京'),
('上海'),
('广州'),
('深圳'),
('杭州');

-- 插入示例景点数据
INSERT INTO attractions (name, city_id, description) VALUES 
('故宫', 1, '中国明清两代的皇家宫殿，世界上现存规模最大、保存最完整的木质结构古建筑之一'),
('长城', 1, '中国古代的伟大防御工程，是世界上最伟大的建筑之一'),
('外滩', 2, '上海市中心的一个著名旅游景点，有许多历史建筑和现代摩天大楼'),
('东方明珠', 2, '上海的标志性建筑之一，是亚洲最高的电视塔'),
('广州塔', 3, '又称广州新电视塔，是广州的地标建筑'),
('沙面岛', 3, '广州历史文化景区，保留了许多欧式建筑'),
('世界之窗', 4, '深圳著名的主题公园，汇集了世界各地的著名建筑微缩景观'),
('深圳湾公园', 4, '临海公园，是欣赏深圳湾景色的最佳地点'),
('西湖', 5, '中国十大风景名胜之一，有着悠久的历史文化底蕴'),
('灵隐寺', 5, '杭州最著名的寺庙，始建于东晋时期');

-- 插入示例用户数据
INSERT INTO user (user_id, username, password, email) VALUES 
('user1', '张三', 'password123', 'zhangsan@example.com'),
('user2', '李四', 'password123', 'lisi@example.com'),
('user3', '王五', 'password123', 'wangwu@example.com');

-- 插入示例评价数据
INSERT INTO visits (user_id, attraction_id, rating, comment) VALUES 
('user1', 1, 5.0, '故宫真是太壮观了，历史感很强，建议慢慢逛'),
('user1', 2, 4.5, '长城很雄伟，爬起来比较累，建议带够水'),
('user2', 3, 4.0, '外滩的夜景很美，建筑很有特色'),
('user2', 4, 4.5, '东方明珠的观光层视野很好，可以看到整个上海'),
('user3', 9, 5.0, '西湖真的很美，特别是雨后的景色，令人陶醉'),
('user3', 10, 4.0, '灵隐寺环境清幽，很适合放松心情');

-- 创建索引
CREATE INDEX idx_city_name ON cities(name);
CREATE INDEX idx_attraction_name ON attractions(name);
CREATE INDEX idx_visit_date ON visits(visit_date);
CREATE INDEX idx_user_created ON user(created_at);

-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;