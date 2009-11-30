From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Mon, 30 Nov 2009 21:59:06 +0100
Message-ID: <87638rlof9.fsf@tac.ki.iif.hu>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
	<87hbsd2b17.fsf@tac.ki.iif.hu>
	<20091130082737.GA27979@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:36566 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbZK3U7B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 15:59:01 -0500
In-Reply-To: <20091130082737.GA27979@gw.healthdatacare.com> (Mika Westerberg's
	message of "Mon, 30 Nov 2009 10:27:37 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Mika Westerberg <mika.westerberg@iki.fi> writes:

> If it suits you, I would go with the "can_disable" -field in the
> struct gpio_keys_button. This way it should be possible to extend
> gpio-keys in future to support multiple buttons sharing the single IRQ
> and it also works for us.

Why not simply release the corresponding IRQ?  No new fields are needed
in the platform data, you don't even have to change the IRQ flags.  Or
do I miss something again?  Could well be, I'm starting to lose ground
in this discussion... this runtime PM stuff is rather confusing. :]
-- 
Cheers,
Feri.
