From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Annoying touchpad behavior
Date: Sat, 12 Nov 2011 12:15:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1111121210500.9110-100000@netrider.rowland.org>
References: <20111112060505.GA20411@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:58864 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754824Ab1KLRPB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 12:15:01 -0500
In-Reply-To: <20111112060505.GA20411@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, 11 Nov 2011, Dmitry Torokhov wrote:

> Hi Alan,
> 
> On Fri, Nov 11, 2011 at 11:10:46PM -0500, Alan Stern wrote:
> > Dmitry:
> > 
> > My laptop has a Synaptics touchpad:
> > 
> > [    2.528474] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04731/0xa40000/0xa0000
> > [    2.566383] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input4
> > 
> > Under circumstances which I can't pin down (they generally involve my
> > thumb brushing over the trackpad, which happens fairly often as I
> > type), the touchpad reports a right-click.  This causes gnome-terminal
> > to pop up its menu, which is very annoying.
> > 
> > Why does the trackpad report a right-click instead of a normal 
> > left-click?  How can I fix this?
> 
> You probably have corner taps or multi-finger taps enabled on your box.
> What does "synclient' has to say about your setup?

Here's the output from "synclient -l":

Parameter settings:
    LeftEdge                = 1762
    RightEdge               = 5334
    TopEdge                 = 1642
    BottomEdge              = 4520
    FingerLow               = 24
    FingerHigh              = 29
    FingerPress             = 255
    MaxTapTime              = 180
    MaxTapMove              = 234
    MaxDoubleTapTime        = 180
    SingleTapTimeout        = 180
    ClickTime               = 100
    FastTaps                = 0
    EmulateMidButtonTime    = 75
    EmulateTwoFingerMinZ    = 29
    EmulateTwoFingerMinW    = 7
    VertScrollDelta         = 106
    HorizScrollDelta        = 106
    VertEdgeScroll          = 1
    HorizEdgeScroll         = 0
    CornerCoasting          = 0
    VertTwoFingerScroll     = 0
    HorizTwoFingerScroll    = 0
    MinSpeed                = 1
    MaxSpeed                = 1.75
    AccelFactor             = 0.0375094
    TrackstickSpeed         = 40
    EdgeMotionMinZ          = 29
    EdgeMotionMaxZ          = 159
    EdgeMotionMinSpeed      = 1
    EdgeMotionMaxSpeed      = 426
    EdgeMotionUseAlways     = 0
    TouchpadOff             = 0
    LockedDrags             = 0
    LockedDragTimeout       = 5000
    RTCornerButton          = 0
    RBCornerButton          = 0
    LTCornerButton          = 0
    LBCornerButton          = 0
    TapButton1              = 1
    TapButton2              = 3
    TapButton3              = 2
    ClickFinger1            = 1
    ClickFinger2            = 1
    ClickFinger3            = 1
    CircularScrolling       = 0
    CircScrollDelta         = 0.1
    CircScrollTrigger       = 0
    CircularPad             = 0
    PalmDetect              = 0
    PalmMinWidth            = 10
    PalmMinZ                = 199
    CoastingSpeed           = 20
    CoastingFriction        = 50
    PressureMotionMinZ      = 29
    PressureMotionMaxZ      = 159
    PressureMotionMinFactor = 1
    PressureMotionMaxFactor = 1
    GrabEventDevice         = 1
    TapAndDragGesture       = 1
    AreaLeftEdge            = 0
    AreaRightEdge           = 0
    AreaTopEdge             = 0
    AreaBottomEdge          = 0

A few of the fields are suggestive, but I don't really understand much
of it.  If you need anything else, let me know.

Alan Stern

