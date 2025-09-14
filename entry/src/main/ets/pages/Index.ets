@Entry
@Component
struct main {
  @State events: string[] = [];

  build() {
    Column() {
      List() {
        ForEach(this.events, (item: string, index: number) => {
          ListItem() {
            Button(`事件${index + 1}`)
              .fontSize(18)
              .width('90%')
              .margin({ left: 15 })
              .onClick(() => {
                let uiContext = this.getUIContext();
                uiContext.getRouter().pushUrl({ url: 'pages/Second' })
              })
          }
          .height(60)
          .borderRadius(12)
          .backgroundColor(Color.White)
          .margin({ top: 8, bottom: 8 })
        })
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 1, color: 0xCCCCCC })

      Button('添加事件')
        .width(120)
        .height(40)
        .margin(20)
        .onClick(() => {
          this.events.push(`事件${this.events.length + 1}`);
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
