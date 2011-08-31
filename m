From: Joey Oravec <joravec@drewtech.com>
Subject: Re: linux raw serio driver 32 byte maximum
Date: Tue, 30 Aug 2011 20:40:31 -0400
Message-ID: <4E5D82FF.4060100@drewtech.com>
References: <4E5D5D55.5060207@drewtech.com> <20110830225017.GA2405@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from drewtech.com ([66.36.241.150]:44691 "EHLO server.drewtech.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106Ab1HaAkn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Aug 2011 20:40:43 -0400
In-Reply-To: <20110830225017.GA2405@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 8/30/2011 6:50 PM, Dmitry Torokhov wrote:
> May I ask you what you are using serio_raw for?

We make chips for embedded systems that have a UART host-interface and 
implement several functions (rtc, gpio, power control, etc). The 
protocol is framed and involves both command-response and unsolicited 
messages. I'm writing an MFD kernel driver that handles communication 
and exposes standard kernel interfaces for each feature.

I started with serio which registers a line discipline and provide basic 
serial access in the kernel. Then I created a reusable module based on 
serio_raw that does any buffering necessary and decodes the bytes into 
frames. Finally it registers a platform device which gets connected to a 
platform driver (my MFD driver). Through this stack my kernel driver is 
able to send/receive framed serial data and can communicate with my chip.

I'm open to suggestions about how to improve this design. Writing this 
sort of driver feels way more difficult than one for an i2c or SPI 
device. This approach requires a lot of kernel layers AND running 
inputattach in userspace just to connect a driver to a device on a 
serial port. Maybe you'll have a better idea?

> I think you should handle partial writes. Even if driver honored
> O_NONBLOCK you could get a partial write and not necessarily EAGAIN.

As described above, it's a little different because I'm working inside 
the kernel. However I need to conform to kernel standards for read/write 
because my code uses serio and eventually the TTY layer.

My driver must either rely on the serio write blocking, or call serio 
write in a while-loop and handle partial writes and any error codes. 
Incoming data doesn't have this ambiguity because serio calls that 
interrupt callback to process one character at a time.

-joey
