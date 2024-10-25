#!/bin/bash

# Jupyter Notebook을 Python 스크립트로 변환 및 실행
jupyter nbconvert --to script src/1. 전처리_날짜필터링및결측값제거.ipynb --output preprocess_step1.py
jupyter nbconvert --to script src/2. 전처리_기온강수량추가및데이터분할.ipynb --output preprocess_step2.py
jupyter nbconvert --to script src/3. 전처리_공휴일추가후최종전처리데이터.ipynb --output preprocess_step3.py
jupyter nbconvert --to script src/4. 활용데이터전처리_인기관광지택시승강장.ipynb --output preprocess_step4.py
jupyter nbconvert --to script src/5. 검증데이터셋만들기.ipynb   --output preprocess_step5.py

# 전처리 단계별 실행
python preprocess_step1.py
python preprocess_step2.py
python preprocess_step3.py
python preprocess_step4.py
python preprocess_step5.py

echo "데이터 전처리가 완료되었습니다."