Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7E139D0A;
	Sun, 22 Feb 2026 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757217; cv=none; b=Hht8uq8YUKS4K1Ti9V75fUmRBeEi0v2mWUd+fEnktyfkp0qmQ0hBVP7Yez5f1pxDAOhCjsbvQUlw/FLWTDpTUBbFh3+VeJ7Ysk7+VXU2jr4sP48z6aYlr4JHL5/3wCv9c6fJ7LQQW+CJk4vNZ+CJc2DrLcjTN1uu2j7HJIqkye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757217; c=relaxed/simple;
	bh=r1gVFMTabNQZd6ClZBOk6UIACQ2lN7iRLUEk4zcyZes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcfp6+oJ5uDOmqfpY0fDNtmaob84k7wUhuOT5/ZXereUIMFsndjzENZPDnHgE8Jae9+809VsnY6/1Ywg3IFYzlMV7rfoAj0V9ZDouK/+e264VIqmmZtYyzgj6BhFSat0fRPyX07OUFlQQ/Gega+x1rk2SF0BkTOlvJDximzpiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQrX2P3B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQrX2P3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73843C116D0;
	Sun, 22 Feb 2026 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771757217;
	bh=r1gVFMTabNQZd6ClZBOk6UIACQ2lN7iRLUEk4zcyZes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQrX2P3B/SyFXTplrdxpB1Vu0udovR5yJ3BkIjBFXLWhEDFjWkTzt4/5PtyAPpQjQ
	 uR/4eqGyVIYWvmrH85QQka5as4AH4OYMGSCmHrLP5b5LUgk1MTxZb2YzqaZBcI6b6S
	 vhyz4z00zT5rPI38P9PPhni7joI0+MvL5GAEvvyQpuqSDqcixloamgYjvJZCKvgVkk
	 1jPblc/nsjVT3fJRWCu+omskhxNWk9v/wQRVGVbcmhaZpEsqWDijET5wEnEzOBsORi
	 pKK2Vfe7fDBEIomFKxSe6kpjcyoniyKoY4pddNGXHi/Mx4HiXG+phDuTLxh9/+aU/R
	 qfWq2Q+yovIQQ==
Date: Sun, 22 Feb 2026 18:46:53 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: cros_ec_keyb - add function key support
Message-ID: <aZrencp4ZQnFC9OD@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-2-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222003717.471977-2-dmitry.torokhov@gmail.com>

On Sat, Feb 21, 2026 at 04:37:10PM -0800, Dmitry Torokhov wrote:
> From: Fabio Baltieri <fabiobaltieri@chromium.org>
> 
> Add support for handling an Fn button and sending separate keycodes for
> a subset of keys in the matrix defined in the upper half of the keymap.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Link: https://patch.msgid.link/20260211173421.1206478-3-fabiobaltieri@chromium.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The patch looks good to me, just a few minor nits below.  I don't insist on
these being fixed for this patch to be merged,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> +static void cros_ec_keyb_process_key_fn_map(struct cros_ec_keyb *ckdev,
> +					    int row, int col, bool state)
> +{
> +	struct input_dev *idev = ckdev->idev;
> +	const unsigned short *keycodes = idev->keycode;
> +	unsigned int pos, fn_pos;
> +	unsigned int code, fn_code;

Nit: does declaring `code` and `fn_code` as unsigned short make more sense?
Or they can be declared in the same line.

> +
> +	pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
> +	code = keycodes[pos];
> +
> +	if (code == KEY_FN) {
> +		ckdev->fn_active = state;
> +		if (state) {
> +			ckdev->fn_combo_active = false;
> +		} else if (!ckdev->fn_combo_active) {
> +			/*
> +			 * Send both Fn press and release events if nothing
> +			 * else has been pressed together with Fn.
> +			 */
> +			cros_ec_emit_fn_key(idev, pos);
> +		}
> +		return;
> +	}
> +
> +	fn_pos = MATRIX_SCAN_CODE(row + ckdev->rows, col, ckdev->row_shift);
> +	fn_code = keycodes[fn_pos];
> +
> +	if (state) {
> +		if (ckdev->fn_active) {
> +			ckdev->fn_combo_active = true;
> +			if (!fn_code)
> +				return; /* Discard if no Fn mapping exists */
> +
> +			code = fn_code;
> +			pos = fn_pos;

Nit: assigning `pos` before `code` makes it neater.

> +		}
> +	} else {
> +		/*
> +		 * If the Fn-remapped code is currently pressed, release it.
> +		 * Otherwise, release the standard code (if it was pressed).
> +		 */
> +		if (fn_code && test_bit(fn_code, idev->key)) {
> +			code = fn_code;
> +			pos = fn_pos;

Nit: same here.
