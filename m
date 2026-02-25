Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35E3D3499;
	Wed, 25 Feb 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038630; cv=none; b=seIKWL0mGMoAJGEk1JdhNJCO/wovPZD0Cn/r8SlPWPwyVtCNDwqUf4WxQsOLDy52VQyYg9WI89qJluJJ/7dnPAkH7APQW/tlWSuyT2N93GwTULS1/9s0a14e3RR7+Yai0Hjmqe6P9ybkc3/Iayyu3gh0uCTFam4Sa/3zFTykCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038630; c=relaxed/simple;
	bh=fCVlQLBDh48nKU+yCW6UdkfNeC57rsE0abf3Savzivc=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=RxPLrhjkz6FFeN84oasR2vX8Yi7/hXe7o0bWn5r0YaRoSQz1ZH0FTAliZFHey7BRuRcKQGgoZLmHHX+cX5ihr5ku7Xd6tWq/9R2Y4UrKCvO6+u78+Ip7IZAjVhND3uFv2qsszPi3c+RNdZMrju1f4VXdEhErpmA6VkxDrzgy4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=nlq+pd4/; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="nlq+pd4/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=6Xsu0Zgs56ZTjjF/y5JOVDhujspJDUCWfcwVY2hiQD8=; b=nlq+pd4/mueP7MR8da4s9fG+Ti
	MljCQ+I9fT/muEHpM7HjYQ1Rm7WEu9flXyI/luE18WWn7ip6pe9Wlal1ky0J5d6mhymsbNol+LFFO
	3w7U6zl+tKxiynCVvsATte/zSLDIPdrZcl9hffvDqgh6f1HTrBmLZclre3BdaV3mZz3c=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39918 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vvIBw-0001Vc-St; Wed, 25 Feb 2026 11:56:54 -0500
Date: Wed, 25 Feb 2026 11:56:52 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, robin@protonic.nl,
 andy@kernel.org, geert@linux-m68k.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com, hvilleneuve@dimonoff.com,
 mkorpershoek@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lee@kernel.org,
 alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Message-Id: <20260225115652.8beb1979df3824f7a95d22bc@hugovil.com>
In-Reply-To: <20260225114155.3ee2efb002aa0f52a905f535@hugovil.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
	<20260225155409.612478-5-hugo@hugovil.com>
	<aZ8fXXGMx3fk7gKs@smile.fi.intel.com>
	<20260225114155.3ee2efb002aa0f52a905f535@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -1.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 25 Feb 2026 11:41:55 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> Hi Andy,
> thank you for the review.
> 
> On Wed, 25 Feb 2026 18:12:13 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Wed, Feb 25, 2026 at 10:54:01AM -0500, Hugo Villeneuve wrote:
> > 
> > > Add support for GPIO-based charlieplex keypad, allowing to control
> > > N^2-N keys using N GPIO lines.
> > > 
> > > Reuse matrix keypad keymap to simplify, even if there is no concept
> > > of rows and columns in this type of keyboard.
> > 
> > ...
> > 
> > > +/*
> > > + *  GPIO driven charlieplex keypad driver
> > > + *
> > > + *  Copyright (c) 2025 Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > + *
> > > + *  Based on matrix_keyboard.c
> > 
> > A single space after asterisk is enough.
> 
> Ok, leftover from copy/paste from matrix_keyboard.c :)
> 
> > 
> > > + */
> > 
> > ...
> > 
> > + bitops.h
> > 
> > > +#include <linux/delay.h>
> > 
> > + dev_printk.h
> > + device/devres.h
> > + err.h
> > 
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/input.h>
> > > +#include <linux/input/matrix_keypad.h>
> > 
> > + math.h
> 
> Ok.
> 
> 
> > 
> > > +#include <linux/module.h>
> > 
> > > +#include <linux/of.h>
> > 
> > Is this in use? Or you wanted mod_devicetable.h for OF ID table?
> 
> I need only OF ID table, so will replace with mod_devicetable.h.

Hi Andy,
finally I need <linux/of.h> for of_match_ptr()...

But I will keep <mod_devicetable.h> ...


> > 
> > > +#include <linux/platform_device.h>
> > > +#include <linux/property.h>
> > > +#include <linux/types.h>
> > 
> > ...
> > 
> > > +	for (code = 0, oline = 0; oline < keypad->nlines; oline++) {
> > > +		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
> > > +		int iline;
> > 
> > > +		int rc;
> > 
> > I think Dmitry prefers 'error' name for this kind of variables.
> 
> I hate using "error", can be so misleading :)
> 
> I would prefer to use "rc" everywhere, but if Dmitry chimes in and
> specifies "error" or "err", then so it will be.
> 
> 
> > 
> > > +		/* Activate only one line as output at a time. */
> > > +		gpiod_direction_output(keypad->line_gpios->desc[oline], 1);
> > > +
> > > +		if (keypad->settling_time_us)
> > > +			fsleep(keypad->settling_time_us);
> > > +
> > > +		/* Read input on all other lines. */
> > > +		rc = gpiod_get_array_value_cansleep(keypad->line_gpios->ndescs,
> > > +						    keypad->line_gpios->desc,
> > > +						    keypad->line_gpios->info, values);
> > > +		if (rc)
> > > +			return;
> > > +
> > > +		for (iline = 0; iline < keypad->nlines; iline++) {
> > > +			if (iline == oline)
> > > +				continue; /* Do not read active output line. */
> > > +
> > > +			/* Check if GPIO is asserted. */
> > > +			if (test_bit(iline, values)) {
> > > +				code = MATRIX_SCAN_CODE(oline, iline,
> > > +							get_count_order(keypad->nlines));
> > > +				/*
> > > +				 * Exit loop immediately since we cannot detect
> > > +				 * more than one key press at a time.
> > > +				 */
> > > +				break;
> > > +			}
> > > +		}
> > > +
> > > +		gpiod_direction_input(keypad->line_gpios->desc[oline]);
> > > +
> > > +		if (code)
> > > +			break;
> > > +	}
> > 
> > ...
> > 
> > > +static int charlieplex_keypad_init_gpio(struct platform_device *pdev,
> > > +					struct charlieplex_keypad *keypad)
> > > +{
> > > +	int i;
> > 
> > Why signed? But see below as well.
> 
> Will switch to unsigned.
> 
> 
> > 
> > > +	keypad->line_gpios = devm_gpiod_get_array(&pdev->dev, "line", GPIOD_IN);
> > > +	if (IS_ERR(keypad->line_gpios))
> > > +		return PTR_ERR(keypad->line_gpios);
> > > +
> > > +	keypad->nlines = keypad->line_gpios->ndescs;
> > > +
> > > +	if (keypad->nlines > MATRIX_MAX_ROWS)
> > > +		return -EINVAL;
> > 
> > > +	for (i = 0; i < keypad->nlines; i++)
> > 
> > iterator is local to the loop, hence
> > 
> > 	for (unsigned int i = 0; i < keypad->nlines; i++)
> 
> Ok
> 
> 
> > 
> > > +		gpiod_set_consumer_name(keypad->line_gpios->desc[i], "charlieplex_kbd_line");
> > > +
> > > +	return 0;
> > > +}
> > 
> > ...
> > 
> > > +static int charlieplex_keypad_probe(struct platform_device *pdev)
> > > +{
> > > +	struct charlieplex_keypad *keypad;
> > > +	unsigned int debounce_interval_ms;
> > > +	unsigned int poll_interval_ms;
> > > +	struct input_dev *input_dev;
> > 
> > > +	int err;
> > 
> > The naming is even inconsistent between the functions...
> 
> Agreed, will fix as stated above.
> 
> 
> > 
> > > +	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
> > > +	if (!keypad)
> > > +		return -ENOMEM;
> > > +
> > > +	input_dev = devm_input_allocate_device(&pdev->dev);
> > > +	if (!input_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	keypad->input_dev = input_dev;
> > > +
> > > +	device_property_read_u32(&pdev->dev, "poll-interval", &poll_interval_ms);
> > > +	device_property_read_u32(&pdev->dev, "debounce-delay-ms", &debounce_interval_ms);
> > > +	device_property_read_u32(&pdev->dev, "settling-time-us", &keypad->settling_time_us);
> > > +
> > > +	keypad->current_code = -1;
> > > +	keypad->debounce_code = -1;
> > > +	keypad->debounce_threshold = DIV_ROUND_UP(debounce_interval_ms, poll_interval_ms);
> > > +
> > > +	err = charlieplex_keypad_init_gpio(pdev, keypad);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	input_dev->name		= pdev->name;
> > > +	input_dev->id.bustype	= BUS_HOST;
> > > +
> > > +	err = matrix_keypad_build_keymap(NULL, NULL, keypad->nlines,
> > > +					 keypad->nlines, NULL, input_dev);
> > > +	if (err)
> > > +		dev_err_probe(&pdev->dev, -ENOMEM, "failed to build keymap\n");
> > > +
> > > +	if (device_property_read_bool(&pdev->dev, "autorepeat"))
> > > +		__set_bit(EV_REP, input_dev->evbit);
> > > +
> > > +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> > > +
> > > +	err = input_setup_polling(input_dev, charlieplex_keypad_poll);
> > > +	if (err)
> > > +		dev_err_probe(&pdev->dev, err, "unable to set up polling\n");
> > > +
> > > +	input_set_poll_interval(input_dev, poll_interval_ms);
> > > +
> > > +	input_set_drvdata(input_dev, keypad);
> > > +
> > > +	err = input_register_device(keypad->input_dev);
> > > +	if (err)
> > > +		return err;
> > 
> > > +	platform_set_drvdata(pdev, keypad);
> > 
> > Is this needed?
> 
> No, will remove it, and replace last lines with:
> 
>    return input_register_device(keypad->input_dev);
> 
> 
> > 
> > > +	return 0;
> > > +}
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> > 
> 
> Hugo Villeneuve


-- 
Hugo Villeneuve
