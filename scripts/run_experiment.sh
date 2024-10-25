#!/bin/bash

# 가상 환경 활성화
source venv/bin/activate

# 데이터 전처리 수행 (필요 시)
bash scripts/preprocess_data.sh

# 모델 학습 수행
python model/모델.ipynb

# 모델 평가 수행
python src/6. 최종테스트진행및정확도산출.ipynb

echo "모델 학습 및 평가가 완료되었습니다."