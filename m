Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3202DF68
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776660467; cv=none; b=A6MZrvOHfkBnRJOR282Yz4viLlth8paiYPq0Tl8q6Evuc+/cnzujMKiqJ4OtPEYZ5MIAhpNzMtKRRrP5ug9EINzPSTmILPK1oHdkVyIqxahPCcBA2VxR7ZLQ1cNItIXk6D0F3/GTVn5FFXPMeyc2nPVZoX8DJKE7K5+HOM4Oz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776660467; c=relaxed/simple;
	bh=N0DZixZb482dr8MAWmfPkBJHWGDNHO51NAq3Yuahj8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RibpDgE+PZEbVtt3N/BkLZtILyWpUcJt4GeVPGlTqGR9RdbxZf3yEuyW8zDWdxUYi7ii/QTa/jediIZajFRlBcnsMroZAt1F0puu+A7ThV0dyGxPZIjizHJ5Ng9I+McF3mUV7po4myV1QhU+T1cVuZV1pnqXFLB6TlaCkoeV5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XifRW6f2; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XifRW6f2"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso2175213eec.0
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 21:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776660465; x=1777265265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivIQYtxBKSYYxLWGWSom7fjyGf+pGkpG586CwmF2GsI=;
        b=XifRW6f2mDXUlY3y76s4DYZxv0HmBWEGyeK8LSSRp+DDdlyM7hoxnRfrDmkP5dHPzv
         kf3wUpObnM4Kru8BB12DgW0mIxZDaEjyYoAa0HliJn++ZbmaKq7Z93Yqiwb4rrYrNCdJ
         G/MxdPQVYcgXtI7Qdo5UhBKscNVUECAquQiNETDJu5uyxZ0xJu8KLsN6upl4tRgOHyey
         tjq0zFH8W1bWIoWVixwc6Iq7zf8B3txuUO5QP1cVRs6b4m1qQbz/9Zh+SdCmTA6ENyAI
         LQAD5djWj6gggksAei+xRmsdTnJ+v8lmErWIRBVgmxN9hl8ZNONdhSh2lgCbrLsfJ7WZ
         Ge4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776660465; x=1777265265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivIQYtxBKSYYxLWGWSom7fjyGf+pGkpG586CwmF2GsI=;
        b=QKGN69MB9ewUVsArYbuqMBVZkYzjRhBrdpEI9B/vyCUtd68FR5guheE2748C6QEqPb
         AUwXEG8+2a5QdBT7196Yvd0w3F3FfhMXIpZuZxBxcL3El8h57/UlaHdgHQd6bUfDNnQw
         PUUCUPn4KFlXxIaalpOPOgjOOSLR8c+wEser5TWtxZ0iq1A9DJ2M+wpmf/c5qUQwdGeh
         jZg18Qop5CTExFzArqw2uWvF+2h0M2wgJT9nhZ3dACHSrQlqVEI+S8d6FInqeSKbk+P7
         dBWpgwxVzUYJE4Lq49EodwciRchT6BoKQw49LHy+uq/qumZUeIfvCBSgN5On5cWh/BIE
         jk6A==
X-Forwarded-Encrypted: i=1; AFNElJ+qvkfcL6Yewb5dkmD4S4O1HkDDmw+OvHMNOsdWuaA82nv4cz/Thgf26ZG5dKhJr5diDAjqD2JeuNHR9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yworf0EDoXLYyQqzQAIXS9M78shLn3+FIH+kOsyQ3YrcOWqLzvT
	X2w/EhdROwCbm92MSDqQLQPFp06AIfm74gElEQewekJmSnJq0roY5fIg
X-Gm-Gg: AeBDiety+hIcHPCQSBNyuoC7sDQT7Wvn1v45gRb06bgzS76e0c1hzl+5AG7EKRkbRB5
	5OGVBrjzK8R3GaPVM4rxIoFrq6Zg27rSvaJqVEUFux2HWBZ+dRXHoCLYfJNSbX8oOCDoysOoUGf
	zfAHLRgIDtS0q1NwbkMKe5quNPLAve8WF8M40v6ImZEfh9AXF1dXzK1loyHePGd3cJJXbRS6GcP
	b2epAx78EQ9/Y9RtaJ9/fV9RmVhB2JkjnBGNL9UYQyciOVzzVqxxbnFoXOnuLuRfUe8CClzgi0s
	M9Yxgic5eqUOCsoe+NVB432udAK9FPVAKxrjNhUHK/rLaLGpCeavt4rlCu4QRyCpbYIjw3znIq4
	bGPsumZjeHD0JBlqu5o6REus6ApY4tVqf452Shv0DvySUqigOd0/mVENXi9wiAnXlEw8U8PaFVx
	p1JdKSxCVUzUWI/A0qan+MxZtHDNKcnlbVXep1pOuB7HOfON5IEdVQOSdB2GxSisxGuygZ10Oyw
	0M=
X-Received: by 2002:a05:7300:72d5:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2e42e10aeabmr4580207eec.14.1776660464756;
        Sun, 19 Apr 2026 21:47:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1a4e:4965:5dff:cdee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm15897536eec.8.2026.04.19.21.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 21:47:43 -0700 (PDT)
Date: Sun, 19 Apr 2026 21:47:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robin@protonic.nl, andy@kernel.org, geert@linux-m68k.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	hvilleneuve@dimonoff.com, mkorpershoek@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, lee@kernel.org, alexander.sverdlin@gmail.com, 
	marek.vasut@gmail.com, akurz@blala.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <aeWtDA7snjJmiF9K@google.com>
References: <20260312180304.3865850-1-hugo@hugovil.com>
 <20260312180304.3865850-5-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312180304.3865850-5-hugo@hugovil.com>

Hi Hugo,

On Thu, Mar 12, 2026 at 02:00:58PM -0400, Hugo Villeneuve wrote:
> +
> +static void charlieplex_keypad_report_key(struct input_dev *input)
> +{
> +	struct charlieplex_keypad *keypad = input_get_drvdata(input);
> +	const unsigned short *keycodes = input->keycode;
> +
> +	if (keypad->current_code > 0) {
> +		input_event(input, EV_MSC, MSC_SCAN, keypad->current_code);
> +		input_report_key(input, keycodes[keypad->current_code], 0);

This needs input_sync() as otherwise userspace is free to only recognize
the last MSC_SCAN event.

> +	}
> +
> +	if (keypad->debounce_code) {
> +		input_event(input, EV_MSC, MSC_SCAN, keypad->debounce_code);
> +		input_report_key(input, keycodes[keypad->debounce_code], 1);
> +	}
> +
> +	input_sync(input);
> +	keypad->current_code = keypad->debounce_code;
> +}
> +
> +static void charlieplex_keypad_check_switch_change(struct input_dev *input,
> +						   int code)
> +{
> +	struct charlieplex_keypad *keypad = input_get_drvdata(input);
> +
> +	if (code != keypad->debounce_code) {
> +		keypad->debounce_count = 0;
> +		keypad->debounce_code = code;
> +	} else if (keypad->debounce_count < keypad->debounce_threshold) {

This does not work if debouncing is disabled (debounce threshold is 0).

> +		keypad->debounce_count++;
> +
> +		if (keypad->debounce_count >= keypad->debounce_threshold &&
> +		    keypad->debounce_code != keypad->current_code)
> +			charlieplex_keypad_report_key(input);
> +	}
> +}
> +
> +static void charlieplex_keypad_poll(struct input_dev *input)
> +{
> +	struct charlieplex_keypad *keypad = input_get_drvdata(input);
> +	int code;
> +
> +	code = 0;
> +	for (unsigned int oline = 0; oline < keypad->nlines; oline++) {
> +		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
> +		int err;
> +
> +		/* Activate only one line as output at a time. */
> +		gpiod_direction_output(keypad->line_gpios->desc[oline], 1);
> +
> +		if (keypad->settling_time_us)
> +			fsleep(keypad->settling_time_us);
> +
> +		/* Read input on all other lines. */
> +		err = gpiod_get_array_value_cansleep(keypad->line_gpios->ndescs,
> +						     keypad->line_gpios->desc,
> +						     keypad->line_gpios->info, values);
> +		if (err)
> +			return;

We need to deactivate the line on error too.

> +
> +		for (unsigned int iline = 0; iline < keypad->nlines; iline++) {
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
> +
> +	charlieplex_keypad_check_switch_change(input, code);
> +}
> +
> +static int charlieplex_keypad_init_gpio(struct platform_device *pdev,
> +					struct charlieplex_keypad *keypad)
> +{
> +	char **pin_names;
> +	char label[32];
> +
> +	snprintf(label, sizeof(label), "%s-pin", pdev->name);
> +
> +	keypad->line_gpios = devm_gpiod_get_array(&pdev->dev, "line", GPIOD_IN);
> +	if (IS_ERR(keypad->line_gpios))
> +		return PTR_ERR(keypad->line_gpios);
> +
> +	keypad->nlines = keypad->line_gpios->ndescs;
> +
> +	if (keypad->nlines > MATRIX_MAX_ROWS)
> +		return -EINVAL;
> +
> +	pin_names = devm_kasprintf_strarray(&pdev->dev, label, keypad->nlines);
> +	if (IS_ERR(pin_names))
> +		return PTR_ERR(pin_names);
> +
> +	for (unsigned int i = 0; i < keypad->line_gpios->ndescs; i++)
> +		gpiod_set_consumer_name(keypad->line_gpios->desc[i], pin_names[i]);
> +
> +	return 0;
> +}
> +
> +static int charlieplex_keypad_probe(struct platform_device *pdev)
> +{
> +	struct charlieplex_keypad *keypad;
> +	unsigned int debounce_interval_ms;
> +	unsigned int poll_interval_ms;
> +	struct input_dev *input_dev;
> +	int err;
> +
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

Not all of these are required properties. If they are missing the driver
will operate on garbage values.

> +
> +	keypad->current_code = -1;
> +	keypad->debounce_code = -1;
> +	keypad->debounce_threshold = DIV_ROUND_UP(debounce_interval_ms, poll_interval_ms);

This will bomb if poll interval is 0.

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

Missing "return".

> +
> +	if (device_property_read_bool(&pdev->dev, "autorepeat"))
> +		__set_bit(EV_REP, input_dev->evbit);
> +
> +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> +
> +	err = input_setup_polling(input_dev, charlieplex_keypad_poll);
> +	if (err)
> +		dev_err_probe(&pdev->dev, err, "unable to set up polling\n");

Missing "return".

I fixed it up and applied, please take a look in my 'next' branch and
tell me if I messed up.

Thanks.

-- 
Dmitry
