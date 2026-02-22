Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3F136358
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720759; cv=none; b=eH2hCx5h09973JVaG+pceG+YBruEqfmV9fk0iagDD3H4osSWcJ1wMB+EA+7sDUliMts7gdd6HcXay9JLfqONHnUKleKt1VkI+WlHflK8NyNbIpLn4BCEK96w5vqYN6hRiih7GoBvq7plsjTLJ2OjsdryUO/hYnqmoX4q2hcboTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720759; c=relaxed/simple;
	bh=/NrEAiERqs5xvAOfLmrFSIDyHlICGxMThAs8q6g1SwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZdY0crL5U7cuWN0YJ83ZezET5IyUCcF8bJBCpIsie5ZuFs5qreni0n893azGKpQJZW5559QO5FMcxnxo+a7KxogUozEXUBXj/rGLb3RuUSv6zyhTuK6NBPwZz0oBjlxiWZpyHvZhA42deK8yLuCN84PU/LOBXSj6RMVV20PWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFY8ZNBp; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFY8ZNBp"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12721cd256bso3643919c88.1
        for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 16:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720757; x=1772325557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKYjLrAHd5aTWbt8yMmjZEe0vbqg6p9D4PpS1+LirKA=;
        b=AFY8ZNBpZWyPeJ7qjQEPYOQPTrrkjne5bTcyBIBHg/ekBwqFXoo1iz5itdPqQqkOHL
         OrEwyM/e0B5Xuh+vducugw6UrpOj4K2o842pFsglyeavsInAUpVN0zbMU/uHSHA0ZE0Y
         1ySN1KK3JE7K+Y1vgpLfg+QFv4LyttTK3Zq2uMpDebmQSBIpkgyiKiUe26tghxv00mHY
         KNnwFAuokXIwNfhuG6JpOrf4cxuXOCWLFMHlnAL7ATbWxV8e+mTherRmN8J+x4UqbtGP
         7agaLzJXXu7m4ZttjndqeyOFbAD5UtCGdieEQncoCsuNvo0uyhL0mbBS8B4loAuyFMXh
         0ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720757; x=1772325557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKYjLrAHd5aTWbt8yMmjZEe0vbqg6p9D4PpS1+LirKA=;
        b=ZzEhAiBCIPuf6Qefj2q3b8QmwBiAn0OoXyPOj8eEFfk57W1l3eqMNTnV/pr/rx3CBr
         3CLXmE5ihgiNipbm3TVpaAhbYoS5QrKbm1AwMjn+kY4y+5YayFmPWE7v8sh8cA3FsAMA
         gt96tIptVXgCwhLHGzwPMjchqtLUu8IyQtVaTDYbxrgxMlox54umLE8/WhazWhHXNyvI
         AJgoP6/Pu6eVnGI5FT2TRkHitN57YIrVd0/78ujQd0b/Vdj9AQspUrQeZKTTK8Q1KZ75
         NhHPNL4irbWW3kMTXZNaGokCps+BAG3Cx72fNdDdGc6/pISIkQgda8D6/M1fR3A9LR/t
         VKtw==
X-Forwarded-Encrypted: i=1; AJvYcCVqhsCRuV+pYwLPol4k3TXpXbm9D93964RVw8guWv4thFIIWiS2ignctLikculcXYQrbAvVXHE0m+W+bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGyEsKg30aR8Z9APZ81MNkRfLgcsn1vaSWl4mVRIMzNu3QGMLR
	DluJawPJVMHSdmI/yD58d+Gi5RFbGXJeA3D3Nk1zQB0TLDJw4sl6URjtcST5DQ==
X-Gm-Gg: AZuq6aIegojPxy52GgN6RftQ3sKR8BrERklRBZujPbFEeQ3VsL2tLjp0pT0INpvn8cH
	NlGbmZTaLAVdi7TvuGSwZcwKobA0YaBicCRMVXNJBD/UaVtiyQu5hmDY58R2TUx35R/U4Aq2RUe
	RXtEVYDqu+WMU7wsTWetcpWv4/aDjq7sWhhWG0/NAtu0OZ9eXiQY4wWfpP9FZuBaezIoWdi1lfp
	GBadH5Uf0FD0OY1lcptOcAT2jWQ+VwbOnZAHZiyVLuNiM6MhWG9VTNZBJUIyqrJtBuuRTEIPwVq
	UViM1kVgvb7MdfcKoNRk2wF6ePhYhFwudANUGlGtciqgN+4ezeXBppjBAhYiNRIWcSZfUaJgBaQ
	x1Ptbyv+mhgCRcbPuxDmcmyJDilJEbEfBT7X8SR3GxAGRuK9NyX6rrR/xb1bTHLENrcaSrb61f3
	2KEq6fniqUathCLr0zTAlqi2EfUB3Hd7taNQNFNWKKhcdztRfaT2Qn3bblHrrqf3g=
X-Received: by 2002:a05:7022:a8b:b0:119:e569:f61b with SMTP id a92af1059eb24-1276acc2b9bmr1945251c88.20.1771720757247;
        Sat, 21 Feb 2026 16:39:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:73d:b075:516c:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8a657sm4086704c88.12.2026.02.21.16.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:39:16 -0800 (PST)
Date: Sat, 21 Feb 2026 16:39:14 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Simon Glass <sjg@chromium.org>, linux-input@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] Input: cros_ec_keyb - add function key support
Message-ID: <aZpPz34uC8EXK70j@google.com>
References: <20260211173421.1206478-1-fabiobaltieri@chromium.org>
 <20260211173421.1206478-3-fabiobaltieri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211173421.1206478-3-fabiobaltieri@chromium.org>

Hi Fabio,

On Wed, Feb 11, 2026 at 05:34:21PM +0000, Fabio Baltieri wrote:
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

We can simply scan the bottom half of the map linearly, I think this is
simpler.

> +	}
> +
> +	return false;
> +}
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

Same here.

I made a bunch of changes to your patch and then a bunch of changes to
the driver in general. Please take a look.

Thanks.

-- 
Dmitry
