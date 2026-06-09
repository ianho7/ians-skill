# Newmasus 风格图像生成 Skill

## 适用场景
当用户想生成、改写或扩展 Newmasus 风格插画提示词时使用。适用于 GPT Image / GPT Image 2 / 其他图像模型的提示词编写。

## 风格核心
Newmasus 风格是一种手绘儿童插画感、蜡笔/油画棒质感、粗黑轮廓、卡通化人物、明亮饱和色彩、温暖轻松情绪的插画风格。

生成提示词时，优先强调：
- 粗黑色蜡笔轮廓
- 油画棒/蜡笔纹理
- 手绘、不均匀上色、纸面颗粒感
- 卡通化人物或主体
- 简化五官：竖线眼睛、线条嘴巴、简化鼻子
- 圆润大头比例，身体比例偏小
- 表情生动、轻松、快乐
- 色彩明亮、饱和、温暖
- 背景简化为几何色块、基础场景或抽象环境
- 可加入蓝色小爱心、涂鸦符号、小物件等象征性元素

## 通用主提示词模板
根据用户主题，将 `[主题/主体]`、`[动作]`、`[场景]` 替换为具体内容：

用 Newmasus 风格绘制一幅 `[主题/主体]` 插画，主体正在 `[动作]`，背景是 `[场景]`。画面采用粗黑色蜡笔轮廓，整体像手绘蜡笔画和油画棒插画，保留明显的笔触、纸面颗粒、不均匀涂色和粗糙边缘。主体卡通化，比例圆润可爱，头部偏大，身体简化；五官极简，使用竖线眼睛、线条嘴巴、简化鼻子，表情生动、轻松、快乐。色彩明亮、饱和、温暖，使用大色块和强对比色。背景简化为几何色块、基础场景和涂鸦式细节，不追求真实透视。可加入蓝色小爱心、手写涂鸦、小图标、小物件等象征性元素。整体氛围温暖、童趣、松弛、治愈、街头手绘感。

## 英文主提示词模板
Create an illustration in a Newmasus-inspired style of `[subject/theme]` doing `[action]` in `[scene]`. Use thick black crayon outlines, hand-drawn crayon and oil pastel texture, visible rough strokes, paper grain, uneven coloring, and slightly messy edges. The subject should be cartoonish, rounded and cute, with a large head and simplified body proportions. Use minimal facial features: vertical line eyes, simple line mouth, simplified nose, and an expressive, relaxed, joyful expression. Use bright, saturated, warm colors, large color blocks, and strong contrast. Simplify the background into geometric shapes, basic scenery, and doodle-like details rather than realistic perspective. Add small symbolic elements such as a blue heart, handwritten doodles, little icons, or meaningful objects. The overall mood should feel warm, playful, cozy, childlike, lighthearted, healing, and street-art hand-drawn.

## 强化关键词
可根据需要加入以下短语：
- thick black crayon outlines
- oil pastel texture
- crayon drawing
- hand-drawn children’s illustration
- naive art
- childlike drawing
- playful cartoon character
- simplified facial features
- vertical line eyes
- round head proportion
- bright saturated colors
- rough hand-drawn texture
- uneven coloring
- paper grain
- geometric color blocks
- doodle symbols
- blue heart icon
- cozy, cheerful, joyful, lighthearted

## 负面提示词
当用户要求更像参考风格时，可加入：

避免写实摄影感、3D渲染、精致数字插画、过度光影、复杂透视、真实皮肤纹理、细密五官、真实解剖结构、赛博朋克高科技质感、光滑矢量图、干净商业扁平插画、过度锐利线条、过度精细背景。

英文：
Avoid photorealism, 3D rendering, polished digital painting, cinematic lighting, complex perspective, realistic skin texture, detailed facial features, realistic anatomy, glossy vector art, clean corporate flat illustration, overly sharp lines, and overly detailed background.

## 使用规则
1. 不要只输出关键词，要输出完整可复制提示词。
2. 用户给出主题后，自动把主题融入模板。
3. 用户没给动作或场景时，补一个合理的动作和简化背景。
4. 保持画面简单、情绪明确、主体突出。
5. 若用户要 logo，应减少背景细节，强调中心主体、圆形构图、可识别轮廓、简洁色块。
6. 若用户要技术/软件/服务器主题，应把服务器、告警、监控面板、数据线、云图标等元素转化为童趣涂鸦符号，而不是写实科技 UI。
7. 若用户要宠物或物品，也使用同样的粗黑轮廓、圆润比例、简化表情和油画棒质感。

## 输出格式
优先输出：

```text
[完整中文提示词]
```

如用户要求英文，再输出英文版本。

## 示例

### 服务器 RCA Agent Logo
```text
用 Newmasus 风格绘制一个适合作为软件 Logo 的服务器 RCA Agent 图标，主体是一只圆润可爱的白色信鸽机器人，正在守护一台小服务器，旁边有简化的告警波形、云图标、数据线和蓝色小爱心。画面采用圆形构图，主体居中，轮廓清晰，背景保持简洁。使用粗黑色蜡笔轮廓，整体像手绘蜡笔画和油画棒插画，保留明显的笔触、纸面颗粒、不均匀涂色和粗糙边缘。主体卡通化，头部偏大，身体简化；五官极简，使用竖线眼睛和线条嘴巴，表情可靠、轻松、友好。色彩明亮、饱和、温暖，使用大色块和强对比色。整体氛围童趣、温暖、技术感但不冰冷，适合作为软件应用图标。
```

### 篮球运动员
```text
用 Newmasus 风格绘制一幅篮球运动员扣篮的插画，背景是简化的篮球场和欢呼观众。画面采用粗黑色蜡笔轮廓，整体像手绘蜡笔画和油画棒插画，保留明显的笔触、纸面颗粒、不均匀涂色和粗糙边缘。人物卡通化，头部偏大，身体简化；五官极简，使用竖线眼睛、线条嘴巴、简化鼻子，表情自信、快乐、有活力。色彩明亮、饱和、温暖，使用大色块和强对比色。背景简化为几何色块和涂鸦式观众，不追求真实透视。加入蓝色小爱心、速度线和手写涂鸦符号。整体氛围热烈、童趣、松弛、街头手绘感。
```
