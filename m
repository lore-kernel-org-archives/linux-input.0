From: Hans Petter Selasky <hps@selasky.org>
Subject: Re: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Sat, 01 Nov 2014 08:40:19 +0100
Message-ID: <54548E63.6060306@selasky.org>
References: <54424770.9090600@gmail.com>	<20141021223311.GG8609@dtor-ws>	<544889FD.5030004@gmail.com>	<54489803.9030803@selasky.org> <CAF8JNhJ8ZR5vvtcrOvv9-ySzN4aytBziEO90_Kif=Q4q7WgwmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from heidi.turbocat.net ([88.198.202.214]:38873 "EHLO
	mail.turbocat.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049AbaKAHkK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Nov 2014 03:40:10 -0400
In-Reply-To: <CAF8JNhJ8ZR5vvtcrOvv9-ySzN4aytBziEO90_Kif=Q4q7WgwmA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Denis Akiyakov <d.akiyakov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "nox@jelal.kn-bremen.de >> Juergen Lock" <nox@jelal.kn-bremen.de>

On 11/01/14 00:27, Ping Cheng wrote:
> If touch_input is NULL on FreeBSD, you need to figure out the root
> cause. Checking on touch_input itself would not fix the root cause...

Right.

The root cause is that FreeBSD launches two instances of the driver, 
running in two different userland processes, for the two different Wacom 
interfaces on a common USB device. In Linux the wacom interface drivers 
are running from the same kernel, and can share the data in question, 
but in FreeBSD's webcamd emulation, this doesn't work. Then the first 
wacom probe call would have to grab the second interface.

Technically speaking this is a FreeBSD only problem and I plan to 
deliver a patch with the webcamd software to fix this, like already 
suggested to you guys. This situation can also happen on Linux in case 
of a "BadUSB" device. That's why I think that the NULL check should be 
upstreamed.

--HPS
