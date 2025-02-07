﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// (с) Tolkachev Pavel, 2021-2022
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Инициализирует структуру, описывающую сообщение, полученное от сервиса уведомлений.
// 
// Возвращаемое значение:
//  Структура - структура, описывающая сообщение, полученное от сервиса уведомлений:
//   * Тема - Строка - тема уведомления, используется для фильтрации обработчиков уведомлений.
//   * Оповещение - Структура - структура, описывающая оповещение для отображения пользователю. Если оповещение
//	                            отсутствует, то содержит значение Неопределено. Подробнее см. описание
//	                            ИнициализироватьОповещение.
//   * Данные - Структура - произвольные данные вида "Ключ-Значение", переданные отправителем уведомления. Может
//	                        использоваться в алгоритмах обработчиков уведомлений.
//   * СтандартнаяОбработка - Булево - если содержит значение Истина (устанавливается по умолчанию) и заполнено
//                                     свойство "Оповещение", то будет показано стандартное оповещение пользователю с
//                                     использованием метода ПоказатьОповещениеПользователю. Значение свойства может
//                                     быть установлено в Ложь одним из обработчиков оповещения. В таком случае
//                                     оповещение пользователь показано не будет.
//
Функция ИнициализироватьСообщение() Экспорт
	
	Сообщение = Новый Структура;
	Сообщение.Вставить("Тема", Неопределено);
	Сообщение.Вставить("Оповещение", Неопределено);
	Сообщение.Вставить("Данные", Неопределено);
	Сообщение.Вставить("СтандартнаяОбработка", Истина);
	
	Возврат Сообщение;
	
КонецФункции

// Инициализирует структуру, описывающую оповещение для отображения пользователю.
// 
// Возвращаемое значение:
//  Структура - структуру, описывающая оповещение для отображения пользователю:
//   * Текст - Строка - текст оповещение.
//   * Пояснение - Строка - пояснение оповещения.
//   * Картинка - Картинка - картинка из библиотеки картинок, которая будет показана в оповещении. Отправитель в
//                           оповещении должен передать имя картинки в библиотеке.
//   * Статус - СтатусОповещенияПользователя - определяет важность оповещения пользователя.
//   * ДействиеПриНажатии - Строка - содержит навигационную ссылку, по которой будет выполнен переход при нажатии. Если
//                                   свойство не указано, то ни каких действий при нажатии не выполняется.
//
Функция ИнициализироватьОповещение() Экспорт
	
	Оповещение = Новый Структура;
	Оповещение.Вставить("Текст", "");
	Оповещение.Вставить("Пояснение", "");
	Оповещение.Вставить("Картинка", Неопределено);
	Оповещение.Вставить("Статус", Неопределено);
	Оповещение.Вставить("ДействиеПриНажатии", Неопределено);
	
	Возврат Оповещение;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Создает структуру, описавающую в качестве получателя отдельного пользователя информационной базы.
//
Функция ПолучательПользователь(ИдентификаторПользователя) Экспорт
	
	Получатель = Новый Структура;
	Получатель.Вставить("Type", "user");
	Получатель.Вставить("IbId", ИдентификаторИнформационнойБазы());
	Получатель.Вставить("UserId", ИдентификаторПользователя);
	
	Возврат Получатель;
	
КонецФункции

// Создает структуру, описавающую в качестве получателя сообщения группу пользователей информационной базы.
//
Функция ПолучательГруппаПользователей(ГруппаПользователя) Экспорт
	
	Получатель = Новый Структура;
	Получатель.Вставить("Type", "group");
	Получатель.Вставить("IbId", ИдентификаторИнформационнойБазы());
	Получатель.Вставить("UserGroup", ГруппаПользователя);
	
	Возврат Получатель;
	
КонецФункции

// Создает структуру, описавающую в качестве получателя сообщения всех пользователей информационной базы.
//
Функция ПолучательВсеПользователи() Экспорт
	
	Получатель = Новый Структура;
	Получатель.Вставить("Type", "all");
	Получатель.Вставить("IbId", ИдентификаторИнформационнойБазы());
	
	Возврат Получатель;
	
КонецФункции

Функция СтрокаJSONВСтруктуру(СтрокаJSON) Экспорт
	
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(СтрокаJSON);
	
	Результат = ПрочитатьJSON(ЧтениеJSON);
	
	ЧтениеJSON.Закрыть();
	
	Возврат Результат;
	
КонецФункции

Функция СтруктураВСтрокуJSON(Структура) Экспорт
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	
	ЗаписатьJSON(ЗаписьJSON, Структура);
	
	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает адрес и номер порта сервера выполняющего отправку уведомлений клиентским сеансам 1С.
// Подобнее см. описание функции pns4ones_СервисУведомлений.НастройкиСервераОтправкиУведомлений
//
Функция НастройкиСервераОтправкиУведомлений()
	
#Если Сервер Тогда
	Возврат pns4ones_СервисУведомлений.НастройкиСервераОтправкиУведомлений();
#Иначе
	Возврат pns4ones_СервисУведомленийКлиентПовтИсп.НастройкиСервераОтправкиУведомлений();
#КонецЕсли
	
КонецФункции

// Возвращает идентификатор текущей информационной базы.
// 
// Возвращаемое значение:
//  Строка - идентификатор текущей информационной базы.
//
Функция ИдентификаторИнформационнойБазы()
	
#Если Сервер Тогда
	Возврат pns4ones_СервисУведомленийПереопределяемый.ИдентификаторИнформационнойБазы();
#Иначе
	Возврат pns4ones_СервисУведомленийКлиентПовтИсп.ИдентификаторИнформационнойБазы();
#КонецЕсли
	
КонецФункции

#КонецОбласти