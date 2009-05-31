From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Sun, 31 May 2009 19:39:01 +0200
Message-ID: <87bpp9qiiy.fsf@free.fr>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	<200905271526.59064.u.luckas@road.de>
	<f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
	<20090531142027.GA22540@n2100.arm.linux.org.uk>
	<f17812d70905310729r501ed41fja622392c187c5cbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:52914 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbZEaRjO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2009 13:39:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Eric Miao <eric.y.miao@gmail.com> writes:

Hi Eric, some minor cosmetic points ...

<snip>

> +static void activate_all_cols(struct matrix_keypad_platform_data
> *pdata, int on)
That function declaration spacing looks suspicious, looks like my mailer (or
yours) ate a bit out of it, and patch doesn't accept to apply it.

<snip>

+static void activate_col(struct matrix_keypad_platform_data *pdata,
+			 int col, int on)
+{
+	__activate_col(pdata, col, on);
+
+	if (on && pdata->col_scan_delay_us)
+		udelay(pdata->col_scan_delay_us);
+}
That function is called is the worst case 16 times in a row (if I understood
correctly matrix_keypad_scan()). If delay is 100us, that makes 1.6ms for a
keystroke with all kernel blocked (udelay).
I didn't follow the discussion before, so maybe that's the only way. Still,
that's too bad ...

<snip>

> +/*
> + * This gets the keys from keyboard and reports it to input subsystem
> + */
> +static void matrix_keypad_scan(struct work_struct *work)
> +{
> +	struct matrix_keypad *keypad =
> +	       	container_of(work, struct matrix_keypad, work.work);
> +	struct matrix_keypad_platform_data *pdata = keypad->pdata;
> +	uint32_t new_state[MATRIX_MAX_COLS];
> +	int row, col;
> +
> +	/* de-activate all columns for scanning */
> +	activate_all_cols(pdata, 0);
> +
> +	memset(new_state, 0, sizeof(new_state));
> +
> +	/* assert each column and read the row status out */
> +	for (col = 0; col < pdata->num_col_gpios; col++) {
> +
> +		activate_col(pdata, col, 1);
> +
> +		for (row = 0; row < pdata->num_row_gpios; row++)
> +			new_state[col] |= row_asserted(pdata, row) ?
> +						(1 << row) : 0;
> +		activate_col(pdata, col, 0);
> +	}
> +
> +	for (col = 0; col < pdata->num_col_gpios; col++) {
> +		uint32_t bits_changed;
> +		
Nitpicking: extra space on that line.

<snip>

Cheers.

--
Robert

