From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [RFC PATCH 2/2] Input: gpio-keys: implemented support for enabling/disabling gpios
Date: Wed, 11 Nov 2009 15:37:38 +0100
Message-ID: <873a4li0ul.fsf@tac.ki.iif.hu>
References: <1257929573.21596.960.camel@localhost>
	<cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
	<ac11b18d9fbb22ca88b61d73bc1e47e0068e9a86.1257931659.git.ext-mika.1.westerberg@nokia.com>
	<cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
	<9b012ed801479acf5d4cbdf29292fdfc937d5e07.1257931659.git.ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:57003 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbZKKOhe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 09:37:34 -0500
In-Reply-To: <9b012ed801479acf5d4cbdf29292fdfc937d5e07.1257931659.git.ext-mika.1.westerberg@nokia.com>
	(Mika Westerberg's message of "Wed, 11 Nov 2009 12:36:08 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:

> +	for (i = 0; i < pdata->nbuttons; i++) {
> +		struct gpio_keys_button *button = &pdata->buttons[i];
> +		struct gpio_button_data *bdata = &ddata->data[i];
> +
> +		if (button->code == st->code && button->type == st->type) {
> +			switch (st->state) {
> +			case EVENT_STATE_DISABLE:
> +				if (bdata->state == EVENT_STATE_ENABLE) {
> +					bdata->state = EVENT_STATE_DISABLE;
> +					/*
> +					 * Disable physical irq line.  This is
> +					 * enough also for keeping device from
> +					 * waking up during sleep so no need
> +					 * to change wakeup flags for this irq.
> +					 */
> +					disable_irq(gpio_to_irq(button->gpio));

Hi Mika,

Did you consider what would happen when several GPIO buttons share a
single IRQ?  The current code does not support this (it uses IRQF_SHARED
for a different reason), but this is very much possible: see for example
http://thread.gmane.org/gmane.linux.kernel.input/8775 for a related
thread which unfortunately died off without conclusion (but the patch
went in).
-- 
Thanks,
Feri.
