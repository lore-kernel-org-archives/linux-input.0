From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Aorus X3+ touchpad not working
Date: Thu, 06 Nov 2014 14:47:57 +0100
Message-ID: <545B7C0D.8020401@redhat.com>
References: <CAJdy7pJpbyYHuOg3AWnDJap=T9z0bUCZkM+DRuuTLUFj129H_w@mail.gmail.com> <CAN+gG=F7d+37kKF=s-_jLVd+=oqCjaNNQW084eKnYBREEZF14w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51405 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbaKFNsD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Nov 2014 08:48:03 -0500
In-Reply-To: <CAN+gG=F7d+37kKF=s-_jLVd+=oqCjaNNQW084eKnYBREEZF14w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Maximilien Levesque <maximilien.levesque@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

On 11/05/2014 04:47 PM, Benjamin Tissoires wrote:
> Hi Maximilien,
> 
> [Adding Hans in CC, I am pretty sure he might be helpful]

I can certainly try (to be helpful) looking at the dmesg, and the ubuntu
bug I see:

1) ps2 aux port getting properly detected, so this is not a case i8042.noloop
may fix

2) not working with older kernels either so likely not a problem with the
recent nomux dance

3) [    0.834549] pnp 00:06: Plug and Play ACPI device, IDs ETD0a00 ETD0000 PNP0f13 (active)

Looks like you've a ps/2 attached elantech touchpad.

But I don't see any ps/2 mouse / touchpad probing messages in your dmesg
despite the kernel seeing the aux port:

[    1.865847] serio: i8042 AUX port at 0x60,0x64 irq 12

Which is weird, can you try booting with i8042.debug=1 on the kernel commandline,
and then collect a new dmesg ?

Thanks & Regards,

Hans
