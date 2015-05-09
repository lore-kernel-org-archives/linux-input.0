From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: issue with Mad Catz joystick ?
Date: Sat, 09 May 2015 19:21:36 +0200
Message-ID: <1431192096.5331.20.camel@mars>
References: <CAHkp7MAbgJZ0bkDCG=WYWgJa2=y0rqFVRSjDL6jbtVQpp--==A@mail.gmail.com>
	 <CAHkp7MAsieivQuZQ5aTKDTXWM=9bP1BK8Yqy5SLWeK1dr+2pzQ@mail.gmail.com>
	 <1431121180.9786.23.camel@mars>
	 <FB27B34B-9562-4A20-BC73-634B4B1824BD@gmail.com>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35859 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbEIRVl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 May 2015 13:21:41 -0400
In-Reply-To: <FB27B34B-9562-4A20-BC73-634B4B1824BD@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guillaume Apostoly <guillaume.apostoly@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, 2015-05-09 at 10:54 +0200, Guillaume Apostoly wrote:
> The issues I have to investigate further is that I don't understand
> how the kernel decide which module is loaded for the joypad, if I
> modprobe other joystick related modules I don't see how to know if
> module A or B is handling it.

Depends on USB VID/PID or USB Descriptor. If you want to read more about
USB, e.g. look at: www.usb.org
As far as I know, PS3 controllers come with a HID descriptor, so the
generic hid driver binds this. It's quirks get organized by
drivers/hid/usbhid/hid-quirks.c

> All I know is jstest "kind of" work with it but does not.
> If you could point me to some leads that could be cool, I can give you
> external root access to it if you want.

No, I don't want that! :)

bye
 -- chf

