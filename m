From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 14:10:38 -0800
Message-ID: <AANLkTikjbqo3RdJjDzm4N+cDy+q4dC2h_9oMR7zVJTPn@mail.gmail.com>
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
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509Ab0KKWKk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 17:10:40 -0500
Received: by eye27 with SMTP id 27so1555170eye.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 14:10:38 -0800 (PST)
In-Reply-To: <4CDC626D.9050205@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 11, 2010 at 1:38 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>>
>> Are we going to do the tocuh and pen aribtration in input-mt.c? I need
>> to understand this to make my patches.
>
> If the pen is implemented as just another contact, it will also be treated as
> such, and arbitration becomes the same thing as single-pointer emulation.

As we discussed earlier, pen is on a separate logical port for USB
devices. But that should not be an issue in the kernel driver, i.e.,
input-mt.c.

I'd love to wait for the implementation of input-mt.c. Do you have a
rough timeline for it?

If we want to merge pen, and other tool types in the future, into the
same MT slot, a way to tell the userland of the different size and
resolution of the tool is a must. Or maybe you have other suggestions
on "pen is implemented as just another contact"?

Ping
