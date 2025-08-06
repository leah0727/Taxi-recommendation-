# Optimized Route Recommendation System for Taxi Drivers in Daejeon

<a href="https://yeongeun-ra-2025.netlify.app/files/17_taxi_pre.pdf">
  <img src="https://img.shields.io/badge/Report-PDF-red?style=for-the-badge&logo=adobeacrobatreader" width="230">
</a>

# PROJECT SUMMARY
## 1. Data
- **Data Used**: Taxi operation data in Daejeon from April 2023 to March 2024

  * **Data Paths**:
    - `data/processed/weekday_clusted.csv`
    - `data/processed/friday_clusted.csv`
    - `data/processed/weekend_clusted.csv`
  
  * **Additional Data**:
    - `data/extra/popular_tourist_spots_latlong.csv`
    - `data/extra/taxi_stands_latlong.csv`
  
  * **Features**:
    - Boarding X-coordinate  
    - Boarding Y-coordinate  
    - hour (time)  
    - Temperature (°C)  
    - Precipitation (mm)  
    - holiday (holiday indicator)

- **Additional Sources**:
  - ASOS (Automated Synoptic Observation System): Korea Meteorological Administration Open Data Portal (temperature, precipitation)
  - South Korea Public Holidays Data
  - Daejeon Taxi Stand Information: Public Data Portal
  - Daejeon Popular Tourist Spots: Korea Tourism Data Lab

---

## 2. Model
- **Clustering**: KMeans clustering for taxi demand prediction by day and time  
  - Separate clustering for Mon–Thu, Friday, and Weekend (Sat, Sun)  
  - Optimal cluster size for each dataset (K=3)  

- **K-Nearest Neighbors (KNN)**: Predict the closest cluster based on input coordinates, time, temperature, and precipitation

---

## 3. Training & Inference Steps
1. **Model Selection**: Choose the appropriate clustering model based on the input day.
2. **Train Clustering Models**:
    - Use KMeans algorithm for clustering by day category.
    - Train and save separate models for weekday, Friday, and weekend.
3. **Process Input Data**: Standardize the input (coordinates, time, temperature, precipitation, holiday).
4. **Cluster Prediction**: Predict cluster labels using standardized input data.
    - Use KNN to assign the input data to the nearest cluster.
5. **Provide Recommended Locations**: Suggest top 10 most frequent boarding locations in the predicted cluster.
6. **Apply Weighted Recommendation**: Re-rank suggestions by considering proximity to popular tourist spots and taxi stands.
    - If ties occur, apply weights using taxi stands and tourist spots data.

---

## 4. Environment
- **Language**: Python 3.8 or higher  
- **Required Libraries**:
    - pandas
    - matplotlib
    - seaborn
    - numpy
    - scikit-learn
    - folium

- **Execution Steps**:
1. Prepare the data and run the script.
2. Call `recommend_locations` or `recommend_locations_with_weights` to get recommended locations.

---

## 5. Example Usage
```python
# Input Example
day = 'Thursday'
current_coords = [127.436374, 36.332504]
current_time = 14  # 2 PM
current_temp = 20.5  # Current temperature
current_rain = 13  # Current precipitation

# Get recommended locations
top_10_locations = recommend_locations(day, current_coords, current_time, current_temp, current_rain)
print(top_10_locations)



## 파일 구조
```plaintext
project_name/
│
├── README.md           # 연구결과물 (데이터, 모델, 학습/추론 수행방법, 실행환경 등) 설명 파일
│
├── data/                           # 모델의 학습 및 평가에 사용된 데이터 폴더
│   ├── raw/                        # 원본 데이터
│   │   ├── test_taxi_tims_U.csv    # 테스트 데이터 파일
│   │   └── train_taxi_tims_U.csv   # 학습 데이터 파일
│   ├── processed/                  # 전처리 및 분할된 데이터
│   │   ├── train_1.csv             # 날씨 필터링 및 결측값 제거 후 데이터
│   │   ├── train_금요일data1.csv     # 날씨 추가 후 금요일 데이터 
│   │   ├── train_주말data1.csv      # 날씨 추가 후 주말 데이터
│   │   ├── train_주중data1.csv      # 날씨 추가 후 주중 데이터
│   │   ├── train_금요일data2.csv     # 공휴일 추가 후 최종 금요일 데이터 
│   │   ├── train_주말data2.csv      # 공휴일 추가 후 최종 주말 데이터 
│   │   ├── train_주중data2.csv      # 공휴일 추가 후 최종 주중 데이터 
│   │   ├── weekend_clusted.csv     # 클러스터 지정된 주말 데이터 
│   │   ├── friday_clusted.csv      # 클러스터 지정된 금요일 데이터 
│   │   └── weekday_clusted.csv     # 클러스터 지정된 주중 데이터 
│   ├── extra/                      # 추가 활용 데이터 
│   │   ├── 2023_Korean_holiday.csv # 2023년 공휴일 정보 데이터 
│   │   ├── 2024_Korean_holiday.csv # 2024년 공휴일 정보 데이터 
│   │   ├── 인기관광지_20.csv          # 대전 광역시 인기 관광지 현황 원본 데이터 
│   │   ├── 인기관광지_위도경도.csv      # 대전 광역시 인기 관광지 현황 전처리 후 데이터 
│   │   ├── 택시승강장.csv             # 대전 광역시 택시 승강장 현황 원본 데이터 
│   │   ├── 택시 승강장_위도경도.csv     # 대전 광역시 택시 승강장 현황 전처리 후 데이터 
│   │   ├── ASOS_지상수치.csv         # 기상청 다운로드   
│   │   └── 대전_weather.csv         # ASOS_지상수치 전처리 후 데이터
│   └── valid/                      # 검증데이터 파일 
│       ├── valid_data.csv          # 7개날짜,20개장소,24시간대의 3360case가 저장된 검증용데이터
│       ├── balanced_data.csv       # 제공된 test데이터의 정답률산정을 위한 전처리데이터
│       ├── recommendation_df.csv   # 3360case에 대한 각 10개의 추천좌표 데이터
│       └── result_ac.csv           # 3360case에 대한 정답률 데이터
│
├── model/                          # 학습된 모델 파일 폴더
│   └── 모델.ipynb                   # 모델 + 예시  
│
├── src/                     # 데이터 정제/전처리, 모델 구조, 학습과 평가를 수행하는 소스코드
│   ├── 1. 전처리_날짜필터링및결측값제거.ipynb          # 원본 데이터 전처리 코드 1
│   ├── 2. 전처리_기온강수량추가및데이터분할.ipynb       # 원본 데이터 전처리 코드 2
│   ├── 3. 전처리_공휴일추가후최종전처리데이터.ipynb     # 원본 데이터 전처리 코드 3
│   ├── 4. 활용데이터전처리_인기관광지택시승강장.ipynb   # 활용 데이터 전처리 코드 
│   ├── 5. 검증데이터셋만들기.ipynb                 # 검증 데이터 정제 및 전처리 코드
│   └── 6. 최종테스트진행및정확도산출.ipynb   #최종 검증 테스트 진행 및 정확도 산출 코드 
│
├── notebooks/                             # 분석과정 및 실험을 기록한 notebook 파일들
│   ├── EDA_택시승강장인기관광지지도시각화.ipynb 
│   ├── EDA_기사성향클러스터링.ipynb            
│   └── 모델 준비_k값 찾기 및 클러스터링.ipynb    
│
├── scripts/                   # 환경 설정 및 데이터 처리 관련 스크립트 파일들
│   ├── setup_environment.sh   # 실행 환경 설정 스크립트
│   ├── preprocess_data.sh     # 데이터 전처리 스크립트
│   └── run_experiment.sh      # 모델 학습 및 평가 수행 스크립트
│
├── demo/                      # 테스트 실행 데모 영상 파일 폴더
│   └── demo_video.mp4         
│
├── figures/                   #시각화 자료 및 영상 파일 폴더
│   ├── 요일시간대별택시수요시각화.png      
│   ├── 기사클러스터링_최적의 k .png      
│   ├── 기사클러스터링_변수중요도.png      
│   ├── 최적k_엘보우_금요일.png      
│   ├── 최적k_실루엣_금요일.png      
│   ├── 최적k_엘보우_주말.png      
│   ├── 최적k_엘보우_주중.png       
│   ├── 클러스터링시각화_금요일.png     
│   ├── 클러스터링시각화_주말.png     
│   ├── 클러스터링시각화_주중.png     
│   ├── 택시수요지도위시각화_금요일.mov    
│   ├── 택시수요지도위시각화_주말.mov         
│   └── 택시수요지도위시각화_주중.mov 
