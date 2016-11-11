From: Eric Wong <normalperson@yhbt.net>
Subject: Re: BYD TouchPad driver (4.8.1) misdetects a Logitech mouse
Date: Fri, 11 Nov 2016 01:57:57 +0000
Message-ID: <20161111015757.GA10859@dcvr.yhbt.net>
References: <20161015232444.7727e5f78910e8c610019143@michaelshell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161015232444.7727e5f78910e8c610019143@michaelshell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, chris@diamand.org, Michael Shell <list1@michaelshell.org>
List-Id: linux-input@vger.kernel.org

Sorry for the late response, forwarding to Dmitry and linux-input.
I haven't dealt with input in years...

Michael Shell <list1@michaelshell.org> wrote:
> 
> Not a big deal, but something nonetheless ...
> 
> I recently upgraded my kernel from 4.3 to 4.8.1 (this is a Linux From
> Scratch build). There was only one obvious hiccup - X would not
> start because it no longer saw the mouse.
> 
> I have a Logitech RX250 PS2/USB mouse on the PS/2 port (via a USB->PS2
> adapter):
> 
> http://support.logitech.com/en_gb/product/rx250-mouse
> 
> The RX250 is a wheel mouse, but with an added left/right scroll wheel
> "tilt" feature to provide for horizontal scrolling.
> 
> In my xorg.conf I had:
> 
> 
> Section "InputDevice"
>         Identifier      "Mouse0"
>         Driver          "evdev"
>         Option          "Name"  "ImExPS/2 Logitech Explorer Mouse"
> EndSection
> 
> 
> However, under the 4.8.1 kernel, cat /proc/bus/input/devices shows:
> 
> 
> I: Bus=0011 Vendor=0002 Product=0006 Version=0073
> N: Name="ImExPS/2 BYD TouchPad"
> P: Phys=isa0060/serio1/input0
> S: Sysfs=/devices/platform/i8042/serio1/input/input3
> U: Uniq=
> H: Handlers=mouse0 event2 
> B: PROP=1
> B: EV=7
> B: KEY=1f0000 0 0 0 0 0 0 0 0
> B: REL=143
> 
> 
> and dmesg shows the lines:
> 
> 
> psmouse serio1: logips2pp: Detected unknown Logitech mouse model 115
> input: ImExPS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input3
> 
> 
> Changing the mouse name in xorg.conf to "ImExPS/2 BYD TouchPad" did
> allow the mouse to work correctly under X, including the tilt buttons.
> FWIW, in the 4.8.1 kernel config, the byd.c driver does default to
> "Yes", a default which I accepted under make oldconfig.
> 
> Apparently, the detection code (byd_detect) in the new byd.c driver,
> which did not even exist in 4.3, (drivers/input/mouse/byd.c) falsely
> sees the Logitech RX250 as being a BYD TouchPad and thus alters the
> vendor and model names.
> 
> I do not know if it is also desirable to add an entry for a Logitech
> model 115 in get_model_info in logips2pp.c
> (drivers/input/mouse/logips2pp.c). But if so, I would be willing to
> test any such new code. Even as an unknown Logitech model, it does
> work just fine. I am curious as to how the tilt feature buttons would
> be declared in the model info (would these be PS2PP_EXTRA_BTN,
> or PS2PP_NAV_BTN, etc.?)
> 
> 
> 
>   Cheers and thanks in advance,
>   
>   Mike Shell
> 
