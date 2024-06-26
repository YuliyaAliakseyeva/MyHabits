//
//  Information.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 10.04.24.
//

import UIKit

public struct Information {
    public var text: String
}

extension Information {
    public static func make () -> Information {
        Information(text: "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, заданная на перспективу, находится на расстоянии шага.\n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги - что оказалось тяжело: что - легче: с чем еще предстоит серьезно бороться.\n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n\n5. Держать планку 40 дней. Практикующий методику уже чувствует освободившимся от прошлого негатива и движется в нужном направлении с хорошей динамикой.\n\n6. На 90-й день соблюдения техники все лишнее из прошлой жизни перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.\n\nИсточник: psychbook.ru")
        
    }
}
