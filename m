From: Sebastian Schmidt <yath@yath.de>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 19:16:25 +0100
Message-ID: <20171230181625.GA1687@marax.lan.yath.de>
References: <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
 <20171230141138.GA23284@marax.lan.yath.de>
 <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
 <20171230144040.GB23284@marax.lan.yath.de>
 <20171230150235.GA19890@kroah.com>
 <4eeea63f-3131-0571-26e4-0f645dd3bc62@canonical.com>
 <20171230152616.GA26378@kroah.com>
 <0eb65344-d160-bb14-723a-1d06ac3e1b33@canonical.com>
 <20171230155358.GE23284@marax.lan.yath.de>
 <02082a9b-8fdd-0878-0daa-ead72743d5fd@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:48914 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdL3SQe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 13:16:34 -0500
Content-Disposition: inline
In-Reply-To: <02082a9b-8fdd-0878-0daa-ead72743d5fd@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Sun, Dec 31, 2017 at 01:37:15AM +0800, Aaron Ma wrote:
> I don't have X1C5 now, but give a quick test on: X1 Yoga 3rd with
> trackpoint (LEN009a), X1 yoga is pretty similar as X1 Carbon on
> trackpoint/touchpad.

Aha, now we’re getting somewhere. Mine actually is LEN0072 (as far as I
can tell from the ACPI DSDT), and the Windows update utility says:
| Pst Vendor : Elan
| [ERROR]: This TrackPoint is Elan (ID:03)

In [1], there are people mentioning that newer Trackpoints changed their
ID from LEN0073 to LEN0072, and a patch[2] for adding that to the RMI
whitelist has been proposed.

Either way, I don’t believe that trackpoint.c is the right driver for
this Trackpoint. Some values are indeed changeable in sysfs, however
without noticeable effect. Setting “thresh” causes the same error as
setting speed; I didn’t check the remaining properties.

> When trackpoint(without the commit) is recognized as "PS/2 Generic
> Mouse", scroll mode does *NOT* work.

I’m not making that up. It does work. And libinput also knows about scrolling.

% xinput list-props "PS/2 Generic Mouse"        
Device 'PS/2 Generic Mouse':
        Device Enabled (142):   1
        Coordinate Transformation Matrix (144): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
        libinput Natural Scrolling Enabled (315):       0
        libinput Natural Scrolling Enabled Default (316):       0
        libinput Left Handed Enabled (317):     0
        libinput Left Handed Enabled Default (318):     0
        libinput Accel Speed (319):     0.000000
        libinput Accel Speed Default (320):     0.000000
        libinput Accel Profiles Available (321):        1, 1
        libinput Accel Profile Enabled (322):   1, 0
        libinput Accel Profile Enabled Default (323):   1, 0
        libinput Scroll Methods Available (324):        0, 0, 1
        libinput Scroll Method Enabled (325):   0, 0, 1
        libinput Scroll Method Enabled Default (326):   0, 0, 1
        libinput Button Scrolling Button (327): 2
                 ^^^^^^^^^^^^^^^^^^^^^^^
        libinput Button Scrolling Button Default (328): 2
        libinput Middle Emulation Enabled (329):        0
        libinput Middle Emulation Enabled Default (330):        0
        libinput Send Events Modes Available (265):     1, 0
        libinput Send Events Mode Enabled (266):        0, 0
        libinput Send Events Mode Enabled Default (267):        0, 0
        Device Node (268):      "/dev/input/event2"
        Device Product ID (269):        2, 1
        libinput Drag Lock Buttons (331):       <no items>
        libinput Horizontal Scroll Enabled (332):       1
%

1: https://forums.lenovo.com/t5/forums/v3_1/forumtopicpage/board-id/Special_Interest_Linux/thread-id/9645/page/16
2: https://lkml.org/lkml/2017/8/18/861
