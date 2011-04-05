From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Lenovo X220 Touchpad + Trackpoint BIOS issue workaround ?
Date: Tue, 5 Apr 2011 11:30:01 -0700
Message-ID: <20110405183001.GC13086@core.coreip.homeip.net>
References: <4D9B2CD0.20404@canonical.com>
 <4D9B522B.7080201@canonical.com>
 <20110405173940.GA13086@core.coreip.homeip.net>
 <4D9B5807.9090406@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57145 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab1DESaH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 14:30:07 -0400
Received: by iwn34 with SMTP id 34so641773iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 11:30:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9B5807.9090406@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manoj <manoj.iyer@canonical.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 05, 2011 at 12:57:27PM -0500, Manoj wrote:
> 
> >When both are enabled in BIOS what protocol does the kernel use to talk
> >to the touchpad? Does it use synaptics protocol?
> 
> Yes it uses Synaptics TouchPad.
> 
> if (max_proto > PSMOUSE_PS2 && synaptics_detect(p .. etc...
> 
> I should say here that the trackpoint is not detected. And sometimes
> (very random) the trackpad is detected as PS/2 Mouse when touchpad
> and trackpoint are enabled in the BIOS... here is what it looks like
> in dmesg when it shows up as PS/2 Mouse instead of TPPS/2 IBM
> TrackPoint.
> 
> [    9.797624] input: ThinkPad Extra Buttons as
> /devices/platform/thinkpad_acpi/input/input8
> [   10.480034] serio: Synaptics pass-through port at isa0060/serio1/input0
> [   10.536122] input: SynPS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio1/input/input9
> [   34.507201] input: PS/2 Generic Mouse as
> /devices/platform/i8042/serio1/serio2/input/input10
> 

Ah, so we do know that the touchpad has a pass-through port.

I guess you can try booting with i8042.debug with touchpad enabled and
disabled and see where exactly we fail to enable trackpoint the the
former case.

-- 
Dmitry
