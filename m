Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA63242BA
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395119; cv=none; b=Dt+Sf0yHT0GR++Co/9GNTWoG74k9N48raxIABPcOqFfArOxvOVgEfJQjw+cKFXzhisAaL+NQiMUBibGfVV0L+0xG3NyqwhfVx+1Tri5yd2XVMXxpgZ/8T8zYB4qWrKFFAiLDjKqvzHqwuJyNJGYZYkv8kDThJtpct2FpRGKiPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395119; c=relaxed/simple;
	bh=tYAFtqpNqJ2j6AfUbmbB/ETc0ACPv26cwfogADixaPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJB58aQ+C/sC1dWxlJPeGHhPsBIFFSIa5NVGwmO1Oj1qfYqChYgEnDqlI3A+JzYKweiNZo6JI2EFXAzbD+ZNVid+618LkasqrjLLzjsHQW575yne2jleruhQdiCkaZqYX223PC5IKewIINIX9/eo5N40jIymGGH1r6nINJIXmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPYmLKQp; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPYmLKQp"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4e9694so4106998c88.1
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770395118; x=1770999918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUWtbfsvW64YTIXL+5vxGulTQUN+A2ZBdXgHdgXDn/8=;
        b=mPYmLKQpJcSZvk0WCH76ROb6hAvLCMCNU4VAg03WPI5NBMbkhYpXKzjM4gdGTk+fB/
         by+lnRbyDzMykwiIkuNCmhlSkQQew6illk2GrVTAtVx4nsgrczWaAvyZRx+66jMRfPk+
         lSk4i9gG5shX62LonSwmVz+pIdOQAwSWu6yuJid7sXAwPk4+rJYks7105Gn6N9fjjryU
         gwNPlTLxpe9M3/GI0I1TjBZjSivMxuB9CGDvUQ7KTX/mLYoo79l43Uh4W7vwt4Bhk+mW
         lcwWcNbg1jQ5xTY60h/wvQb3lx0nJYC7tVpLNHJvz7KwS15K+hsavKWWhkdyrkoixIem
         Dwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770395118; x=1770999918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUWtbfsvW64YTIXL+5vxGulTQUN+A2ZBdXgHdgXDn/8=;
        b=IG0vUBz4jKnF7NBdtzQWlefkOqt0ZFB5mSo2ehRi8foGEA7pfA1WXzOD445O7GhoNb
         ltL2VOmrhdGvj9+tHDPyecVy6oTXxX7MxEkELfm1sv3AEeHzBA4DvEuf1lQrPfCbDHeu
         YLiGD7lk/yJ8kRhYpumJE9Tv82uIvlerWGxDtYLJPbGBwGZ5N0sYU+AVWUy9aAoXqkho
         c+oBCmAOyaqbyuDQu3yg0kIUR4in0eqUHUWDGBL1qQmuuRHEPw3j7QRKKgY+kE3VJjPA
         Z8/1dIcNvM2bL31m1dTJS1551VbcvEJAXfbdksUUwctq4wphPJLGgdL2eW760ibAjBhw
         6iIw==
X-Forwarded-Encrypted: i=1; AJvYcCVIA4rGHFXbJTJwr0+oEtb/0gFlS0wf3TeWHEtfpilt8lefeTFZ6kuW7ySID6BV/b9g4oZUOFFJ4Cu5HA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAenRBB2eiYdv6g1YjqovlyRF4LIKx56wz9YwcmhF/uYW2jru
	IL85IQcBUrcj1dM+omhQAwgUyDRNf3E4Z8uQQKnxb+JPTlN+pf9ntjcE
X-Gm-Gg: AZuq6aJ/V4I7LU2kGKvbryT3IIcddZkcq1NyWF7BWFtoQbkZ0M0+R84G/iUrfvJOOQ+
	WBojg/6+ljaowdO2cdGeo6+/IeYi41mtEiANrew8Wp8/auUFjfvDPRDCkKqyk6zTqIr2gjfnPFu
	MNYYmB4JADi5SQuDc6I07VRv3StQ8oBdn7Vjfnt7Ft0vLIciiRUgqs2SEOlJABJoEO9DOkKhvy+
	/Uu2pAM9NZ+64g+PCQ/zQkEiTwIDSorEiDzMxCWiGaWL3SPZSFtE1qbojF+3eZCZCqUnQkHsf+Z
	gUuFUAjUUUfXdVaEPHVPxhbXcjhLciZLTXPH8XjhZmAI99fBjh6fic8nApwJzPiJWh9GRia4XlJ
	C7Y7ITFtX+Mq52aJBPgQGyw9CVfMvv9yj+8BHT8sSNfZW5V+ng5rzfIQ/Fdb7lW8pNViPUoja4e
	MoXJi1LkGGW0Tf91vobG75I1NhAuOIkx6yPV4cSTk+V0O428DTJb9R
X-Received: by 2002:a05:7022:252a:b0:124:9acd:3ef9 with SMTP id a92af1059eb24-12703f71728mr1777180c88.8.1770395117850;
        Fri, 06 Feb 2026 08:25:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:959b:12e3:1522:2dbd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm2880427c88.8.2026.02.06.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 08:25:17 -0800 (PST)
Date: Fri, 6 Feb 2026 08:25:14 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Simon Glass <sjg@chromium.org>, linux-input@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] Input: cros_ec_keyb - add function key support
Message-ID: <aYYTgxi0mcPVgpTr@google.com>
References: <20260112093309.240905-1-fabiobaltieri@chromium.org>
 <20260112093309.240905-2-fabiobaltieri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112093309.240905-2-fabiobaltieri@chromium.org>

Hi Fabio,

On Mon, Jan 12, 2026 at 09:33:09AM +0000, Fabio Baltieri wrote:
> Add support for handling an Fn button and sending separate keycodes for
> a subset of keys in the matrix defined in the upper half of the keymap.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 174 +++++++++++++++++++++++---
>  1 file changed, 158 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 1c6b0461dc35..93540f0c5a33 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -29,6 +29,11 @@
>  
>  #include <linux/unaligned.h>
>  
> +/* Maximum size of the normal key matrix, this is limited by the host command
> + * key_matrix field defined in ec_response_get_next_data_v3
> + */

The comment format for multi-line comments is:

/*
 * Line 1
 * Line 2
 */

> +#define CROS_EC_KEYBOARD_COLS_MAX 18
> +
>  /**
>   * struct cros_ec_keyb - Structure representing EC keyboard device
>   *
> @@ -44,6 +49,11 @@
>   * @bs_idev: The input device for non-matrix buttons and switches (or NULL).
>   * @notifier: interrupt event notifier for transport devices
>   * @vdata: vivaldi function row data
> + * @has_fn_map: whether the driver uses an fn function-map layer

I do not believe this flag is needed. Always do FN processing. If there
is no FN in the keymap it should work just fine.

> + * @normal_key_status: active normal keys map
> + * @fn_key_status: active function keys map

I do not think you need to track state yourself. A key will be reported
either from FN part of map or from normal one, so when you get a release
for (row, col) you can check if FN-mapped key is active (using
text_bit(<fn-combo-code>, idev->key)) and if it is not active then send
release event for the normal key.

> + * @fn_key_pressed: tracks the function key status
> + * @fn_key_triggered: tracks where any function key fired

Maybe it should be called fn_event_pending? You set it together with
fn_key_pressed and clear if you get any other key press?

>   */
>  struct cros_ec_keyb {
>  	unsigned int rows;
> @@ -61,6 +71,12 @@ struct cros_ec_keyb {
>  	struct notifier_block notifier;
>  
>  	struct vivaldi_data vdata;
> +
> +	bool has_fn_map;
> +	u8 normal_key_status[CROS_EC_KEYBOARD_COLS_MAX];
> +	u8 fn_key_status[CROS_EC_KEYBOARD_COLS_MAX];
> +	bool fn_key_pressed;
> +	bool fn_key_triggered;
>  };
>  
>  /**
> @@ -166,16 +182,104 @@ static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, uint8_t *buf)
>  	return false;
>  }
>  
> +/*
> + * Process a function key state change, send an event report if appropriate.
> + */
> +static void cros_ec_keyb_process_fn_key(struct cros_ec_keyb *ckdev,
> +					int row, int col, bool state)
> +{
> +	struct input_dev *idev = ckdev->idev;
> +	int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
> +
> +	ckdev->fn_key_pressed = state;
> +
> +	if (state) {
> +		ckdev->fn_key_triggered = false;
> +	} else if (!ckdev->fn_key_triggered) {
> +		/*
> +		 * Send the original code if nothing else has been pressed
> +		 * together with Fn.
> +		 */
> +		input_event(idev, EV_MSC, MSC_SCAN, pos);
> +		input_report_key(idev, KEY_FN, true);
> +		input_sync(idev);
> +
> +		input_event(idev, EV_MSC, MSC_SCAN, pos);
> +		input_report_key(idev, KEY_FN, false);

Why do we want this? If you want FN to behave like hardware switch you
probably do not want to send KEY_FN at all?

> +	}
> +}
> +
> +/*
> + * Return the Fn code for a normal key row, col combination, optionally set a
> + * position code too.
> + */
> +static unsigned int cros_ec_keyb_fn_code(struct cros_ec_keyb *ckdev,
> +					 int row, int col, int *pos)
> +{
> +	struct input_dev *idev = ckdev->idev;
> +	const unsigned short *keycodes = idev->keycode;
> +	int fn_pos = MATRIX_SCAN_CODE(row + ckdev->rows, col, ckdev->row_shift);
> +
> +	if (pos)
> +		*pos = fn_pos;
> +
> +	return keycodes[fn_pos];
> +}
> +
> +/*
> + * Process the new state for a single key.
> + */
> +static void cros_ec_keyb_process_one(struct cros_ec_keyb *ckdev,
> +				     int row, int col, bool state)
> +{
> +	struct input_dev *idev = ckdev->idev;
> +	const unsigned short *keycodes = idev->keycode;
> +	int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
> +	unsigned int code = keycodes[pos];
> +
> +	dev_dbg(ckdev->dev, "changed: [r%d c%d]: byte %02x\n", row, col, state);
> +
> +	if (ckdev->has_fn_map) {
> +		if (code == KEY_FN)
> +			return cros_ec_keyb_process_fn_key(ckdev, row, col, state);
> +
> +		if (!state) {
> +			if (ckdev->fn_key_status[col] & BIT(row)) {
> +				code = cros_ec_keyb_fn_code(ckdev, row, col, &pos);
> +
> +				ckdev->fn_key_status[col] &= ~BIT(row);
> +			} else if (ckdev->normal_key_status[col] & BIT(row)) {
> +				ckdev->normal_key_status[col] &= ~BIT(row);
> +			} else {
> +				/* Discard, key press code was not sent */
> +				return;
> +			}
> +		} else if (ckdev->fn_key_pressed) {
> +			code = cros_ec_keyb_fn_code(ckdev, row, col, &pos);
> +
> +			ckdev->fn_key_triggered = true;
> +
> +			if (!code)
> +				return;
> +
> +			ckdev->fn_key_status[col] |= BIT(row);
> +		} else {
> +			ckdev->normal_key_status[col] |= BIT(row);
> +		}
> +	}
> +
> +	input_event(idev, EV_MSC, MSC_SCAN, pos);
> +	input_report_key(idev, code, state);
> +}
>  
>  /*
>   * Compares the new keyboard state to the old one and produces key
> - * press/release events accordingly.  The keyboard state is 13 bytes (one byte
> - * per column)
> + * press/release events accordingly.  The keyboard state is one byte
> + * per column.
>   */
>  static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
>  			 uint8_t *kb_state, int len)
>  {
> -	struct input_dev *idev = ckdev->idev;
>  	int col, row;
>  	int new_state;
>  	int old_state;
> @@ -192,20 +296,13 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
>  
>  	for (col = 0; col < ckdev->cols; col++) {
>  		for (row = 0; row < ckdev->rows; row++) {
> -			int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
> -			const unsigned short *keycodes = idev->keycode;
> -
>  			new_state = kb_state[col] & (1 << row);
>  			old_state = ckdev->old_kb_state[col] & (1 << row);
> -			if (new_state != old_state) {
> -				dev_dbg(ckdev->dev,
> -					"changed: [r%d c%d]: byte %02x\n",
> -					row, col, new_state);
> -
> -				input_event(idev, EV_MSC, MSC_SCAN, pos);
> -				input_report_key(idev, keycodes[pos],
> -						 new_state);
> -			}
> +
> +			if (new_state == old_state)
> +				continue;
> +
> +			cros_ec_keyb_process_one(ckdev, row, col, new_state);
>  		}
>  		ckdev->old_kb_state[col] = kb_state[col];
>  	}
> @@ -582,6 +679,43 @@ static void cros_ec_keyb_parse_vivaldi_physmap(struct cros_ec_keyb *ckdev)
>  	ckdev->vdata.num_function_row_keys = n_physmap;
>  }
>  
> +/* Returns true if there is a KEY_FN code defined in the normal keymap */
> +static bool cros_ec_keyb_has_fn_key(struct cros_ec_keyb *ckdev)
> +{
> +	struct input_dev *idev = ckdev->idev;
> +	const unsigned short *keycodes = idev->keycode;
> +
> +	for (int row = 0; row < ckdev->rows; row++) {
> +		for (int col = 0; col < ckdev->cols; col++) {
> +			int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
> +
> +			if (keycodes[pos] == KEY_FN)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}

Not needed.

> +
> +/*
> + * Returns true if there is a KEY_FN defined and at least one key in the fn
> + * layer keymap
> + */
> +static bool cros_ec_keyb_has_fn_map(struct cros_ec_keyb *ckdev)
> +{
> +	if (!cros_ec_keyb_has_fn_key(ckdev))
> +		return false;
> +
> +	for (int row = 0; row < ckdev->rows; row++) {
> +		for (int col = 0; col < ckdev->cols; col++) {
> +			if (cros_ec_keyb_fn_code(ckdev, row, col, NULL) != 0)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}

I do not think this is needed either.

Thanks.

-- 
Dmitry
