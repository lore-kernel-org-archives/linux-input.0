Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517632F765
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900880; cv=pass; b=ptIqN63pRdkcf+yQ/OwklxVJ5Jw2ClQ5tloX22bSqSK8f9kD18IoXSY6Tf/P2nYPOduEaydJd+q9nyeulHKA4y15V+jAiF25NPq4bUsEgKTfSF1B6/4IHsJsWcB031bpPQivHl7oaHiC62nayHj9MyZNXhVuI0BM2kqbIjiqGo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900880; c=relaxed/simple;
	bh=OQM/JImcjfi7wjn+4RAr7hfALL5l2/w4sROJP8Xbv6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKg8DA+RMVRu9Q3lpsVvR4sNrNx2O6G/4pnQ6bfI++k6rgLt3vISqoH0KiiuLUswVUVpA+lwL9adIHL0tRIGjCrbpDrs7YCSW0L4yXLpjhlyUasG3gFO6/zNhYa8+kKhDNomrLaLfEnWB/CAi7Ixk8mdE8Uo/7CFmoJ3asn31sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmAG50nz; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmAG50nz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c1915793so22582535e9.2
        for <linux-input@vger.kernel.org>; Sun, 07 Jun 2026 23:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780900877; cv=none;
        d=google.com; s=arc-20240605;
        b=P0TwITAE2noJsxG1BBS1DyKw7IEt7wZfzjTN+G3GcjoRBXJdblKZnWnYh8iUH9TPzH
         Bn0Pb0ZNVq0Ksqt2a35sJWC5oQk7PLO+QVQSz5AieDIsrxxyfVwRZsqF36Yfo3joRHPV
         qnWr+YDPqNv8UDf+5TFC7srTe9XDtbeEVNJLZboqi/JSgGSBtJyA60hVEayEuHFqwXAn
         i3X/3z88TfmW7iXU92GZTqFLZuZuqlxjKj4xwqcTAdzDzbvVYky6DzioUB5AFBA2O6qO
         fDjY9OMdSTsN+OiosgdvA/oLyUsoV6O72TjcEzJhzA0yRtWpmAwFfMXlDr5a/6eP5KOR
         2PoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X0TaOt7Y/rToPgZKPJf/wU2SzirryT8Q6bE6xjghko4=;
        fh=XK+Z+4XQ9f0xzi+QH/n7PYPNngsoj1sw83l1C9geJu8=;
        b=KUe7FEkTKP3iw4bOMWY5QKej2EnvfTEKVvExIMt6m4XHUsqhR4IrW9XKZx14NtaiLT
         BN+Mz7EBj2uQ60nP1P6RXu1tp5CWWXAyAyz1lZT2ekpBcrLPoFqYLNnV5euQ5LXQJJ0l
         txmjUcRwQ0hbubkzqkHqjKrCts4/WRMKwPFOD/BpGRZpqiwtsrpQlGFgq/ixKy15zTvn
         G4xToJLwJoyFSfWVCTiPptXaLDOVQI6yMs96RPlqOU/hvSjq4lvV/RDPBG5IcJwEdHnt
         nEOxbAz3acxOj5Xfq6yx12MlMGgCF90GaeE6B3qdRDQ+YCH53aPxsweke8q4kENkk+6d
         iI4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780900877; x=1781505677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X0TaOt7Y/rToPgZKPJf/wU2SzirryT8Q6bE6xjghko4=;
        b=QmAG50nz/M9yYl3c9417dWgUDXkoEY2kppsMO4BL6CjqCHOOkr19dh93S/hwB3l3RY
         ioI7Af0aqZzludJp8OwmFKzVJi6R3Bk25BdGOtryDLyjZ0HVqIey3Qguol8/zIOmQzv1
         0WfheI8eiDrW6Khaoqp3amDlVLo4EKQocJj/G4P2gqXyAXpTYyB62D5V5ELquXR+rqlo
         LukXM7ca9mD/lycW7f0gqoYcfVrj7PS55cXNy+c4c1mWilH89xWMHI/8q8xJ/PFY5bSx
         uuWCaj7yaYNJPuL2HGFyzGc0Mqk6OTlKb/jfGtLfw5De5vl0WBZd83GLG6Q1tGprHqvV
         SdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900877; x=1781505677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0TaOt7Y/rToPgZKPJf/wU2SzirryT8Q6bE6xjghko4=;
        b=QUoTxZRexFI5fBEhzPfSv135FHUwZTkeQpnYtAdndaxdwHJNDz63t66OdyP+iIZc86
         U7um6QZzzizfpkxFx/07toRi1zfpNDoZzlP1btyJn5LzAX+L8zWd8TXA2uEts+7pF159
         vfbqMJIxrBeI8U7JnFFoAJAIo4OArt68cBc4d1ubQS4js49r/nlhTZoKah8NkVupj+DF
         vgmr+4of0YhIqZOISjM4bKnqdOO3KJkIEFsestC+K6yOLTdXQMNbJjg8qqmWoPWeDqyn
         E4CmZWKGOetlnj2yR9wtmUJVmu+6B0he5QEp5WRifaOu+5A813KObrnM0UPIpoEh05m0
         E8qA==
X-Forwarded-Encrypted: i=1; AFNElJ+dIXdDXqePHtV+srMzpv9zadLtGXin6q7aGhlliSWMhAuA9eGgM/NdzaTKzucBKmcVMa/oQcGe5S8UTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxgwTY1W9XKTZumEs4n0lWBSY0cKPBDKF7Ju1eI3LeeC7K9jmG
	5cWd/bj/HkYDrwKxqjTzlowarnnYz8pCIstUAEbFKOWDgStnhchj3G1tlF0XkJ/JkjnY/6lf/6T
	3Geid8bhiJRrBBgTe223vqDlcUMW1DzE=
X-Gm-Gg: Acq92OHSf4l63HhBMwWnGLTIZXh5b/XdLydLR5R+LfLGFMw0KXaoZEW2iO05SUl/PM9
	78ov33ElghUj788REwz08GwTIApug2V6kWtX5mPZVPLQ7RqpbiHXSx6Lqfh4sUQHTJlfBKcr5jF
	TOdguQrqvoFTHHknyN6t8jgAwoEER2nPfGMiv5lyXDEIzZ4+RRP90NuOL8SMLYZAuEojQ28/5D0
	8GX6nEHy9lmWRVXqKx7JwCgXhf0kwB4Kf+MHvz69Kvh12cMYbkEY702lQa29icEUoDoJ/aeA/iD
	ZyXrpKE5aI2Hw6yWQR1/AwN7SNkEkkJppq80fX1dQyyehrpR0xbKoRkgR6rNgy0O/cY4mL3KbuJ
	irf5p0jUYoaEbmGNKRENm57WAC5kAmqpDyAI9xHBWHPpDXr3at9hDXzjGOCvWDeIyiYIJUiq8s9
	dSVRKyvyMvRjtQYgeF
X-Received: by 2002:a05:600c:1d12:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-490c26049a0mr234289415e9.18.1780900877418; Sun, 07 Jun 2026
 23:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
 <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 8 Jun 2026 08:41:07 +0200
X-Gm-Features: AVVi8CdSwGkE7drW8dMoDRs5NIyQb5y_X45ROHHEWLYjV4XMOXGvV8vHbLCYnWY
Message-ID: <CALoEA-yasQhXE9o-iYL5h8w0wPMrP4f-iva-YOJ2KZV9UuGe3g@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of unsigned
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jun 2026 at 14:19, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Prefer 'u32' instead of bare 'unsigned' variable to improve code
> clarity and consistency with kernel style.
>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/light/hid-sensor-als.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index d72e260b8266..ae2fda8dc500 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -241,7 +241,7 @@ static const struct iio_info als_info = {
>
>  /* Callback handler to send event after all samples are received and captured */
>  static int als_proc_event(struct hid_sensor_hub_device *hsdev,
> -                               unsigned usage_id,
> +                               u32 usage_id,
>                                 void *priv)

Code-wise fine, however looking at this function, usage_id is never
actually used,
though not sure whether removing it would break the ABI... up to you
to check it.

-- 
Kind regards

CJD
