From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: No standard touchscreen driver for Samwell Ruggedbook Tablet
	PC 800. Which to use?
Date: Thu, 17 Jul 2008 12:36:09 -0400
Message-ID: <20080717123041.ZZRA012@mailhub.coreip.homeip.net>
References: <f44001920807160849p679857dbn7bf0fec419229cd6@mail.gmail.com> <f44001920807160954tb492bcdpadc66b91ff532367@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:13736 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbYGQQgN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jul 2008 12:36:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so172583and.103
        for <linux-input@vger.kernel.org>; Thu, 17 Jul 2008 09:36:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f44001920807160954tb492bcdpadc66b91ff532367@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Zhbanov <izh1979@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Igor,

On Wed, Jul 16, 2008 at 08:54:23PM +0400, Igor Zhbanov wrote:
> Hello!
> 
> I have Samwell Ruggedbook Tablet PC 800:
> http://www.ruggedbook.com.tw/product_view.asp?ID=50
> 
> It has 4-wire resistive touchscreen controlled by PIC16F819. Microcontroller
> has 10-bit ADC and it seems to be connected to PS/2. (I have no idea what
> is inside PIC's ROM.) Under Windows device works well with Wacom Tablet PC
> and PanJit TouchSet drivers (the later is not proprietary for this device).
> 
> Under Linux I can capture events from /dev/input/event2 device. So I
> have written
> simple program that dumps data in hexadecimal view.
> 

[ skip reverse-engineering effort of Linux event protocol, see
  include/linux/input.h and struct input_event in particular ]

> 
> Now is the main question. Is there a driver suitable for this protocol
> or it should be written? Have you seen this protocol in another touchscreen
> controllers already?
> 

It looks that the device works in PS/2 compatibility mode. There seems
to be a driver on PanJit web site with some crude support, have you
tried it?

-- 
Dmitry
