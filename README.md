**ImageButton** framework is a collection of classes that helps build buttons that constructed solely from images, so you could build buttons with maximum control of it appearance. Current version of framework limited to momentary push buttons.

The main class, ImageButton, is a view that accept images for four state: default, over, pressed and disabled. You have several options to build that images:

- Provide all images directly
- Build images from one compound image, where all images goes one after another using **SliceImageButtonBuilder** class
- Tint template image with different colors using **TintImageButtonBuilder** class
- Tint template image with text using **TintTextImageButtonBuilder** class

Here is the sample on using tint images:

```swift
let imageButton = ImageButton()
let tintImageBuilder = TintImageButtonBuilder()
imageButton.images = tintImageBuilder.buildImagesForImage(NSImage(named: "tint")!)
```

### License

The MIT License (MIT)

Copyright (c) 2015 Dmitry Nikolaev http://dmitrynikolaev.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.