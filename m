Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756E42049
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818465; cv=none; b=oM6MP+qW75v37qWX2ZzsYUyKIeG5Vm1H1GOE+LgWWTJDxufCY74tAViCIAJeY7hU+w8edIAlTZO9VQgae/4YPiNRCXZ35S5X0aqgs3lJKNBxMc+LiyVUI434YwR26tY/ZAcbLmfNxAvqBA3VH29MUpqVgzNliVhQb6rk6f54liE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818465; c=relaxed/simple;
	bh=qyezi+5oRt5fdZzUTR89voTedv8Cri4rLMYuSwn4zhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f24AhydLSewCRns8aQ/wYzkAgXrhed1jQ5XTZXhlyan0FqcNl4tvikbNUb5PVZPAucl6OP5gVv0R2TH4r6mxGSdYLjESZsaf6ZwD4i8EevLXf7XPBXttyAOVAbDsEq0ddkTLm7UCZ/VZ8YGUFEk4J29QOFiNBtRekW9dvk42erQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh7aM00d; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh7aM00d"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd8097c709so2788467eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 19:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818462; x=1772423262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=be26L28JegJQaN5VnjZu90EYCa/zt+aS/UGDpDvVaps=;
        b=Mh7aM00de/iJ6otCA5Pz8XuRLL0S/1rUw5UorY3Sz37b5pRKynO2WbHSZ6zjA4uG6B
         xJXKD2PliM6FQniogoN3c4MXXKz9KGl4kcn9JAi3+tth9eAWAs0YFMLgVPAzAEhrtJ8y
         cuzL/7L7hFMD7yejTGQ88VGK0azXNfbWNwOmS1Qm0N0iSTDdMqjWO63aS9MSyms55UGH
         Ddw9t8LVEm0a85wEZClSKwbqWv1NlELCKaFlHcVDqalJQSll50dojPcSL4PuwVbgHdwe
         5cKjaTicFJw9BSNO8pwT2bil0rwegL7uY3YrScvYxCXeb58fbUry11GOv0xzdLrKywkm
         KBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818462; x=1772423262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=be26L28JegJQaN5VnjZu90EYCa/zt+aS/UGDpDvVaps=;
        b=UQc54uY8NwhJJUgW00kdjcThLg6Hl6fF2MsBfAwfUvdk+W8JSkAL0IwaIUiK27+7v7
         BJ1VlT+WC0j074+uqjm3hSu07W1wHuy2TS1KFqyswii5ex97XyO6q8zLbOr9BcAQrPku
         rKpxjfj46fwErs8foYmj7pdIZmC4vDgcIwRTCw0DuHWBa3jOtTBR/ESvkrT1dh3/0HRD
         uTUoh0OP82AIP2WTB8mbpjxopqaIvlP/s2x/lUqiMct2GZ5cmmoqGOLNXPAqWj0UQarF
         ynHaoK6AH9RFX+STffHRNcQOPswHllCxfqvlpjs5SBDZ+t8nUa4ZgYe5/GPfwIM5/+wh
         DDxw==
X-Forwarded-Encrypted: i=1; AJvYcCWaWW0nB0Ailz2iqRVv1zvNY9pcTZExYFYv0bDkScrG56Lzzs+A/RtPdtckOD1NqD1+hmRtd7GRmWjruA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5XlUG5Oykq7sPD//7Jxu1ErvVwU0fLriHUiAJZQPhUjqCxQd
	+emb0sFe/ng3bfRlT9l0QmdxAvSQabxpxnXIPhgURXTo0c+WqPfLr7pt
X-Gm-Gg: ATEYQzyKmNObqIzY9F4nWMSIwDJHWgszyj0ePno3V4CSD1gmj8KVcBm6i5b71enF+Rd
	gYm7/SFOZka5ggygI/2F72qtWFYsz0pFh2sqqL0qCpV2liuoP4PnC/P/ykTzfrr1hqLTCPY7JR5
	h7+BgsJI1AKZVZvkMd0J2xdZ6IeFEngw+GOmCDgrYbSiBM5k3JO03OWB0al4brLCeddu9u/m/5b
	T3ug5U8KHrNdMdkiiuwKhVJNG7a5I7dBzZak8o/U5xgV+UMKVJHQeZQdREC2t0ZLzLWOneYcfK9
	fHb6jXCO/qhUtmTn2LolT2AXsrpf35b2nWf+l4BHkBfKzb6/9scS28K4ltvTzyA1c92ANj1bABJ
	TRdKI1jQ7Yf3RRfHWTcCDmd2kM/WqjEiNuyaFJVHOq22IZJ2iyT3/xQ/VXVD4M9+fUF79Ynsz0j
	IBBv9RtYkxX5XkWsuWPie//dAJTl0WoGAiAe/QPSb5WgRd+5cjoMLBSjW7mVoAWot12uqdTo1Li
	Q==
X-Received: by 2002:a05:7300:324c:b0:2b8:64ad:ad4e with SMTP id 5a478bee46e88-2bd7bd5a2d3mr3270113eec.24.1771818461734;
        Sun, 22 Feb 2026 19:47:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe78b9sm4075021eec.18.2026.02.22.19.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:47:41 -0800 (PST)
Date: Sun, 22 Feb 2026 19:47:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Simon Glass <sjg@chromium.org>, linux-input@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: cros_ec_keyb - add function key support
Message-ID: <aZvNY-bIIJv2mv1p@google.com>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-2-dmitry.torokhov@gmail.com>
 <aZrencp4ZQnFC9OD@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZrencp4ZQnFC9OD@tzungbi-laptop>

On Sun, Feb 22, 2026 at 06:46:53PM +0800, Tzung-Bi Shih wrote:
> On Sat, Feb 21, 2026 at 04:37:10PM -0800, Dmitry Torokhov wrote:
> > From: Fabio Baltieri <fabiobaltieri@chromium.org>
> > 
> > Add support for handling an Fn button and sending separate keycodes for
> > a subset of keys in the matrix defined in the upper half of the keymap.
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Link: https://patch.msgid.link/20260211173421.1206478-3-fabiobaltieri@chromium.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> The patch looks good to me, just a few minor nits below.  I don't insist on
> these being fixed for this patch to be merged,
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Thanks Tzung-Bi.

> 
> > +static void cros_ec_keyb_process_key_fn_map(struct cros_ec_keyb *ckdev,
> > +					    int row, int col, bool state)
> > +{
> > +	struct input_dev *idev = ckdev->idev;
> > +	const unsigned short *keycodes = idev->keycode;
> > +	unsigned int pos, fn_pos;
> > +	unsigned int code, fn_code;
> 
> Nit: does declaring `code` and `fn_code` as unsigned short make more sense?
> Or they can be declared in the same line.

I do not think making temporary variables unsigned short changes
anything, so I will leave it as is.

> 
> > +
> > +	pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
> > +	code = keycodes[pos];
> > +
> > +	if (code == KEY_FN) {
> > +		ckdev->fn_active = state;
> > +		if (state) {
> > +			ckdev->fn_combo_active = false;
> > +		} else if (!ckdev->fn_combo_active) {
> > +			/*
> > +			 * Send both Fn press and release events if nothing
> > +			 * else has been pressed together with Fn.
> > +			 */
> > +			cros_ec_emit_fn_key(idev, pos);
> > +		}
> > +		return;
> > +	}
> > +
> > +	fn_pos = MATRIX_SCAN_CODE(row + ckdev->rows, col, ckdev->row_shift);
> > +	fn_code = keycodes[fn_pos];
> > +
> > +	if (state) {
> > +		if (ckdev->fn_active) {
> > +			ckdev->fn_combo_active = true;
> > +			if (!fn_code)
> > +				return; /* Discard if no Fn mapping exists */
> > +
> > +			code = fn_code;
> > +			pos = fn_pos;
> 
> Nit: assigning `pos` before `code` makes it neater.
> 
> > +		}
> > +	} else {
> > +		/*
> > +		 * If the Fn-remapped code is currently pressed, release it.
> > +		 * Otherwise, release the standard code (if it was pressed).
> > +		 */
> > +		if (fn_code && test_bit(fn_code, idev->key)) {
> > +			code = fn_code;
> > +			pos = fn_pos;
> 
> Nit: same here.

Yep, I'll update before applying.

Thanks.

-- 
Dmitry
