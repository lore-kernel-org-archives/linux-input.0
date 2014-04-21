From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: Bug: HID-Sony: DS4 touch-pad corrupts Axis0
Date: Mon, 21 Apr 2014 13:30:46 -0400
Message-ID: <535555C6.5050407@gmail.com>
References: <23e61b7ee30edafb338935ae40285dce.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:48539 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbaDURbH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2014 13:31:07 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so2015143igc.13
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 10:31:06 -0700 (PDT)
In-Reply-To: <23e61b7ee30edafb338935ae40285dce.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On 4/21/2014 12:49, simon@mungewell.org wrote:
> Hi,
> I've noticed a glitch with the Dualshock4 on 3.15rc1 (plus LEDs patch, if
> that makes a difference).
>
> Sometimes everything works as expected, the thumbsticks work OK and the
> touch-pad changes axis 15 & 16 (as reported by jstest). Other times axis
> 15 and 16 do not report changes, instead axis 0 is corrupted/changed when
> the touch-pad is 'swiped'.
>
> Evtest appears to report correctly all the time.
>
> It seems that the controller works first time it is plugged in (after
> boot), but then fails subsequent times. I think that the first time I
> don't get the pop-up message about battery being charged, which occurs on
> other times.
>
> I have not found a trigger yet, but was wondering whether others are
> seeing this. I am using a USB connected DS4 (no BT on this machine). OS is
> Xubuntu 13.10 with patched kernel,
> Simon.
>
> --
> simon@slipstream:~$ jstest /dev/input/js0
> Driver version is 2.1.0.
> Joystick (Sony Computer Entertainment Wireless Controller) has 14 axes (X,
> Y, Z,
> and 14 buttons (BtnX, BtnY, BtnZ, BtnTL, BtnTR, BtnTL2, BtnTR2, BtnSelect,
> BtnSt
> Testing ... (interrupt to exit)
> --
> Apr 21 10:21:01 slipstream kernel: [  818.052095] usb 5-1: USB disconnect,
> devic
> Apr 21 10:21:33 slipstream kernel: [  849.684027] usb 5-1: new full-speed
> USB de
> Apr 21 10:21:33 slipstream kernel: [  849.855036] usb 5-1: New USB device
> found,
> Apr 21 10:21:33 slipstream kernel: [  849.855041] usb 5-1: New USB device
> string
> Apr 21 10:21:33 slipstream kernel: [  849.855045] usb 5-1: Product:
> Wireless Con
> Apr 21 10:21:33 slipstream kernel: [  849.855049] usb 5-1: Manufacturer:
> Sony Co
> Apr 21 10:21:33 slipstream kernel: [  849.861096] sony
> 0003:054C:05C4.0005: Usin
> Apr 21 10:21:33 slipstream kernel: [  849.906141] input: Sony Computer
> Entertain
> Apr 21 10:21:33 slipstream kernel: [  849.906344] sony
> 0003:054C:05C4.0005: inpu
> --
>
>

I've seen this before and it's a bug in jstest and jstest-gtk, not the 
driver or event system.  These programs do their own internal axis 
mapping and don't properly handle axes above ABS_MISC which is where the 
touch axes are.  jstest-gtk just default maps these to 0 and the old 
jstest just doesn't look like it does any bounds checking at all.
