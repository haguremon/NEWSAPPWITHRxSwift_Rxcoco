import UIKit
import RxSwift
import RxRelay
import PlaygroundSupport

let disposeBag = DisposeBag()

////単一の要素をtoArryaを使って配列に変更する
//Observable.of(1,2,3,4,4,5).toArray()
//    .subscribe(onSuccess: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//Observable.of("a","b","c","d").toArray()
//    .subscribe(onSuccess: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//
////mapを使って要素を変更する
//Observable.of(1,2,3,4,5)
//    .map {
//        $0 * 2
//    }.subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//Observable.of("1","a","2","b")
//    .map {
//        Int($0)//キャストできなかったらnil
//    }.subscribe(onNext: {
//        print($0 ?? 0)
//    })
//    .disposed(by: disposeBag)
//
//print("88888888888888888888888888888")
//
//Observable.of("1","a","2","b")
//    .compactMap {
//        Int($0)//nilは無視する
//    }.subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


//flatmapを使ってみる
struct Student {
    var score: BehaviorRelay<Int>
    var grade: BehaviorRelay<Int>
}

let iwasaki = Student(score: BehaviorRelay(value: 80), grade:  BehaviorRelay(value: 8))
let yuta = Student(score: BehaviorRelay(value: 50), grade: BehaviorRelay(value: 8))

let student = PublishSubject<Student>()
// Observable<Student>Studentを購読可能にする
    /*
     transform the items emitted by an Observable into Observables, then flatten the emissions from those into a single Observable

     */
student.asObservable()
    .flatMapLatest { //API を使用する場合は、ContiguousArray を使用する方がより効率的である場合があります。 Observable<Source.Element>//sourceのエレメントを取得できてる
        $0.score.asObservable()
    }.subscribe(onNext:
                    { print($0)
    })
    .disposed(by: disposeBag)
//イベントを Observable に変換し、常に最新の Observable を利用

student.onNext(iwasaki)
iwasaki.score.accept(200)
student.onNext(yuta)//此処で観察するもの切り替えてみると最新のObservableに変更
iwasaki.score.accept(300)//通知が受けなくなった
yuta.score.accept(40)

print("&^&^&^^^^^^^^^^^^^^^^^^^^^^&^&&^&^&^")
      
print(iwasaki.score.value)//

print(yuta.score.value)//flatMapLatestだと５０

