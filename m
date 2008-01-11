From: Ivo van Doorn <ivdoorn@gmail.com>
Subject: Re: rfkill-input understanding help
Date: Fri, 11 Jan 2008 20:08:00 +0100
Message-ID: <200801112008.00927.IvDoorn@gmail.com>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <200801022010.21109.IvDoorn@gmail.com> <200801110323.38279.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:18552 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761618AbYAKTIN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2008 14:08:13 -0500
Received: by ug-out-1314.google.com with SMTP id z38so511205ugc.16
        for <linux-input@vger.kernel.org>; Fri, 11 Jan 2008 11:08:11 -0800 (PST)
In-Reply-To: <200801110323.38279.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Friday 11 January 2008, Carlos Corbacho wrote:
> Well, the good news is that the code I have appears to work. But, I have 
> something very strange going on with my kernel (latest ACPI git tree + 
> acer-wmi on top) and rfkill-input.
> 
> Basically, if I either:
> 
> 1) Build rfkill-input into the kernel
> 
> or
> 
> 2) Build rfkill-input as a module, and use kmod to load it from acer-wmi
> 
> Then rfkill-input doesn't work.
> 
> If I load rfkill-input manually (or if already loaded by kmod; unload and
> then reload), everything works as expected. The (in progress) code to add
> rfkill support to acer-wmi is here (in case the problem is something wrong
> with the code) - as you can see, it's mostly based on the b43 work.
> 
> My kernel config is here, in case I'm missing something obvious:
> http://files.strangeworlds.co.uk/config-acpi-git-20080111

Does it help when you run
	request_module("rfkill-input");
_before_ calling acer_rfkill_init_device() ?

Perhaps the rfkill-input needs to be registered before input
devices are being registered. But I am not sure, Dmitry propably
knows more about possible ordering requirements for input
device and input trigger registration.

Ivo
