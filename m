From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek gamepad
Date: Mon, 02 Feb 2009 17:50:59 +0200
Message-ID: <49871663.4060605@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:34739 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbZBBPvC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Feb 2009 10:51:02 -0500
In-Reply-To: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitriy Geels wrote:
> Hello!

Hi!

> After reading HID/PID specs I understood, that Saitek gamepads doesn't
> require any driver -- they are PID compliant. Then, after loading
> usbhid with debug messages enabled, I saw this:
> [  773.716917] usbhid:hid-pidff: starting pid init
> [  773.716947] usbhid:hid-pidff: found usage 0x21 from field->logical
> [  773.716965] usbhid:hid-pidff: found usage 0x5a from field->logical
> [  773.716983] usbhid:hid-pidff: found usage 0x73 from field->logical
> [  773.717000] usbhid:hid-pidff: found usage 0x6e from field->logical
> [  773.717018] usbhid:hid-pidff: found usage 0x77 from field->logical
> [  773.717036] usbhid:hid-pidff: found usage 0x96 from field->logical
> [  773.717075] usbhid:hid-pidff: found usage 0x7d from field->logical
> [  773.717127] usbhid:hid-pidff: found usage 0x7f from field->logical
> [  773.717155] usbhid:hid-pidff: 4 missing
> [  773.717176] usbhid:hid-pidff: reports not ok, aborting
> 
> Definitely, HID descriptor parser has problems, which stops driver
> from reading all reports. Here is hid descriptor of gamepad:
> http://dmitriy.geels.googlepages.com/HIDDescriptor.html
> 
> I added some more debug messages:
> http://dmitriy.geels.googlepages.com/debug.patch
> Then got this:
> 
[...]
> [  773.717155] usbhid:hid-pidff: 4 missing
> [  773.717162] usbhid:hid-pidff: 5 missing
> [  773.717169] usbhid:hid-pidff: 7 missing
> [  773.717176] usbhid:hid-pidff: reports not ok, aborting
> 
> 25, 8b? these are inside of required 0xab and 0x89 reports, and 0x90
> is just ignored...
> 
> I don't understand yet, how to fix this bug, so I'm posting this to
> maillist with hope on someones help.

The error message means that it can't find reports 0xab (create new
effect), 0x89 (pid block load), 0x90 (pid block free), that according to
your html page are in fact there.

Could you provide the output with parameter debug=1 for hid module when
device is initialized? It prints the raw HID descriptor and the kernel's
interpretation of it.
(If you have the hid module built-in, you can use "echo 1 >
/sys/modules/hid/parameters/debug")

-- 
Anssi Hannula
