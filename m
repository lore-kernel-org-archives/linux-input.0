Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0003BF694
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711179; cv=pass; b=IREZ9FrR+HuPwe/vHu4xl4jFCMPFza/aKfz+zpidJhgg38QphpPgzwccWo27ZaEuhqd41smskPTWbFUsyLXs+V40cJ1Lwlmihf7dYOQILALUdsP7H/IY3LrBpwEcnmx/jJ0AQEFTmuoY5CPVLbvUPd9FTHJhuh0AJrHI7+/HawA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711179; c=relaxed/simple;
	bh=BLf9RFIv5pi/wJMaN0h+Ctg6fapOu6Q9G57hFPSuT04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm83Yth++Qr4MZA8zK8GBGrFr8DOrVqvP8byHikJ2bVeLDPeTeWQf8yGNt3TkF5DaVajhEZYLZouppE/d1Q9h4A2qZDtpgcQRbkmS8TzU/ciP4e/GKdYrty7fG8hP+qNHhDGWoG55G7xrtRhQV553jWXBr3slb2f3NylsWoTzm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kPihRLOv; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kPihRLOv"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81f36179dd5so5491397b3.2
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 02:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784711177; cv=none;
        d=google.com; s=arc-20260327;
        b=IlWjzRhUA9Y8Im4BJMzg2EA8D2YR2K7AWW2qr8wvB7TV3Zo6bM9TFR3luinZgAZ98f
         JXmo8CB7yKO4jmc88jKLjP/2pl1KJ8yW5/AAUMNr1eW8EuJaf2H26Zo9GI80JI3V3zqy
         Wh2MgWWhKzlYp07KzFJz55vL/v6V8Fg5tGfRe6JMkp1Hvy2G/4JuWfwAJHWZGOrdK8yn
         lFZCfZrr3RLZC7So+azoRUa/VpMQBGCkvfaqXiM+tZY+Ya0WmGGUpZuTxzCt5A9MP5+G
         vz1F0hmjh3bMrzXCH9k/s3BBatdSg6XDd9c2ow6ulucub8nzamAVbsMIuMkhC4SDNt84
         nPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fzc7jLJOwKFZM50nrRR9HIoeoA67mID89Z/e+R2bL4o=;
        fh=QSwDjg3cFvrZtYYdxGYOOL+/yePBb/sQwJZTyjH2UwU=;
        b=YFdtgvCSY1yTC8UzcqVeY1qr1DGwNZEBQORK5TK03Mtkb60WcmQMXIANGtl86DOk9C
         +uetQoxwhqYSYXcgHGgGQbgy9K2ab4fspLLjy/TJ7bIYHdUommIc+vlVwXX6N+R+3kcI
         qgJUX3aJg/ZkQFYmL4n8QYhd+CNCsHhneEQNxL5DhWXWP3NwjcWn1xXxy2YX2Rp7tAnK
         KAGFwrPfiWAVA4FABEzmsZUlEXWFZw4DLiGfqnG6+kKLsW4NQouiSBuCLThKaVTn63df
         4lMY3u+RzElI1Rpa9pGryvl15d7Wwm6HxZxozezv5d6BWkRS3tljAEAdogeuMUW6t4EU
         9e3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784711177; x=1785315977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fzc7jLJOwKFZM50nrRR9HIoeoA67mID89Z/e+R2bL4o=;
        b=kPihRLOvc9nNrQgH4XazHoHuE2iqpX+vJGu6Pr49lRHuhJTmoKBaQNvid7LlV31955
         7E2pZRieWFEzZJnqzodaIWODl52P0OlTgYewDVWUwy6XQMRUgLkMOjnp4+BbI7qpOReh
         /xtwXA94fcpHMRRkyOvCJTOWRaayyhcLhclSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711177; x=1785315977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fzc7jLJOwKFZM50nrRR9HIoeoA67mID89Z/e+R2bL4o=;
        b=gzDRb8Ccxlm6w9fq5sT7pu+Cjh5hFcdbVwr53aZdASfOMPXDFMBGw6Ds9qbyOy5LQE
         m4VCISP6kZfRX3SbntteAeh5CJvObAGLas8L2YdQgTZghnOca9SnFqUD4CPay/lYqYsH
         msoSeno3ko4Dap8jqc7a4t1bUNCzZpK7sppPv1ToA+Dl6ftTsviHthA5eBAwJHuwDHPw
         eG1idmT0S5JazmI37QGPey2YxjZUA5XsdTj//MSvJarBIjCQ6x4PHgBXdca2F+lQ7eeG
         00M7lm9zXpxfy6se48h6KhviIPDBfIV6SMmSE4Whz+QT9QiNVIviW9B3p31nJjoJOQiA
         Ju3g==
X-Forwarded-Encrypted: i=1; AHgh+RrMf/SUZInHS4tJNc8x7ozkJd8B6eQyOFK0v8dLGakk2Ru2u8dEvX7edzTLP/gIbx3xewxadLB25MHEYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0k0dOWQS1aeLvjIC7yWTPXVTA9OwgvqYD0mvohzpEK5J37iya
	cee6wYqERIXkK0kYtAry+IwvmGobj60xtDO3jrZgTAxEHFeeR3p/WpzkT3cRmfNtYlfSVY4lzZ5
	oQh1PgSgXHVtbWqoPRmes2vddloQyCLftIMxUn1PS
X-Gm-Gg: AR+sD12gQiwEyoGcWok2FgKggIh5QA7EhucZiruQc5Y/bmbB6MVn6KnvITxgHzFk4Tb
	q4C1dtbKSoFPdT/5xZFl4vo59DjygWixcEo13OlbKFWC9JHsEjT7bVBlrkYdhpojO6BI3REBkwd
	QV158LvjZKXPaTZiYXyxn+KzvoI8f/TKmfl0UikngMjmOCD9c9jepLr6Fdqhcfa8Cmx+qsozVz+
	qA42nVf4JYnR2sypbye0q85aPCcIXmi/w1LKHQDIkvZtLQJbn8UwA9chcIPefVFjgglS4XP/LIc
	hItg4KGpaZSeAMme
X-Received: by 2002:a05:690c:6c8d:b0:81e:6d03:40cf with SMTP id
 00721157ae682-81ef26ae40bmr73897997b3.54.1784711177267; Wed, 22 Jul 2026
 02:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721075226.2347933-1-wenst@chromium.org> <20260721075226.2347933-2-wenst@chromium.org>
 <al9BwHbG5IX0mIem@ashevche-desk.local>
In-Reply-To: <al9BwHbG5IX0mIem@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 17:06:06 +0800
X-Gm-Features: AUfX_mw54F9BihKerjVbrM-HX0v6EAfSTuk3G7vvEfoFi_SJki_3pQoN0j1OPTM
Message-ID: <CAGXv+5HXtSovddkws58oUfUcucC3GKqTt-GgvXs27ALFjyFRrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] regulator: core: Add "enable and wait" functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 03:52:15PM +0800, Chen-Yu Tsai wrote:
> > In device power sequencing and initialization use cases, it is common
> > for the driver to enable the regulator and then wait for a certain
> > period of time to pass before continuing.
> >
> > In cases where the regulator supply is always on, or has been turned on
> > or left on by another consumer, the driver could shorten the delay or
> > skip it altogether, provided that enough time has already passed since
> > the regulator was _actually_ turned on.
> >
> > Tracking this requires support from the regulator core. Introduce a
> > "last turned on" timestamp field to the regulator device, and "enable
> > and wait" functions to the single and bulk regulator consumer APIs.
> > The existing "enable without wait" functions are then converted to
> > macros that expand to the new functions.
> >
> > One case in particular is not optimized yet: a regulator left on either
> > by hardware reset default or by the bootloader, but does not have the
> > "regulator-boot-on" property set. As the enable timestamp only gets
> > updated when enabled by a consumer or by the core, the first enablement
> > always needs to wait.
>
> ...
>
> > -/* locks held by regulator_enable() */
> > -static int _regulator_enable(struct regulator *regulator)
> > +/* locks held by regulator_enable_and_wait() */
> > +static int _regulator_enable_and_wait(struct regulator *regulator, uns=
igned int wait_us)
>
> Hmm...
> This comment a bit confusing, perhaps adding some lockdep annotations hel=
p?
>
> ...

It's already there, just outside the diff context, the first line after
the variable declarations:

        lockdep_assert_held_once(&rdev->mutex.base);

> > +     if (wait_us) {
> > +             ktime_t end =3D ktime_add_us(rdev->last_on, wait_us);
> > +             s64 remaining =3D ktime_us_delta(end, ktime_get_boottime(=
));
> > +
> > +             if (remaining > 0)
> > +                     fsleep(remaining);
>
> This style is discouraged as it makes maintenance harder. Better
>
>                 s64 remaining;
>
>                 remaining =3D ktime_us_delta(end, ktime_get_boottime());
>                 if (remaining > 0)
>                         fsleep(remaining);

Ack. FYI this will be rewritten based on concerns from Sashiko. The
wait will be pushed over to regulator_enable(), i.e. outside the scope
of the lock.

> > +     }
>
> ...
>
> >       /* private: Internal use */
> >       int ret;
> > +     unsigned int wait_us;
>
> If you want to make it more private (the above is only for kernel-doc) ad=
d
> __private annotation that will affect how sparse will check this.

Nice. Will add that.

> ...
>
> > -int __must_check regulator_enable(struct regulator *regulator);
> > +int __must_check regulator_enable_and_wait(struct regulator *regulator=
, unsigned int ms);
>
> ms or us? Please, double check all units.

Yeah this should be us.


Thanks
ChenYu
