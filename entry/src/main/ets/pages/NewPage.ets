import router from '@ohos.router';
import  { preferences}  from '@kit.ArkData';

@Entry
@Component
struct NewPage {

  // 分别存储三个字段的值
  @State eventName: string = "事件名"
  @State timeLength: string = "时间长度"

  @State startTime: string = "开始时间"

  @State tempText: string = "" // 临时存储输入内容
  @State currentType: string = "" // 记录当前点击的按钮类型
  // 类内添加存储实例
  private pref: preferences.Preferences = preferences.getPreferencesSync(this.context, { name: 'EventConfig' });

  async aboutToAppear() { // 新增生命周期方法
    try {
      this.eventName = await this.pref.get('eventName', '事件名');
      this.timeLength = await this.pref.get('timeLength', '时间长度');
      this.startTime = await this.pref.get('startTime', '开始时间');
    } catch (err) {
      console.error(`数据加载失败: ${JSON.stringify(err)}`);
    }
  }
  // 弹窗控制器，显式指定类型
  dialogController: CustomDialogController = new CustomDialogController({
    builder: (): void => this.DialogBuilder(),
    cancel: (): void => console.log("取消弹窗")
  })



  // 为构建器显式指定返回类型
  @Builder
  DialogBuilder(): void {
    Column({ space: 10 }) {
      TextInput({ placeholder: `请输入${this.currentType}` })
        .width('80%')
        .height(50)
        .onChange((value: string): void => {
          this.tempText = value;
        })

      Button('确认修改')
        .onClick(async (): Promise<void> => {
          switch(this.currentType) {
            case "事件名":
              this.eventName = this.tempText;
              await this.pref.put("eventName", this.tempText);
              break;
            case "时间长度":
              this.timeLength = this.tempText;
              await this.pref.put("timeLength", this.tempText);
              break;
            case "开始时间":
              this.startTime = this.tempText;
              await this.pref.put("startTime", this.tempText);
              break;
          }
          await this.pref.flush(); // 确保数据持久化
          this.tempText = "";
          this.dialogController.close();
        })
    }
    .padding(20)
    .width('90%')
  }

  // 为build方法显式指定返回类型
  build(): void {
    Column() {
      // 事件名按钮
      Button(this.eventName)
        .fontSize(20)
        .width('90%')
        .margin({ top: 30, bottom: 50 })
        .onClick((): void => {
          this.currentType = "事件名";
          this.tempText = this.eventName;
          this.dialogController.open();
        })

      // 时间长度按钮
      Button(this.timeLength)
        .fontSize(20)
        .width('90%')
        .margin({ bottom: 50 })
        .onClick((): void => {
          this.currentType = "时间长度";
          this.tempText = this.timeLength;
          this.dialogController.open();
        })

      // 开始时间按钮
      Button(this.startTime)
        .fontSize(20)
        .width('90%')
        .margin({ bottom: 50 })
        .onClick((): void => {
          this.currentType = "开始时间";
          this.tempText = this.startTime;
          this.dialogController.open();
        })

      // 返回按钮
      Button('返回')
        .onClick((): void => {
          router.back();
        })
    }
    .width('100%')
    .height('100%')
    .padding({ top: 100 })
  }
}
