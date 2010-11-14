From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Sun, 14 Nov 2010 12:40:10 -0800
Message-ID: <AANLkTinR14-0Pvfm_jroCR3Ta27S_k-HXpgtgPwTzxWE@mail.gmail.com>
References: <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
	<AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
	<20101110050219.GB29110@barra.bne.redhat.com>
	<4CDA6D25.4070501@euromail.se>
	<20101110235355.GB4473@barra.bne.redhat.com>
	<4CDB3D6C.2000507@euromail.se>
	<20101111012251.GC2121@core.coreip.homeip.net>
	<AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
	<20101111082653.GC24415@core.coreip.homeip.net>
	<AANLkTikVZBdTTR=jb=jpW+u5sHr4zazypwOnJSoR-RXv@mail.gmail.com>
	<20101111192434.GA13163@core.coreip.homeip.net>
	<4CDC46E5.8040703@euromail.se>
	<AANLkTi=TVm1xUeM8nfnGFhyrjW9+3NL0AO9iCvVFTriZ@mail.gmail.com>
	<4CDC626D.9050205@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:65001 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0KNUkM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Nov 2010 15:40:12 -0500
Received: by wwb39 with SMTP id 39so146190wwb.1
        for <linux-input@vger.kernel.org>; Sun, 14 Nov 2010 12:40:11 -0800 (PST)
In-Reply-To: <4CDC626D.9050205@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Thu, Nov 11, 2010 at 1:38 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>
>> Are we going to do the tocuh and pen aribtration in input-mt.c? I need
>> to understand this to make my patches.
>
> If the pen is implemented as just another contact, it will also be treated as
> such, and arbitration becomes the same thing as single-pointer emulation.

New questions occured when I think about input-mt.c. How are we going
to pass MT_TOOL types and resolution to the userland?

We need to pass MT_TOOL types to the userland since there would be
different tools in the same slot array. Something like:
input_report_key(input, MT_TOOL_PEN, prox); is needed.

To do so, we need to enable them by a call to __set_bit(MT_TOOL_....
first. But, __set_bit wasn't meant for MT_TOOL_ since 0
(MT_TOOL_FINGER) and 1 (MT_TOOL_PEN) are used for KEY_RESERVED and
KEY_ESC.

One way to make this work is to increase  MT_TOOL_FINGER from 0 to
something like 0x2ff (we need to increase KEY_MAX as well). Luckily
MT_TOOL_ is not in any of the existing HID drivers.

Another solution could be to pass the tool type as ABS values since we
have ABS_MT_TOOL_TYPE defined already:

input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_FINGER);
.........
input_set_abs_params(dev, ABS_MT_TOOL_TYPE, MT_TOOL_FINGER, MT_TOOL_PEN ....) .

We need to add more MT tool types, such as MT_TOOL_AIRBRUSH...., for
styli. Not sure if we want to go that far or not.

I have thought about the resolution issue for a while. I didn't want
to tocuh it since it affects all HID drivers. Resolution has been
added to absinfo since kernel 2.6.31. But no kernel driver has passed
resolution to the userland yet. We (linuxwacom project) still keep a
resolution table in the X driver. Passing resolution to the userland
from the kernel can get rid of those tables and avoid retrieving that
information from HID descriptor.

One simple way to support resolution is to add "int res" to
input_set_abs_params(...). This means an interface change. All HID
drivers that call input_set_abs_params() have to be updated. We could
introduce a new input_set_abs_something so only those drivers that
want to pass the resolution switch to the new routine. Maybe you guys
have other suggestions?

Ping
