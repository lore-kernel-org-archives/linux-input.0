From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ASUS N550JK Touchpad recognized wrongly as PS/2 mouse
Date: Mon, 20 Oct 2014 19:56:39 +0200
Message-ID: <54454CD7.80406@redhat.com>
References: <CAJ_4JbZWLXVRGwwuYnzoVvTOM-fUE4vb9jeZLQJ2LUD+fOhs-Q@mail.gmail.com> <CAN+gG=E6c9eK51RxMQU_1tkxk08WtXfpSt7eyiz4fZqOd258OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43462 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaJTR4n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Oct 2014 13:56:43 -0400
In-Reply-To: <CAN+gG=E6c9eK51RxMQU_1tkxk08WtXfpSt7eyiz4fZqOd258OQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Carla Rosenfield <c.rosenfield@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

On 10/20/2014 05:38 PM, Benjamin Tissoires wrote:
> Hi Carla,
> 
> just FYI, I have the same laptop model than you, and can reproduce
> your bug report in the same way. I'll work on that to make it working
> properly.
> 
> Hans, (unfortunately,) this laptop has a ETD0105 touchpad from Elan.
> That means that we do not have the X550 touchpad in house, but also
> means that we should be able to get in working faster than the X550
> one :)

Ok, so 2 things:

1) On the ETD0105 touchpad not working, does the kernel you're using
already have this patch ? :

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/mouse/elantech.c?id=271329b3c798b2102120f5df829071c211ef00ed

If not, try that, if it does, it may need some tweaks to that patch,
or something similar.

2) On not having an X550 style touchpad, I got a report from a user
in the bugzilla tracking that, telling us that he is busy reverse
engineering the protocol, and is making good progress, so that one
should hopefully get sorted out soon-ish too :)

Regards,

Hans
