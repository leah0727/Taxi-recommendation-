#!/bin/bash

# Python 가상 환경 생성
python3 -m venv venv

# 가상 환경 활성화
source venv/bin/activate

# 필수 라이브러리 설치
pip install pandas matplotlib seaborn numpy scikit-learn folium

echo "환경 설정이 완료되었습니다."