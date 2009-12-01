From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Tue, 01 Dec 2009 02:05:38 +0100
Message-ID: <877ht733ml.fsf@tac.ki.iif.hu>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
	<87hbsd2b17.fsf@tac.ki.iif.hu>
	<20091130082737.GA27979@gw.healthdatacare.com>
	<87638rlof9.fsf@tac.ki.iif.hu>
	<20091201003724.GC3906@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:43675 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbZLABFd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 20:05:33 -0500
In-Reply-To: <20091201003724.GC3906@core.coreip.homeip.net> (Dmitry Torokhov's
	message of "Mon, 30 Nov 2009 16:37:24 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Mon, Nov 30, 2009 at 09:59:06PM +0100, Ferenc Wagner wrote:
>> Mika Westerberg <mika.westerberg@iki.fi> writes:
>> 
>>> If it suits you, I would go with the "can_disable" -field in the
>>> struct gpio_keys_button. This way it should be possible to extend
>>> gpio-keys in future to support multiple buttons sharing the single IRQ
>>> and it also works for us.
>> 
>> Why not simply release the corresponding IRQ?  No new fields are needed
>> in the platform data, you don't even have to change the IRQ flags.  Or
>> do I miss something again?
>
> It would work but with one unpleasant possibility - of you release IRQ
> some other device might "steal" it. I don't think it is a good style for
> a device to fail due to resources conflict if it was working to begin
> with.

Well, the IRQ is shared, so if somebody steals it, you have a resource
conflict anyway, only with another loser this time.  Unmuting can fail
with -EBUSY.  The Linux Device Drivers book (the only reference I could
find) strongly suggests acquiring resources (especially IRQ in ch.10) on
open() and releasing them on close() -- it wasn't my idea. :)  What's
more, that would in itself make a pure user space solution possible, if
inconvenient, and also be a natural extension of your suggestion to
support multiple buttons on one IRQ by registering the shared handler
separately for each button.  Anyway, it's your call, I just wonder...
-- 
Cheers,
Feri.
