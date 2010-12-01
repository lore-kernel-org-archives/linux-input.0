From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH 8/8] input: gpio_keys_polled: fix Kconfig help text
Date: Wed, 01 Dec 2010 23:53:10 +0100
Message-ID: <87r5e1ksvd.fsf@tac.ki.iif.hu>
References: <4CF541ED.80905@openwrt.org>
	<1291142663-1011-9-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:52465 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab0LAXep (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Dec 2010 18:34:45 -0500
In-Reply-To: <1291142663-1011-9-git-send-email-juhosg@openwrt.org> (Gabor
	Juhos's message of "Tue, 30 Nov 2010 19:44:23 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

Gabor Juhos <juhosg@openwrt.org> writes:

> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -491,7 +491,7 @@ config KEYBOARD_GPIO_POLLED
> -	  to GPIO pins of various CPUs (and some other chips).
> +	  to GPIO pins which is not capable to generate interrupts.

I suggest s/is/are/ or perhaps even s/which is //.
-- 
Great stuff, thanks!
Feri.
