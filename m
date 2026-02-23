Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7A365A12
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849456; cv=none; b=oOVd8HCRtBoTFmAkkJ+dmr0QIjQehzHap11hcBYHBaC6ujQtm/xYpXaraVN/ZpFvPz2Q8Mw4HQUN3JP4PQJRw+noFc/ke9j4niOPyZb85u8eAlor+t63cFHRyYjlWwGfHuDGpXvJZTTFgZ7MYxBagkVQeqph0pIE7h2tuyhpDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849456; c=relaxed/simple;
	bh=1TDlDOmYb+z5xkrCSTxJg2Hro4ku/GuAYlkD3H61Gms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSPGyqjx3uKWANjZXH3p0KlV6QLcf2pHFNBVz6Dd9GC9YbAgwYhWRxLLcqig9UR7AMAcoasGMf1sSPKxgIgaBimYqnoDUd3S77bbhyNNG6k9YfUdwo++5SufnsM867o2OulMNhayB9U9kgV6YNaTFUfaOOiT/hoEFv7z1/2Rbdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W80/H4Zj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W80/H4Zj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4834826e555so41172825e9.2
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 04:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771849452; x=1772454252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2yVlt+t2uIX/rNvX0LVoxha+PLrUtJBpnUZ+jxIJze4=;
        b=W80/H4ZjWWpQM8VFtuaE68jNh67XO40HxzUZCKmaGB3kw4/MioBJ7TDZ2SeGXqyjuO
         iBhIMmPvt8BpId+mtupff2fzBEjcnYpnXqdcSos1fZ55xBqcEJbuDc5SUg01jkVzuzOK
         jGtDxD1pPoAGaYUjTavajS/mkWuGDzQ17V65c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849452; x=1772454252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yVlt+t2uIX/rNvX0LVoxha+PLrUtJBpnUZ+jxIJze4=;
        b=HllGPkGAgCgusvH2qM6lNrs5LrDaUyUWZhHmVLPMHdQU/WAjAPDCcyholvXWspzN2y
         Mv4bcvD+zcQZAvNTc1W3KEpiMnOpauXIlPA7hlbCkZ6YIpd2fl7DDQbGZ9f4Io0vgWc8
         vc87NHwHvxIzw6q9MCID9MvK0ZUbSS6KzTdfZo4VdvebJ9IkFt0v15hjO1mtBxclMl3l
         sxkkByRj9XvepKRHGD0CLj8TsImqCOHfVzh1CZeC0R5kcmVcKvwn+BhrzBmwGrnTOzuZ
         cjI6DG8x2w5Y6u7KLVGUyZpqfdYk39spQUATrww2uuCaHQjnCVmcu+VkEPnaJLOAZNTn
         DNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmFWGdZNnuUkIJIkLDgZMnGDy4dZtrISAMWjxfdZ1kCeBRHkKHQ7zfli5rxI9I9XWW74OcPzn4qTNq5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUy+L/J2WAtBOuM1rJJMBNjQVBtqi+PrItBgQyJBL684TVIoMA
	KXgKogWeB1CWuEWzhi8mK0KgeUUxX8sMkkPiK+wyeDi7MfbvuayigapznWcNBQCnsw==
X-Gm-Gg: AZuq6aIVQTX+D1mr+Ykx8WUEZ/f7u8xoeCijYmc+CS5NOYFUwx7+ggI6zOvTlnsTX9L
	Ht5FZoF/Ojab8qGBaaU5KFH3zm8r9DJUJ5AHOX2s4Me9QIdXHJpqIS0cGYL+mBQ+hAA0usKWpVq
	2panSuZn6ABE0YvUonm0S8LaBlJ9Kn81dE+G3YOZMJcNZR0Tt1MNMePdBEpUE56WSnZ4uza2D1k
	RL9s1AGkl39fIpqBxSgHcRr7iBhDT00NWCw6Z62NlV8y0XgrVorioPafy28Mh41UFnpwxDzboTC
	xCvVOrUELQeMoMO47/mEAV7yTmi+mGJaE4qv0VTL4jdEVk+k08D2yX7+dN594hCCZX8C7k+jFjq
	EMzXKf6jXg3m+ydHqSrpSpdx60X6Z1MtNbt2R4ShiYoxRQuKwtah9aVBeU8kgIBmmz5RaZjQxo0
	phNVeDQzcjfzwTsi5r1myPqMonge87Tg==
X-Received: by 2002:a05:600c:3150:b0:483:b3d7:2e87 with SMTP id 5b1f17b1804b1-483b3d72f25mr32318865e9.10.1771849452025;
        Mon, 23 Feb 2026 04:24:12 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b57e5db1sm16094365e9.7.2026.02.23.04.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:24:11 -0800 (PST)
Date: Mon, 23 Feb 2026 12:24:09 +0000
From: Fabio Baltieri <fabiobaltieri@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Simon Glass <sjg@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: cros_ec_keyb - add function key support
Message-ID: <aZxG6cJmAuAPpoi9@google.com>
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

Thanks, happy with the changes, gave it another run on my test setup
with the whole patchset, all looking good.

Thanks,
Fabio
