# WeChat-moments
task for learning Swift

task1
1. 在TweetViewModel里面解析json数据
2. 在TweetViewController里面获取解析后的json数据

task2
1. 在TweetViewModel里面获取全部json数据，并进行解析，数据格式返回为数组
2. 在TweetViewController里面对解析后的数据进行筛选，并去除掉无用数据（
error，unknown error, which does not contain a content and images）

task3
1. 链接TweetViewController 和 TweetCell
2. 在TweetCell里面加入subview视图（包括UIimageView以及UIlabel）

task4 
1. 通过autolayout填写布局，需要将tweetCell和UItableViewCell的默认属性ContentView的constraint保持一致
2. 并在contentView里面添加tweetView作为子控件的显示
3. 注意contentView在什么时候生成（layoutSubviews）（不然会get不到contentView的constraint）
4. 需要将tweetCell的数据传到tweetView里面

task5
1. tweetView包含的控件为avater，sender，content，contentImage，comment
2. 由于avater和sender是确定存在的，所以拉出来设定为相对应的UIimageVIew和UIlabel
3. 由于content，contentImage，comment有可能为空，便于图像显示，我们把
content，contentImage,comment作为一个整体 添加到UIstackView上面

task6
1. contentImage为多个。需要通过width进行计算每一个图片的宽度和高度
2. comments也为多个， 需要通过计算来显示相对应地每条评论的高度
3. 给comment的attribute的text进行属性的设定

task7
1. 添加backgroundView的图片以及sender的图片以及user的nameLabel


