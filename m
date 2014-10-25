From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: FocalTech touchpad issues on K750
Date: Sat, 25 Oct 2014 19:56:05 +0200
Message-ID: <544BE435.3070806@redhat.com>
References: <544B93A6.6010801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38597 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbaJYS44 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Oct 2014 14:56:56 -0400
In-Reply-To: <544B93A6.6010801@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathias Gottschlag <mgottschlag@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-usb <linux-input@vger.kernel.org>

Hi,

On 10/25/2014 02:12 PM, Mathias Gottschlag wrote:
> Hi,
> 
> I've had Nikola Nikolov test my touchpad code for me and got the report
> that the driver worked, but only when he passed i8042.noloop=1 and
> psmouse.proto=bare to the kernel. Now I have been pretty careful to keep
> your previous patch in place when writing my code. So, I'd like to
> further debug this issue, but I don't really understand the matter.
> 
> Especially, what is that AUX LOOP command that is disabled by noloop=1?
> Your patch does not have anything to do with that option, does it?

WRT passing noloop that laptop has a weird i8042 implementation where the
kernel does not detect the aux port at all unless noloop is passed, a
patch to do this automatically is already upstream:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/serio/i8042-x86ia64io.h?id=9ff84a17302aeb8913ff244ecc0d8f9d219fecb5

WRT needing to pass psmouse.proto=bare, that should not be necessary
with recent kernels, but the fix for this has only gone upstream very
recently, so likely he is just using a somewhat older kernel.

Regards,

Hans
