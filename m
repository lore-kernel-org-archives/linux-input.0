Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBC2E6CB8
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900674; cv=pass; b=smat9PElgWCHtMDt1SUMe4EqNNkQ97EoIJqrYiQqWigFFLluD4N0K8YaUYcny59KX/bXw2yYgOq8zI8YdLAMCukwHJiWQ+2lUModjtq0QmvrT4mgTDHJlfTyIurkYUbaGveYxFpeTS0Z+xnO1XzC7joQ7m6cmk9Ormkt770orys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900674; c=relaxed/simple;
	bh=d+7HRtyYqdFzBtS1neiX9IXySF06zJJr+dw8DDKfF3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rfbb9WnnPiL4RlzJI7nCFMMybesAwda+LbaaUdCNaL3FiQze4e8dlmDb/1VmowcpKflkMO1KXjWtCDAely1HuiNNZnF22YIwArIvazuEe/Hhuleocu2jALWKGyOIKyi/P74yhDinFcHkJxw8w425vAtTcqFctsdln0CPWe02+sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=habRMzhe; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="habRMzhe"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so2979597f8f.2
        for <linux-input@vger.kernel.org>; Sun, 07 Jun 2026 23:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780900669; cv=none;
        d=google.com; s=arc-20240605;
        b=Z2NxcLbpGMnG6VUs818DoPb/fQzSl4d6BdIBiRVAMCbudR6NZJqkCcV6/tKhat6ObC
         ITeE4Ecqtq638qkc9kKjjVnWMUTCY/52wmF60E1pQ34yClkKMWLD9SFuJHYtptmj78Hs
         dMUAW0RqvVeQhywtkUzYQxhhJguCmB65ydK/Goia/7YAdrqeIJath0XnxscuYqhmer8A
         xcRUU0ZlJ7lXF0lnFNT5ZbSyl3VzuiSwRJbM9LTWnrdiuM3KFXcvPCTmnoh2GUtomnbx
         F4qf8TBXsZeEU1yzskNTdj8IMvtBMmoxd7R/4TZ8wfYnOhfCJlngM2+7mv4iO2MERVDt
         MZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bsD5XzkqH9HS6v4E56vm71811Zbo3EsaNP+B6BGR60=;
        fh=hXmmo5m8VNgknQ+cWF5h/QNZoH3qTaaY26gA0+fSBU0=;
        b=WYxsRkj2DNWSj9wHQymmJNLtC52kXvXcANts9gddmbFRqbM3gwABSxDQ1zLbu+Hk+/
         k6nNJeq3QED7vKDtr90RAQx/O/5bzWRGIszVKt1B92jvVXmcgrUQ9UxoWpIsa9rFhE8o
         G6UYaKsFBxVrhcoCL9TLFB0fGKkNTfrIOt4+xWmRxctJHOVPm+Lb6UB+zwGkhxUbnXqq
         Nk4af9YO3dy5dEOEA/9qkDUbvn603HFtwuHQHFSBCX9yfBWCUxfob3TSw248Yd6Lx7Bf
         2n40HiUfSguuPUAi6ea5gO9X/nd6JdMbAvXtNHQsuUANyLAy56kcr66xQIDHHq437HZ9
         xIpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780900669; x=1781505469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bsD5XzkqH9HS6v4E56vm71811Zbo3EsaNP+B6BGR60=;
        b=habRMzhedKIOMTWtRlhcn2bO6lpJ5XAhCg0USEDq8eCC1ONO+eqgbHLT77fQ6+TeJx
         t4yQPjxcr78KLICddqMTG6p+vjEkXYyaHKYx1jM2yc1s49m36ILYgCuUhG4chZW7GnAj
         iXnlIuHgiW5FCJqpj4Yq+fHxTW1Zc6sOt1wwJBSJq2LOiUUppOtlpWPjH1lKaojflNQ1
         Um2sH0nuypWgHrqr4zzLe6ZWsENsKiwn4eRipwj9GWvoWqNt5ZcoAV1qbTpHVJb4U5zw
         OGEjGxiqK0Qk0fPKEfabeM7Z5gQYYBJqcCaXCZDt9FQ1BC7VgcaOJiWg3syOEhrwLYen
         fMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900669; x=1781505469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0bsD5XzkqH9HS6v4E56vm71811Zbo3EsaNP+B6BGR60=;
        b=p0wldMDK14P0OFgSdsLvB+IUNvoL92jQ/5muT98uXKJFw5AhcIQ6XH0jnHmXGEwf4H
         fzj7eRop6GmSmuVqumO7g5PhLtE8aNOWv3qxUzkEJ2zkc3Dfi3FL3gRIBcQl58Sfo7Dc
         brCFLN1EyRO3VK+ezEIGxcgaPc08pCoezCmKfp8yeO5zi8GKZGUWTT19yJHieoR0FjDw
         fejykrEghL60DvC9eW2mOnrtTHMY4UiX4oFoUV7BcEuW7obUmDOIT+ndunPAWOHrXQ3y
         8ukOAAefbzYNRtlqYF4jiVSnUKcXxslNxDSBEDuaa3EMHPhgODucWaRTQ11bA0XP8t3W
         p2ug==
X-Forwarded-Encrypted: i=1; AFNElJ8qXjBm+9QDhj9FOyutfmfwWnA5dTEC/4AtzXbMwvmJEEttzzUMkYntTow+TOZhzvGo8t38ufkwu5JgHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdVX/o3BC10dR7MTJ9niduGRQ32Orv6t9Zt1wUquhGwtFqWHVw
	4pGOho3RJpK/TztAVw8UWj3dSiM53ItE0U+DoYXulLOMtmc8xRE1DhZehbUB7GjfUnwZGgtaclb
	byKH47jsSmbCSWYDf+Z3W07iGSGegvEU=
X-Gm-Gg: Acq92OHEVSFPVbuKYn/n1a791pY0oIms1Epm91c42n21wy41Dblygog/b94UU3ZL2yk
	6i8MF773wvIppNOxmL4CfR/lEz1HSvAvHj7JXDavHBGXugplCy9Tv9vq4nsKg5sj3WuRRpQL4Mj
	uT6UNjDZhlq3a31YcFXXTcwFIOrp/aZ+qDFrub9xNTdHkTkLv5GdGNRflriaP+68ajW3Q6+MA2b
	OFQFfHdlXw7IVs6xZ+jQ2xnoL5zqkEQfR5tgq2ju7+LqMV4wPYBCOoJTp5WvWOWXN28YuNGw7Ho
	eSs89tDXdb2XFdK/jK/C40wh2Cgq1u4IvPfGA6KbgtxT6fzn2thTledMJX6n99vd7hxKm3F4xmD
	nkGu4Dhqt/8eZm93KjaEfK3KlVEj+gG1acGoh+pwAiao1t2wmQSOtY7x/MGdGHqsGIrvpdakbNj
	nGi6aiw58mzj7MeGxKCcGuQBzuxTQ=
X-Received: by 2002:adf:f788:0:b0:460:e00:121b with SMTP id
 ffacd0b85a97d-460302e8136mr16260899f8f.15.1780900668795; Sun, 07 Jun 2026
 23:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
 <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com> <CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
In-Reply-To: <CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 8 Jun 2026 08:37:38 +0200
X-Gm-Features: AVVi8CfkKlRFRJBh56MXA_FqtKn30QLFIKFh5-Mn8VxrGfwUQDE_y-9rmO4m1uc
Message-ID: <CALoEA-yiDwjkKxUE3B=qiTdBhbvinfq-UN8h1H-HysXGm0prSg@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of unsigned
To: Maxwell Doose <m32285159@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jun 2026 at 22:54, Maxwell Doose <m32285159@gmail.com> wrote:
>
> On Sat, Jun 6, 2026 at 7:19=E2=80=AFAM Sanjay Chitroda
> <sanjayembeddedse@gmail.com> wrote:
> >
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> > Prefer 'u32' instead of bare 'unsigned' variable to improve code
> > clarity and consistency with kernel style.
> >
> > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > ---
> >  drivers/iio/light/hid-sensor-als.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> Do we *need* u32 though? Usually these types are for places where we
> require specific bit-widths for a reason (e.g., reading a hardware
> register) but I'm not sure that's the case here. I could be totally
> wrong, in that case please correct me but otherwise I unfortunately
> don't see much value in this. That's just my personal opinion though,
> Jonathan may think otherwise.

Aside from the array of usage ids that are u32 defined here:
https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/iio/light/hid-sens=
or-als.c#L46

there are additional structs used in the HID drivers that take u32 (I
had a similar
patch moving `unsigned` to `unsigned int`, but it was recommended to use th=
e
types that the structs use, hence u32).

--=20
Kind regards

CJD
