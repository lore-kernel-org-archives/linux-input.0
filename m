From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Annoying touchpad behavior
Date: Sat, 12 Nov 2011 16:58:54 -0800
Message-ID: <20111113005854.GA10446@core.coreip.homeip.net>
References: <CAGS+omA3XM9HOsPZ-UbQ8RX3bQWe9SDKYtZadfLtkdMj00E+6Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1111121529400.11486-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:59986 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab1KMA7D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 19:59:03 -0500
Received: by pzk36 with SMTP id 36so8289456pzk.1
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2011 16:59:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1111121529400.11486-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Kurtz <djkurtz@google.com>, linux-input@vger.kernel.org

On Sat, Nov 12, 2011 at 03:35:24PM -0500, Alan Stern wrote:
> On Sun, 13 Nov 2011, Daniel Kurtz wrote:
> 
> > Hi Alan,
> > 
> > On Sun, Nov 13, 2011 at 1:15 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Fri, 11 Nov 2011, Dmitry Torokhov wrote:
> > >
> > >> Hi Alan,
> > >>
> > >> On Fri, Nov 11, 2011 at 11:10:46PM -0500, Alan Stern wrote:
> > >> > Dmitry:
> > >> >
> > >> > My laptop has a Synaptics touchpad:
> > >> >
> > >> > [ ? ?2.528474] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04731/0xa40000/0xa0000
> > >> > [ ? ?2.566383] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input4
> > >> >
> > >> > Under circumstances which I can't pin down (they generally involve my
> > >> > thumb brushing over the trackpad, which happens fairly often as I
> > >> > type), the touchpad reports a right-click. ?This causes gnome-terminal
> > >> > to pop up its menu, which is very annoying.
> > >> >
> > >> > Why does the trackpad report a right-click instead of a normal
> > >> > left-click? ?How can I fix this?
> > >>
> > >> You probably have corner taps or multi-finger taps enabled on your box.
> > >> What does "synclient' has to say about your setup?
> > >
> > > Here's the output from "synclient -l":
> ...
> 
> > The synaptics X input driver is probably interpreting large contacts
> > as 2-fingers, which is in turn being translated into a 2-finger tap.
> 
> That's right!  2-finger taps are reliably interpreted as right-clicks.
> 
> > To completely disable "2-finger Tap as Right Click", try setting TapButton2 = 0.
> > To temporarily change the setting, you can use the synclient program.
> > To make it permanent, change the value in the Synaptics section of
> > your xorg.conf file, and restart X.
> 
> The synclient program does the job.  However there is no Synaptics 
> section in xorg.conf.  In fact, there isn't any xorg.conf file at all; 
> the /etc/X11/xorg.conf.d directory contains only 
> 00-system-setup-keyboard.conf, which talks about the keyboard but not 
> the touchpad.
> 
> Presumably I can add a similar file with config information for the 
> touchpad driver, but I'm not sure what it should say.  Any suggestions?

I think the following link explains it fairly well:

	http://fedoraproject.org/wiki/Input_device_configuration

Hope this helps.

-- 
Dmitry
