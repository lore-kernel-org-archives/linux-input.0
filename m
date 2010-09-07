From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH v3 1/1] input: add support for Nomadik SKE keypad
 controller
Date: Tue, 7 Sep 2010 08:49:13 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B181C7DC816@EXDCVYMBSTM006.EQ1STM.local>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
 <20100907063715.GB1680@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:60126 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752216Ab0IGGt1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Sep 2010 02:49:27 -0400
In-Reply-To: <20100907063715.GB1680@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

Hi Dmitry,

>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]

>> +	struct matrix_keymap_data *keymap_data;
>
>const please.

Yes. I think I have missed this. You had pointed out this earlier also; but I think the re-spin
lost them.

>No naked returns at the end of void functions please.

Okay.

>> +}
>> +
>> +static void ske_keypad_timer(unsigned long data)
>> +{
>> +	struct platform_device *pdev =  (struct platform_device *) data;
>> +	struct ske_keypad *keypad = platform_get_drvdata(pdev);
>> +	int ske_kpason;
>> +	int timeout = keypad->board->debounce_ms;
>> +
>> +	ske_kpason = readl(keypad->reg_base + SKE_CR) & SKE_KPASON;
>> +	if (ske_kpason) {
>> +		mod_timer(&keypad->timer, jiffies + msecs_to_jiffies(timeout));
>> +		return;
>> +	}
>> +
>> +	/* read data registers and report event */
>> +	ske_keypad_read_data(keypad);
>> +
>> +	return;
>> +}
>> +
>> +static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
>> +{
>> +	struct ske_keypad *keypad = dev_id;
>> +	int timeout = keypad->board->debounce_ms;
>> +
>> +	/* disable auto scan interrupt; mask the interrupt generated */
>> +	ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
>> +	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
>> +
>> +	/*
>> +	 * if KPASON is not ready, we cannot read data registers
>> +	 * so wait for a debounce period; if still not settled,
>> +	 * we fire a timer and exit the IRQ
>> +	 */
>> +	while ((readl(keypad->reg_base + SKE_CR) & SKE_KPASON) && timeout--)
>> +		cpu_relax();
>> +	if (!timeout) {
>> +		mod_timer(&keypad->timer, jiffies + msecs_to_jiffies(timeout));
>
>timeout is 0 here, I do not think that's what you want.
>

Sorry. I will replace it with keypad->board->debounce_ms.

>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * KPASON behaved nicely and we can read data registers and report event
>> +	 */
>> +	ske_keypad_read_data(keypad);
>> +
>> +out:
>> +	/* enable auto scan interrupts */
>> +	ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
>
>You sure you want do do it here even when SKE_KPASON is set and timer is
>pending? I'd expect re-enabling interrupts from the timer.
>

I did have that originally as you pointed out. But I ran into an issue where multi-key presses
were lost in a case of continued key press.

>I'd probably move registration past requesting IRQ - it will simplify
>error handling I think. It is safe to send events through input device
>as long as it has been allocated with input_allocate_device() even if it
>has not been registered yet.
>

Okay. Will do so.

>> +	/* go through board initialiazation helpers */
>> +	if (keypad->board->init) {
>> +		keypad->board->init();
>
>I do not think you actually compiled this - closing brace is missing
>(well, braces are actually not needed at all).

Ohh yes, Linus W pointed me out. These are last minute fixups, which I lost. Sorry for that

>You are already aware of the issue here...
>

Yes.

Thanx for your review,

Regards,
Sundar



