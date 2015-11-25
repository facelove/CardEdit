/**
 *  cissu 28/10/2012.
 *
 *  Copyright (c) 2010-2011, cissu
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *  Redistributions of source code must retain the above copyright notice,
 *  this list of conditions and the following disclaimer.
 *
 *  Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *
 *  Neither the name of this project's author nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */
#import <UIKit/UIKit.h>

#define getx(view)             view.frame.origin.x
#define gety(view)             view.frame.origin.y
#define getwidth(view)         view.frame.size.width
#define getheight(view)        view.frame.size.height

#define gx(view)                getx(view)//!获取view x坐标
#define gy(view)                gety(view)//!获取view y坐标
#define gw(view)                getwidth(view)//!获取view 宽度
#define gh(view)                getheight(view)//!获取view 高度
#define gs(view)                view.frame.size//!获取view size
#define go(view)                view.frame.origin//!获取view origin
#define gb(view)                (gety(view) + getheight(view))//!获取view的下边沿y坐标
#define gr(view)                (getx(view) + getwidth(view))//!获取view的右边沿x坐标
#define gcy(view)               view.center.y//获取VIew中心的Y
#define gcx(view)               view.center.x//获取VIew中心的x


#define ss(view,size)           set_size(view,size)//!设置view size
#define so(view,origin)         set_origin(view,origin)//!设置view origin
#define svs(view,scale)         set_view_scale_size(view,scale)//!缩放view宽高, scale分之一

#define sx(view,x)              set_x(view,x)//!设置view x
#define sy(view,y)              set_y(view,y)//!设置view y
#define sw(view,w)              set_width(view,w)//!设置view宽
#define sh(view,h)              set_height(view,h)//!设置view高

/**
 *  色彩值
 */
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBCOLOR(r,g,b)     RGBACOLOR(r, g, b, 1.0f)

#ifdef DEBUG
#define  DNSLog(...)  NSLog(__VA_ARGS__)
#endif
static inline void set_size(UIView * view, CGSize size)
{
    CGRect frame = view.frame;
    frame.size = size;
    view.frame = frame;
}

static inline void set_origin(UIView * view, CGPoint origin)
{
    CGRect frame = view.frame;
    frame.origin = origin;
    view.frame = frame;
}

static inline void set_x(UIView * view, CGFloat x)
{
    CGRect frame = view.frame;
    frame.origin = CGPointMake(x,gy(view));
    view.frame = frame;
}

static inline void set_y(UIView * view, CGFloat y)
{
    CGRect frame = view.frame;
    frame.origin = CGPointMake(gx(view),y);
    view.frame = frame;
}

static inline void set_width(UIView * view, CGFloat width)
{
    CGRect frame = view.frame;
    frame.size = CGSizeMake(width,gh(view));
    view.frame = frame;
}

static inline void set_height(UIView * view, CGFloat height)
{
    CGRect frame = view.frame;
    frame.size = CGSizeMake(gw(view),height);
    view.frame = frame;
}

static inline void set_view_scale_size(UIView * view, int scale)
{
    if (!scale)
        return;
    set_size(view,CGSizeMake(gw(view)/scale,gh(view)/scale));
}

static inline void set_inside_right_origin_x(UIView * parent, UIView * child, CGFloat size)
{
    set_x(child,gw(parent)-gw(child)-size);
}

#define set_inside_top_origin_y(child,size)    set_y(child,size)

#define set_inside_left_origin_x(child, size)    set_x(child,size)

static inline void set_inside_bottom_origin_y(UIView * parent, UIView * child, CGFloat size)
{
    set_y(child,gh(parent)-gh(child)-size);
}


#define sixr2r(parent,child,size)   set_inside_right_origin_x(parent,child,size)//!设置child相对父view右边size x坐标
#define sixl2l(child,size)          set_inside_left_origin_x(child,size)//!设置child相对父view左边size x坐标
#define siyt2t(child,size)          set_inside_top_origin_y(child,size)//!设置child相对父view上边size y坐标
#define siyb2b(parent,child,size)   set_inside_bottom_origin_y(parent,child,size)//!设置child相对父view下边size y坐标

#define ssxr2l(child,size)          sixr2l(self,child,size)//!设置child相对self view 右边size x坐标
#define ssyb2t(child,size)          siyb2t(self,child,size)//!设置child相对self view 下边size y坐标

static inline void set_inside_center_origin_x(UIView * parent, UIView * child, CGFloat size)
{
    set_x(child,gw(parent)/2-gw(child)/2+size);
}

static inline void set_inside_center_origin_y(UIView * parent, UIView * child, CGFloat size)
{
    set_y(child,gh(parent)/2-gh(child)/2+size);
}

#define center_inside_view(parent,child)    \
set_inside_center_origin_x(parent,child,0); \
set_inside_center_origin_y(parent,child,0)


#define sicx(parent,child,size)     set_inside_center_origin_x(parent,child,size)//!设置child相对父view中心 x size坐标
#define sicy(parent,child,size)     set_inside_center_origin_y(parent,child,size)//!设置child相对父view中心 y size坐标
#define sicc(parent,child)          center_inside_view(parent,child)//!设置child相对父view中心坐标

#define sscx(child,size)            sicx(self,child,size)
#define sscy(child,size)            sicy(self,child,size)
#define sscc(child)                 sicc(self,child)

static inline void set_relative_origin_x_left_to_left(UIView * left, UIView * right, CGFloat size)
{
    sx(right,gx(left)+size);
}

static inline void set_relative_origin_x_right_to_left(UIView * left, UIView * right, CGFloat size)
{
    sx(right,gx(left)+gw(left)+size);
}

static inline void set_relative_origin_y_bottom_to_top(UIView * up, UIView * down, CGFloat size)
{
    sy(down,gy(up)+gh(up)+size);
}

static inline void set_relative_origin_y_top_to_top(UIView * up, UIView * down, CGFloat size)
{
    sy(down,gy(up)+size);
}

#define srxl2l(left,right,size)     set_relative_origin_x_left_to_left(left,right,size)//!设置相对左边view x到右边view size x坐标
#define srxr2l(left,right,size)     set_relative_origin_x_right_to_left(left,right,size)//!设置相对左边view 右边x到右边view size x坐标
static inline void srxr2r(UIView * primary, UIView * besetview, CGFloat offset)
{
    set_x(besetview, gx(primary) + gw(primary) - gw(besetview) - offset);
}

static inline void srxl2r(UIView * primary, UIView * besetview, CGFloat offset)
{
    set_x(besetview, gx(primary) - gw(besetview) - offset);
}

#define sryb2t(up,down,size)        set_relative_origin_y_bottom_to_top(up,down,size)//!设置相对上边view 底部y到下边view size y坐标
#define sryt2t(up,down,size)        set_relative_origin_y_top_to_top(up,down,size)//!设置相对上边view y到下边view size y坐标

static inline void sryb2b (UIView * besetview, UIView * primary, CGFloat offset)
{
    set_y(besetview, gb(primary)-gh(besetview)-offset);
}

static inline void sryt2b (UIView * besetview, UIView * primary, CGFloat offset)
{
    set_y(besetview, gy(primary)-gh(besetview)-offset);
}

static inline void set_relative_center_origin_y(UIView * primary, UIView * besetview, CGFloat size)
{
    sy(besetview, gy(primary) + gh(primary)/2 - gh(besetview)/2 + size);
}

static inline void set_relative_center_origin_x(UIView * primary, UIView * besetview, CGFloat size)
{
    sx(besetview, gx(primary) + gw(primary)/2 - gw(besetview)/2 + size);
}

#define srcx(primary, besetview, size)  set_relative_center_origin_x(primary, besetview, size)//!设置相对主view x中心besetview 偏移size x坐标
#define srcy(primary, besetview, size)  set_relative_center_origin_y(primary, besetview, size)//!设置相对主view y中心besetview 偏移size y坐标

#define srcc(primary, besetview) \
srcx(primary, besetview, 0); \
srcy(primary, besetview, 0)

/*--------兼容老的设置view坐标 start--------*/

// 命令由前缀操作词，主语，介词， 宾语， 后缀组成
//      主语和宾语都可加后缀
/*前缀： s: set;
 g: get;
 主语   x: frame.origin.x
 y: frame.origin.y
 w: width
 h: hight
 c: center, if a line, it's middle.
 o: origin
 s: size
 
 介词： by: one by one,  same level
 in: one in one,  it's or will be a subview of another view
 2: to
 宾语  同主语
 
 后缀： h: head default is ignored
 c: center
 t: tail。 width of height
 i: in
 is: in supper view
 f: by float value
 p: by point value
 s: size
 sc: scale
 */
/*
 坐标计算公式：
 manipulatedView: m;
 anotherView: a;
 by: m.x = a.x + a.w * (0～1) + offset;
 in: m.x = a.w * (0～1) + offset;
 
 目前请提供了常用的三个比例：head = 0; center = 0.5; tail = 1;
 若有需要，请修改HzPoints为为float及其计算方式,(因为实现中枚举不能为小数,故默认传入值/2)。
 */

#define sxc2cis(subView, offset)            sicx(subView.superview, subView, offset)

#define syc2cis(subView, offset)            sicy(subView.superview, subView, offset)

#define sxt2tis(subView, offset)            sixr2r(subView.superview, subView, -1 * (offset));

#define syt2tis(subView, offset)            siyb2b(subView.superview, subView, -1 * (offset));

/*--------兼容老的设置view坐标 end--------*/

#define clearViewColor(view)     [view setBackgroundColor:[UIColor clearColor]]

CGSize screenSize(void);

static inline float get_status_bar_height()
{
    BOOL status_hide = [[UIApplication sharedApplication] isStatusBarHidden];
    if (status_hide)
        return 0;
    CGRect status_bar_frame = [[UIApplication sharedApplication] statusBarFrame];
    return MIN(status_bar_frame.size.height, status_bar_frame.size.width);
}

static inline bool isPortrait()
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    return UIInterfaceOrientationIsPortrait(orientation);
}

static inline CGPoint absolutePoint(UIView * view)
{
    CGPoint size = CGPointZero;
    UIView * rootView = view;
    for (;rootView;)
    {
        size.y += gy(rootView);
        size.x += gx(rootView);
        rootView = rootView.superview;
    }
    return size;
}

UIImage * imageWithColor(UIColor * color);

#pragma mark - QYLog
#if DEBUG
#define QYLog(...) NSLog(__VA_ARGS__)
#else
#define QYLog(...)
#endif


#define COLOR_FROM_4HEX(__X__,__Y__,__Z__,__A__)            [UIColor colorWithRed:0x ## __X__ / 255.0 green:0x ## __Y__ / 255.0 blue:0x ## __Z__ / 255.0 alpha:__A__]
#define COLOR_FROM_3HEX(__X__,__Y__,__Z__)                  COLOR_FROM_4HEX(__X__,__Y__,__Z__,1)

#define kIsPhone6           (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 375)
#define kIsPhone6Plus       (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 414)
