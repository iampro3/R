#0405 R 수업 Part02 csv/xslx 내보내기/csv, 엑셀파일 불러오기
library(dplyr)

result = 1 / 20 * 30
result2 <- 1 / 20 * 30

# vector
# vector : 같은 종류의 데이터
char_vector <- c("A", "B", 1, TRUE)
char_vector
class(char_vector)

char_vector


city <- c("서울", "부산", "서울", "부산")
class(city)

city <- factor(c("서울", "부산", "서울", "부산"))
class(city)
city

# dplyr SQL 문법과 유사한게 많음
# install.packages("nycflights13")

library(nycflights13)
library(dplyr)

flights = nycflights13::flights
glimpse(flights)

# SELECT 
# python flights.groupby...........
# SELECT FROM WHERE 필드명 IN ()

flights %>% 
  select(year, month, day, carrier, distance) %>% 
  filter(distance >= 1400 & carrier %in% c("UA", "AA", "B6")) %>% 
  group_by(carrier) %>% 
  summarise(avg_distance = mean(distance)) %>% 
  arrange(desc(avg_distance)) %>% 
  filter(avg_distance >= 2100)
  
# 결측치 다루기
NA > 10 # NA --> 난 모름

NA == 5 # NA --> 난 모름

NA + 100 # NA --> 난 모름

NA * 100 # NA

NA == NA # NA --> 난 모름

a = NA 
is.na(a)

temp <- tibble(x = c(1, 2, NA, 4))
temp

# filter
temp %>% filter(x > 1)

# filter, 꼭 반드시 NA도 같이 출력이 되어야 함
temp %>% filter(x > 1 | is.na(x))
temp %>% filter(is.na(x))

# SELECT문 다시보기
glimpse(flights)
flights %>% 
  select(year, month, day, dep_time, sched_dep_time, dep_delay)

flights %>% 
  select(year:dep_delay)

flights %>% 
  select(-(year:dep_delay))

glimpse(flights)

flights %>% 
  select(contains("time"))

help("select")


glimpse()
# mutate() : 컬럼의 상태를 변경하는 메서드
data <- flights %>% 
  select(year:day, ends_with("_time"), distance)

glimpse(data)

data$time_diff2 = data$arr_time - data$dep_time
data %>% select(dep_time, arr_time, time_diff2)

data %>% 
  mutate(time_diff = arr_time - dep_time, 
         speed = distance / air_time * 60, 
         newthings = 1) %>% 
  select(dep_time, arr_time, air_time, time_diff, speed, newthings)


# 윈도우 함수
# rank(), dense_rank(), row_number()
temp_num <- c(1, 2, 2, 2, NA, 3, 3, 4, 5)
row_number(temp_num)
dense_rank(temp_num)
percent_rank(temp_num)

# dplyr + ggplot2 한꺼번에 코드를 작성하기
library(ggplot2)

flights %>% 
  group_by(dest) %>% 
  summarise(count = n(), 
            dist = mean(distance, na.rm=TRUE), 
            delay = mean(arr_delay, na.rm = TRUE)) %>% 
  filter(count > 10000 & dest != "ACK") %>% 
  ggplot(aes(x = dist, y = delay)) + 
    geom_point() + 
    xlim(0, 3000) + 
    theme_bw()

# 파일 입출력 
# CSV 파일 불러오기
mpg = read.csv(file = "data/mpg6.csv")
write.csv(mpg,file = "data/result.csv")

# install.packages("writexl")
library(writexl)
write_xlsx(mpg, "data/result.xlsx")

# 엑셀파일 불러오기
# install.packages("readxl")
library(readxl)
mpg2 = read_excel(path = "data/result.xlsx")
mpg2







