From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 14:43:16 +0800
Message-ID: <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
References: <20171228091125.GA743@marax.lan.yath.de>
 <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
 <20171228142855.GA2007@marax.lan.yath.de>
 <f1fb1612-2d16-25a4-b57e-c56a01b729c2@canonical.com>
 <20171229190529.GA2108@marax.lan.yath.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40036 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdL3GnX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 01:43:23 -0500
In-Reply-To: <20171229190529.GA2108@marax.lan.yath.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Schmidt <yath@yath.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Please try:
$ xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -1

The last value of speed can be -1 to 1.

Regards,
Aaron

On 12/30/2017 03:05 AM, Sebastian Schmidt wrote:
> On Thu, Dec 28, 2017 at 11:53:44PM +0800, Aaron Ma wrote:
>> The set on sysfs "speed" will execute the following code:
>> 1, set #define PSMOUSE_CMD_DISABLE     0x00f5;
>> 2, set #define TP_SPEED                0x60    /* Speed of TP Cursor */
>> with the value in speed.
>> 3, set #define PSMOUSE_CMD_ENABLE      0x00f4
>>
>> When set 3rd step, it fails to write the cmd to ps2dev.
>> This issue should be related to trackpoint firmware that response on all
>> commands.
> 
> Sorry, I’m not sure I can follow. Is this a bug in my Trackpoint
> firmware and I need to update it?
> 
>> And for the trackpoint is too fast or sensitive, please change it in
>> setting of gnome (I assume you are using), the setting will use the
>> libinput(wayland) and xerver-input-synaptics driver to set the mouse
>> speed. It should be worked as expected.
> 
> Are you saying the sysfs settings are not supposed to work? From a
> user’s perspective I’ve upgraded my kernel (to a stable version, into
> which that patch was merged), found my mouse too fast and a knob called
> “speed” in sysfs. Just touching that knob (by echoing the same value)
> broke my mouse entirely, and that’s the problem I’m reporting.
> 
> I’m using i3 on “plain” Xorg, no Wayland or any desktop environment.
> synclient only appears to have options for the touchpad, as far as I can
> tell from the names:
> % synclient 
> Parameter settings:
>     LeftEdge                = 77
>     RightEdge               = 1859
>     TopEdge                 = 57
>     BottomEdge              = 1000
>     FingerLow               = 25
>     FingerHigh              = 30
>     MaxTapTime              = 180
>     MaxTapMove              = 97
>     MaxDoubleTapTime        = 180
>     SingleTapTimeout        = 180
>     ClickTime               = 100
>     EmulateMidButtonTime    = 0
>     EmulateTwoFingerMinZ    = 282
>     EmulateTwoFingerMinW    = 7
>     VertScrollDelta         = 44
>     HorizScrollDelta        = 44
>     VertEdgeScroll          = 0
>     HorizEdgeScroll         = 0
>     CornerCoasting          = 0
>     VertTwoFingerScroll     = 1
>     HorizTwoFingerScroll    = 0
>     MinSpeed                = 1
>     MaxSpeed                = 1.75
>     AccelFactor             = 0.090703
>     TouchpadOff             = 0
>     LockedDrags             = 0
>     LockedDragTimeout       = 5000
>     RTCornerButton          = 0
>     RBCornerButton          = 0
>     LTCornerButton          = 0
>     LBCornerButton          = 0
>     TapButton1              = 0
>     TapButton2              = 0
>     TapButton3              = 0
>     ClickFinger1            = 1
>     ClickFinger2            = 3
>     ClickFinger3            = 2
>     CircularScrolling       = 0
>     CircScrollDelta         = 0.1
>     CircScrollTrigger       = 0
>     CircularPad             = 0
>     PalmDetect              = 0
>     PalmMinWidth            = 10
>     PalmMinZ                = 200
>     CoastingSpeed           = 20
>     CoastingFriction        = 50
>     PressureMotionMinZ      = 30
>     PressureMotionMaxZ      = 160
>     PressureMotionMinFactor = 1
>     PressureMotionMaxFactor = 1
>     GrabEventDevice         = 0
>     TapAndDragGesture       = 1
>     AreaLeftEdge            = 0
>     AreaRightEdge           = 0
>     AreaTopEdge             = 0
>     AreaBottomEdge          = 0
>     HorizHysteresis         = 11
>     VertHysteresis          = 11
>     ClickPad                = 1
>     RightButtonAreaLeft     = 968
>     RightButtonAreaRight    = 0
>     RightButtonAreaTop      = 866
>     RightButtonAreaBottom   = 0
>     MiddleButtonAreaLeft    = 0
>     MiddleButtonAreaRight   = 0
>     MiddleButtonAreaTop     = 0
>     MiddleButtonAreaBottom  = 0
> %
> 
> The xinput properties don’t show a (non-zero) speed either:
> % xinput list-props "TPPS/2 IBM TrackPoint"
> Device 'TPPS/2 IBM TrackPoint':
>         Device Enabled (142):   1
>         Coordinate Transformation Matrix (144): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
>         libinput Natural Scrolling Enabled (326):       0
>         libinput Natural Scrolling Enabled Default (327):       0
>         libinput Left Handed Enabled (328):     0
>         libinput Left Handed Enabled Default (329):     0
>         libinput Accel Speed (330):     0.000000
>         libinput Accel Speed Default (331):     0.000000
>         libinput Accel Profiles Available (332):        1, 1
>         libinput Accel Profile Enabled (333):   1, 0
>         libinput Accel Profile Enabled Default (334):   1, 0
>         libinput Scroll Methods Available (335):        0, 0, 1
>         libinput Scroll Method Enabled (336):   0, 0, 1
>         libinput Scroll Method Enabled Default (337):   0, 0, 1
>         libinput Button Scrolling Button (338): 2
>         libinput Button Scrolling Button Default (339): 2
>         libinput Middle Emulation Enabled (340):        0
>         libinput Middle Emulation Enabled Default (341):        0
>         libinput Send Events Modes Available (265):     1, 0
>         libinput Send Events Mode Enabled (266):        0, 0
>         libinput Send Events Mode Enabled Default (267):        0, 0
>         Device Node (268):      "/dev/input/event17"
>         Device Product ID (269):        2, 10
>         libinput Drag Lock Buttons (342):       <no items>
>         libinput Horizontal Scroll Enabled (343):       1
> %
> 
> Thanks,
> Sebastian
> 
