From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: Fwd: issue with Mad Catz joystick ?
Date: Fri, 08 May 2015 23:39:40 +0200
Message-ID: <1431121180.9786.23.camel@mars>
References: <CAHkp7MAbgJZ0bkDCG=WYWgJa2=y0rqFVRSjDL6jbtVQpp--==A@mail.gmail.com>
	 <CAHkp7MAsieivQuZQ5aTKDTXWM=9bP1BK8Yqy5SLWeK1dr+2pzQ@mail.gmail.com>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35697 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbEHVjo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2015 17:39:44 -0400
In-Reply-To: <CAHkp7MAsieivQuZQ5aTKDTXWM=9bP1BK8Yqy5SLWeK1dr+2pzQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guillaume APOSTOLY <guillaume.apostoly@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Hi Guillaume

On Tue, 2015-05-05 at 08:09 +0200, Guillaume APOSTOLY wrote:
> I have the first PS3 version of the MadCatz Arcade Stick and I am trying to
> use it on my raspberry pi (with a raspbian distribution).
> The joystick is "detected", it shows up if I do "lsusb" and even if I do a
> "jstest /dev/input/js0" but the display of jstest is like frozen and
> pressing the buttons has no effect.
> Oddly enough, it worked once (not the first time) after a reboot.

Can you make sure this PS3 device is in an overall working condition? If
so, you need to come up with a quirk to make it work for Linux.

> I have tested modification of the voltage of the USB, tried to power it
> with a Y cable in case this was the issue, I have investigated the usb
> layer (the stick being known on the web to use OHCI but I think this is a
> wrong lead).
> Yesterday, I also added a part to xpad.c with the appropriate device ID,
> hoping that it will make it work somehow better, as currently only the xbox
> version is declared, and recompiled the kernel but this changes nothing :

As you noted, your device is for PlayStation 3 -- why do you think the
xbox driver is appropriate? It's not!

have fun
  -- chf

