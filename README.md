# 2024-NC2-M23-MachineLearning
[Apple Developer Academy @ POSTECH '24] Sindy &amp; Mia
## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About Machine Learning

### Machine Learning (ML) 은 무엇인가요? ****

- 확률적 알고리즘을 활용해서 ML Model을 구축하고, Model에 데이터를 넣고 학습시키면, Model에 input을 제공했을때 그에 맞는 output을 반환합니다.
- 예: 사람 얼굴 사진으로 성별을 분별하는 Model을 학습 시키면, Model이 처음 보는 사람 사진을 받았을때 남녀 구분을 할 수 있습니다.

### Apple이 제공하는 ML Framework (iOS 17 기준)

💡Tip: Apple의 ML Framework은 on-device ML이 가능하게 도와줍니다. (On-device: 사용자의 데이터를 클라우드 서버로 보내어 ML Model을 돌리지 않고, 기기에 ML을 탑재하여 ML process가 기기안에서 이루어집니다. 사용자 데이터 프라이버시를 지키는데 효과적이죠…)

개발자들이 Apple 기기에 on-device ML을 활용할 수 있도록 도와주는 3가지 방법/분야(?)가 있습니다. 

1. `CreateML`
    
    → iOS 개발자가 직접 ML Model을 학습할 수 있도록 도와주는 Framework
    
2. `CoreML`
    
    → ML Model을 앱에 실행하고 실행중 fine-tuning할 수 있게 도와주는 Framework. CreateML로 만든 Model 뿐만이 아니라, PyTorch, TensorFlow library 등으로 구축된 Model도 변환해서 사용할 수 있다.
    
3. `ML APIs`
    
    → Apple에서 이미 학습시킨 Model을 API로 사용할 수 있다. 분야는 Vision, Natural Language, Speech, Sound, Translation.

## 🎯 What we focus on?
CoreMLTools를 사용해서 PyTorch Library를 iOS 기기에 탑재할 수 있도록 변환시키고 앱에 탑재하여 사용하자!

### ❓이유
오픈소스 커뮤니티에 다양하고 재밌는 Model들이 많습니다. 이후 프로젝트에 ML Model이 필요하다면,직접 Model을 구축하는것 보다 (Model 구축에는 엄청난 processing power와 데이터가 필요하기에..!), 기존에 있는 Model을 쓰게될것 같았습니다. 그래서, model을 변환하고 앱에 탑재하는것을 시도해 보기로 했습니다!

## 💼 Use Case
간단한 내기나 술자리에서 주어진 랜덤 감정을 연기하면 모델이 표정을 분석해주고, 감정을 잘 연기한 순위를 매겨 꼴찌를 정할 수 있는 게임을 만들어보자!

## 🖼️ Prototype
(프로토타입과 설명 추가)

## 🛠️ About Code
(핵심 코드에 대한 설명 추가)
