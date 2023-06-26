//
//  Question.swift
//  PersonalQuiz
//
//  Created by Кирилл on 17.06.2023.
//

struct Question {
    let title: String
    let responseType: ResponseType
    let answers: [Answer]
    
    static func getQestion() -> [Question] {
        [
            Question(
                title: "Какую пищу вы предпочитаете",
                responseType: .single,
                answers: [
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle)
                ]
            ),
            Question(
                title: "Что вам нравиться больше",
                responseType: .multiple,
                answers: [
                    Answer(title: "Плавать", animal: .dog),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Обниматься", animal: .rabbit),
                    Answer(title: "Есть", animal: .turtle)
                ]
            ),
            Question(
                title: "Любите ли вы поездки на машине",
                responseType: .range,
                answers: [
                    Answer(title: "Ненавижу", animal: .cat),
                    Answer(title: "Нервничаю", animal: .rabbit),
                    Answer(title: "Незамечаю", animal: .turtle),
                    Answer(title: "Обажаю", animal: .dog)
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case range
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравиться быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цните одиночество."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны иэнергиию"
        case .turtle:
            return "Ваша сила - в мудрости. Медленный и вдумчевый выигрывает на больших дистанциях"
        }
    }
}
