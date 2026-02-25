Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815983C199F;
	Wed, 25 Feb 2026 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035941; cv=none; b=joKFDC0W7rUFAorlVNf1Qpw9XHJY6NfuT8Ag16x9aGTlQublwMwMqiUxfahHsjQeIOX/psZOAjEMViM/h7sdVe2N6poJ7qJmnNkVKrVHIl9897MWkXSIo6RY/DU2GQJ5b4CtLFZE/aUUa9/8/h5Mnd1PuWEAG4OeQQLjjEU0iNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035941; c=relaxed/simple;
	bh=wedeh2zn78qjUF85GM07fBAVemxKGYvznw6h2yhq8x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+ESAWfPl3kvNsi9DfDyFXFUuasGOc1F/pT8OXDWphVuE35+bQCMvKAUPuKYc+RyU9lYczdl2lO4scX59gwYSo8GIr/ber7JNz+VCRTfQpUTh58XB/iu4UgccUkjqyKu+lLb39X2rtaxRG0/81Ok6UZ1A795EWpJyaJvklPyzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6W2RAnz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6W2RAnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772035941; x=1803571941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wedeh2zn78qjUF85GM07fBAVemxKGYvznw6h2yhq8x0=;
  b=T6W2RAnzcpDqF17E+8y/locY6qU/v1IyGgvmmJOUX42WkJZ3lWoQzU5Z
   D5e5D/ZpJJrvLqV5lopLKZj+N9fOtlFuujyRqo8RjA/5SMpMdoFSBWazD
   HV8wf5+wAqhYdIOiINhYjA68/n0PcI4xmG/W3rDeOVE4jXEh+COlwfyQo
   mLgbc4V24FGTTF7q6SGkUa/nxUHFT7m0jPbWMt3Rq4PHR/3Pfo7RZvODE
   lMNaPRfeXVJV+gKowx4zC0ceJDqBedRTnBME3Qh/8so5Hf0oBozo476TY
   qNieXdIISm0mmc9fLNHOm6uGuYyFa6fyHERwwd8GmpCGB9EvtvPGGA7PD
   A==;
X-CSE-ConnectionGUID: QZQWtJkZQIiLu8iUJjbxzw==
X-CSE-MsgGUID: H1APZt8oRAWiQ/hh7iu2xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73056380"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73056380"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:12:20 -0800
X-CSE-ConnectionGUID: N1H3W0yqQaC9NQakEgQDOg==
X-CSE-MsgGUID: UG9Q9LZsSoqRjV1nJdIvdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="213380447"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:12:15 -0800
Date: Wed, 25 Feb 2026 18:12:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robin@protonic.nl, andy@kernel.org, geert@linux-m68k.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dmitry.torokhov@gmail.com, hvilleneuve@dimonoff.com,
	mkorpershoek@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, lee@kernel.org,
	alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <aZ8fXXGMx3fk7gKs@smile.fi.intel.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
 <20260225155409.612478-5-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225155409.612478-5-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 10:54:01AM -0500, Hugo Villeneuve wrote:

> Add support for GPIO-based charlieplex keypad, allowing to control
> N^2-N keys using N GPIO lines.
> 
> Reuse matrix keypad keymap to simplify, even if there is no concept
> of rows and columns in this type of keyboard.

...

> +/*
> + *  GPIO driven charlieplex keypad driver
> + *
> + *  Copyright (c) 2025 Hugo Villeneuve <hvilleneuve@dimonoff.com>
> + *
> + *  Based on matrix_keyboard.c

A single space after asterisk is enough.

> + */

...

+ bitops.h

> +#include <linux/delay.h>

+ dev_printk.h
+ device/devres.h
+ err.h

> +#include <linux/gpio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>

+ math.h

> +#include <linux/module.h>

> +#include <linux/of.h>

Is this in use? Or you wanted mod_devicetable.h for OF ID table?

> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/types.h>

...

> +	for (code = 0, oline = 0; oline < keypad->nlines; oline++) {
> +		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
> +		int iline;

> +		int rc;

I think Dmitry prefers 'error' name for this kind of variables.

> +		/* Activate only one line as output at a time. */
> +		gpiod_direction_output(keypad->line_gpios->desc[oline], 1);
> +
> +		if (keypad->settling_time_us)
> +			fsleep(keypad->settling_time_us);
> +
> +		/* Read input on all other lines. */
> +		rc = gpiod_get_array_value_cansleep(keypad->line_gpios->ndescs,
> +						    keypad->line_gpios->desc,
> +						    keypad->line_gpios->info, values);
> +		if (rc)
> +			return;
> +
> +		for (iline = 0; iline < keypad->nlines; iline++) {
> +			if (iline == oline)
> +				continue; /* Do not read active output line. */
> +
> +			/* Check if GPIO is asserted. */
> +			if (test_bit(iline, values)) {
> +				code = MATRIX_SCAN_CODE(oline, iline,
> +							get_count_order(keypad->nlines));
> +				/*
> +				 * Exit loop immediately since we cannot detect
> +				 * more than one key press at a time.
> +				 */
> +				break;
> +			}
> +		}
> +
> +		gpiod_direction_input(keypad->line_gpios->desc[oline]);
> +
> +		if (code)
> +			break;
> +	}

...

> +static int charlieplex_keypad_init_gpio(struct platform_device *pdev,
> +					struct charlieplex_keypad *keypad)
> +{
> +	int i;

Why signed? But see below as well.

> +	keypad->line_gpios = devm_gpiod_get_array(&pdev->dev, "line", GPIOD_IN);
> +	if (IS_ERR(keypad->line_gpios))
> +		return PTR_ERR(keypad->line_gpios);
> +
> +	keypad->nlines = keypad->line_gpios->ndescs;
> +
> +	if (keypad->nlines > MATRIX_MAX_ROWS)
> +		return -EINVAL;

> +	for (i = 0; i < keypad->nlines; i++)

iterator is local to the loop, hence

	for (unsigned int i = 0; i < keypad->nlines; i++)

> +		gpiod_set_consumer_name(keypad->line_gpios->desc[i], "charlieplex_kbd_line");
> +
> +	return 0;
> +}

...

> +static int charlieplex_keypad_probe(struct platform_device *pdev)
> +{
> +	struct charlieplex_keypad *keypad;
> +	unsigned int debounce_interval_ms;
> +	unsigned int poll_interval_ms;
> +	struct input_dev *input_dev;

> +	int err;

The naming is even inconsistent between the functions...

> +	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
> +	if (!keypad)
> +		return -ENOMEM;
> +
> +	input_dev = devm_input_allocate_device(&pdev->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	keypad->input_dev = input_dev;
> +
> +	device_property_read_u32(&pdev->dev, "poll-interval", &poll_interval_ms);
> +	device_property_read_u32(&pdev->dev, "debounce-delay-ms", &debounce_interval_ms);
> +	device_property_read_u32(&pdev->dev, "settling-time-us", &keypad->settling_time_us);
> +
> +	keypad->current_code = -1;
> +	keypad->debounce_code = -1;
> +	keypad->debounce_threshold = DIV_ROUND_UP(debounce_interval_ms, poll_interval_ms);
> +
> +	err = charlieplex_keypad_init_gpio(pdev, keypad);
> +	if (err)
> +		return err;
> +
> +	input_dev->name		= pdev->name;
> +	input_dev->id.bustype	= BUS_HOST;
> +
> +	err = matrix_keypad_build_keymap(NULL, NULL, keypad->nlines,
> +					 keypad->nlines, NULL, input_dev);
> +	if (err)
> +		dev_err_probe(&pdev->dev, -ENOMEM, "failed to build keymap\n");
> +
> +	if (device_property_read_bool(&pdev->dev, "autorepeat"))
> +		__set_bit(EV_REP, input_dev->evbit);
> +
> +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> +
> +	err = input_setup_polling(input_dev, charlieplex_keypad_poll);
> +	if (err)
> +		dev_err_probe(&pdev->dev, err, "unable to set up polling\n");
> +
> +	input_set_poll_interval(input_dev, poll_interval_ms);
> +
> +	input_set_drvdata(input_dev, keypad);
> +
> +	err = input_register_device(keypad->input_dev);
> +	if (err)
> +		return err;

> +	platform_set_drvdata(pdev, keypad);

Is this needed?

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


