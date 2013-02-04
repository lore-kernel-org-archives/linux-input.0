From: Daniel J Blueman <daniel@quora.org>
Subject: BCM5974 touchpad issues...
Date: Mon, 4 Feb 2013 11:19:31 +0800
Message-ID: <CAMVG2sssfmUmEuf0=PNDchF-5Nu7-Kf3Gny_ki48DDohKXC5Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42627 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab3BDDTc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 22:19:32 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so5868439obc.26
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 19:19:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I'm seeing erratic click events on Broadcom 5974 touchpads during
two-finger scrolling.

I was wondering where to start to see if this is a userspace or kernel
HID issue.

Thanks,
  Daniel

$ synclient
Parameter settings:
    LeftEdge                = -3898
    RightEdge               = 4428
    TopEdge                 = 434
    BottomEdge              = 6146
    FingerLow               = 70
    FingerHigh              = 75
    FingerPress             = 257
    MaxTapTime              = 180
    MaxTapMove              = 535
    MaxDoubleTapTime        = 180
    SingleTapTimeout        = 180
    ClickTime               = 100
    FastTaps                = 0
    EmulateMidButtonTime    = 0
    EmulateTwoFingerMinZ    = 283
    EmulateTwoFingerMinW    = 7
    VertScrollDelta         = -243
    HorizScrollDelta        = -243
    VertEdgeScroll          = 1
    HorizEdgeScroll         = 0
    CornerCoasting          = 1
    VertTwoFingerScroll     = 1
    HorizTwoFingerScroll    = 1
    MinSpeed                = 1
    MaxSpeed                = 1.75
    AccelFactor             = 0.0164447
    TrackstickSpeed         = 40
    EdgeMotionMinZ          = 30
    EdgeMotionMaxZ          = 160
    EdgeMotionMinSpeed      = 1
    EdgeMotionMaxSpeed      = 972
    EdgeMotionUseAlways     = 0
    TouchpadOff             = 0
    LockedDrags             = 0
    LockedDragTimeout       = 5000
    RTCornerButton          = 2
    RBCornerButton          = 3
    LTCornerButton          = 0
    LBCornerButton          = 0
    TapButton1              = 1
    TapButton2              = 3
    TapButton3              = 2
    ClickFinger1            = 1
    ClickFinger2            = 3
    ClickFinger3            = 0
    CircularScrolling       = 0
    CircScrollDelta         = 0.1
    CircScrollTrigger       = 0
    CircularPad             = 0
    PalmDetect              = 0
    PalmMinWidth            = 10
    PalmMinZ                = 200
    CoastingSpeed           = 20
    CoastingFriction        = 50
    PressureMotionMinZ      = 30
    PressureMotionMaxZ      = 160
    PressureMotionMinFactor = 1
    PressureMotionMaxFactor = 1
    ResolutionDetect        = 1
    GrabEventDevice         = 1
    TapAndDragGesture       = 1
    AreaLeftEdge            = 0
    AreaRightEdge           = 0
    AreaTopEdge             = 0
    AreaBottomEdge          = 0
    HorizHysteresis         = 40
    VertHysteresis          = 27
    ClickPad                = 1
    RightButtonAreaLeft     = 0
    RightButtonAreaRight    = 0
    RightButtonAreaTop      = 0
    RightButtonAreaBottom   = 0
    MiddleButtonAreaLeft    = 0
    MiddleButtonAreaRight   = 0
    MiddleButtonAreaTop     = 0
    MiddleButtonAreaBottom  = 0
-- 
Daniel J Blueman
