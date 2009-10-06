From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: how to make KEY_POWER work in terminal system
Date: Mon, 5 Oct 2009 22:06:33 -0700
Message-ID: <20091006050633.GF27881@core.coreip.homeip.net>
References: <bc65a8d50910030813y26138fbet402bdfb3f8321af8@mail.gmail.com> <bc65a8d50910030942hecf96b2hc06ff18f786a1cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:44418 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201AbZJFFHQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2009 01:07:16 -0400
Received: by ewy17 with SMTP id 17so3529487ewy.39
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2009 22:06:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bc65a8d50910030942hecf96b2hc06ff18f786a1cc@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: xiangfu liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Xiangfu,

On Sun, Oct 04, 2009 at 12:42:07AM +0800, xiangfu liu wrote:
> kernel message:
> [    1.240000] input: gpio-keys as /devices/platform/gpio-keys/input/input0
> [    1.250000] input: matrix-keypad as /devices/platform/matrix-keypad/input/in1
> 
> no /dev/event/inputX device
> but there is
> /sys/devices/platform/gpio-keys/input/input0
> the uevent is :
> PRODUCT=19/1/1/100
> NAME="gpio-keys"
> PHYS="gpio-keys/input0"
> EV==3
> KEY==100000 0 0 0
> MODALIAS=input:b0019v0001p0001e0100-e0,1,k74,ramlsfw
> 
> from /proc/interrupts
> 181:         87     GPIO Bank D  Power
> 
> when I press the button nothing happen. device not poweroff.
> 
> we have a metrix-keypad in out device. all keys work find.
> so I try to map the "F1" to KEY_POWER. then I press the "F1" device not pwoeroff
> 

Powering off in response to KEY_POWER is a policy decision and thus
belongs to userspace. Someone (a program, a userspace daemon) has to
listen to events coming from the input devices and shut down the system
when it sees EV_KEY/KEY_POWER event.

I think you also want KEY_SLEEP, not KEY_POWER for your device...

-- 
Dmitry
