From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Wed, 15 Jun 2011 02:03:38 +0200
Message-ID: <3443374.f0SkEvoJ1j@qosmio-x300>
References: <2502891.N5kVV5at6b@qosmio-x300> <7710689.O2quS97bHe@qosmio-x300> <2756a7d8aa2d4187bb6d39577b69c097.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63207 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab1FOADi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 20:03:38 -0400
Received: by fxm17 with SMTP id 17so49428fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 17:03:37 -0700 (PDT)
In-Reply-To: <2756a7d8aa2d4187bb6d39577b69c097.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: jkosina@suse.cz, linux-input@vger.kernel.org

On Tuesday 14 of June 2011 19:16:37 simon@mungewell.org wrote:
> My reverse engineer technique had a python-hid script so that I could
> throw packets directly at the wheel to produce specific force setups. I
> need to port this to python-libusb (as python-hid is dead), but that
> should be relatively simple and can forward off list to anyone who wants a
> copy.
>
You might want to check out Michael Bauer's LTWheelConf [1]. It's written in C so it's not the niftiest thing to use for 
playing around with the wheel, but adding support for the Wii wheel is a matter of 30 seconds. It uses libusb and I'm sure 
it can be easily modified to send whatever data you want to the wheel.

> This would work under Windows and playback various effects in test mode as
> you pushed buttons - if anybody can grab some USB logs of this I can
> attempt to parse them for the codes....
That's kind of my plan. I'll try to write some simple "effect generator" app using DirectInput and sniff the commands. By 
the way, I've been provided with the anti-center spring command description for my Driving Force Pro which I use to set 
the wheel's range. Is it accepted by the Wii wheel as well?

As I read the source of all lgff drivers, I wonder if all Logitech wheels shouldn't be handled in the lg4ff driver. I'm worried 
that further patching of lgff could break functionality with some older joysticks it's been originally meant to work with.

81 0B 19 E6 FF 4A FF:
 8* - set effect number 4, *1 - start effect command
 0B - effect type: spring
 19 - left hand ramp start (MSB)
 E6 - right hand ramp start (MSB)
 F* - RH stiffness (0xF:max), *F - LH stiffness (0xF:max)
 4* - RH ramp start (LSB) , LSbit is RH stiffness sign (0:+ 1:-)
 *A - LH ramp start (LSB), LSbit is LH stiffness sign (0:+ 1:-)
 FF - saturation level for spring force (0xFF = max)

In above example the wheel soft stops are set to
0x19A and 0xE64 or 410 and -412 where 0x7FF or 2047 corresponds to half a rotation range or 450 degrees. Therefore 
the wheel soft stops are set to +-360 degrees - the boundaries are calculated from the outsite.(410 / 2047 * 450)

(Description provided by lbondar, original can be found here [2])

[1] https://github.com/TripleSpeeder/LTWheelConf
[2] http://www.lfsforum.net/showthread.php?p=1603971#post1603971
