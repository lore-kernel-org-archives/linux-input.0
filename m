Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174C342CB1
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705483; cv=none; b=Recmxq3UM+W4HwBih55nawWGqtOBtlTf5sgTTzak3QKCKGRYYnmGGXSNQDOQu/Nxwydct47zKnG94IAh5PRIrmGs+sNNRnZYG7cYNikEFWYWaLBKZ2a2KMCq8o4ySGYK2sHvqUxzEzqKZQJXFbarix603lTcX3z0rNN3M08SaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705483; c=relaxed/simple;
	bh=yXNzbe5mk3xlwa4MkQahqod8cIV/AMEhF/kr05ffRPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHVhMkUmVu26mQvJtLoW3WbOc+1yoMc6+t8dk2cmklwo5Hk12B+EhEr9tLVcXjoIuAwNa8TyreaVS8ZxxdfLkGcdBoj7TbSWZ/gvmuR2g31QqcYlgMCj7Cup8PfLowYLjunM6R6LTlkh+0J97O2B3rmh7ywl4vJ7tfl3vWSz5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CpfMCmDI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpfMCmDI"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-658b511573cso2147005a12.0
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769705474; x=1770310274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXNzbe5mk3xlwa4MkQahqod8cIV/AMEhF/kr05ffRPY=;
        b=CpfMCmDItnt68Y/QCrRAyiknZiHQKZIc6fJ0WZYj87wRp+l2KbvJtB7Od2Q2SW4Gw4
         ITbQCxX+knGsPhQNd24fdR7WXu/0F6OctrPoaqwbTmn5bskUtllbUDrIf6zXrJSS0y90
         OlY1QvzEQdTjH2FMGIhMn0vUCb57Lto/e+KAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705474; x=1770310274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXNzbe5mk3xlwa4MkQahqod8cIV/AMEhF/kr05ffRPY=;
        b=IkZK22Dke147rqQeOpdaOuMDDmS0H4R+5zOmOl7/rwaQyC4KIuKpEiXsjdPGicyawR
         Psl5YwTAlQ6n710a8/6ApFb13+3y76aHYYJOpx03QkKkvJHf4CdWp3khmAlFQ6T8cjmW
         qIN/pZU4bwd0UUIooXUPMcJLh9lJ+qbJOq3ZKbfkZiMoyP7xYW46jM7lmhorb4aFJY7r
         3GW46S7ae7RDXlPATT9pNNchJInUcDP3Fgxxi8cIvsnnwcubtywnxQsC+H2wbQgFAeWP
         OmtRmH4aMmzBrTsnCEg+ZAKIrR47h3W0JkGADOvNH25//InQbKI+1mrNu7wU4EqoDNsF
         YUAw==
X-Forwarded-Encrypted: i=1; AJvYcCXnE1xT/4f/eLZ3zB+XHu6X7mR+idgWJdeI1MmI+TA2sHcOh4ZfM+YxUD9gSBdrE1sEb134UA5XaCrfqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHt0sMXSE/QlxaEnqYfVhK7/H2evFo5st3s6CDMrB9E/FLIZz
	j6KjNKhngSJ7jgUUqCcz7g4rDRRXYcKPEmp1h/27xSY1+FFCukjYNPzJWUnjugCo0lo2EtouPIn
	N/3z0XQ==
X-Gm-Gg: AZuq6aImpoYncNHq4waavZAeISE9S5DXvtUEeUE+Oi7T2xvWRmjadbIIGEKbGGCdxP9
	GcILTbqVimoQYNWH0HOnT+Iwv1UiGBT3BfLsXql8ZLCKa1N4Zr6Dqgb/HTR6NREYrtmA8lK7DyT
	O4wekoVs61QHrO3OuaaReXx4dMHqBEQmkLEYzMjT0rmy+bJVydd+mst1HuT9CaqnNoI0JV7911d
	7gh3T6Xra+7cphs2HrHXbNaw8q13xvGTKnYQCPhaKmzTpRrDOcO2Wguf8wBhgRwC5K2pPNV+9JN
	LiDggQupK6xl32BE3+dtZjTA1B6o2rl7acmBqPxNyM+d9miKVxAIV7E/7Kjv5sDHoQIPBx2DELP
	ctctq+FKiumJjv8vQeyf96ssNyS/Yw34BszhgRPNnwXS6NpR3BJI9FicQ2gGxLQ2D8BlBWrtUlw
	f4BIheOPbE1mV3erTc3/WZBlr4xqOa7q/PrAQbnURpt5IT+CQs8HthlERjn1I6
X-Received: by 2002:a17:907:c22:b0:b87:6d6b:1366 with SMTP id a640c23a62f3a-b8dab33093dmr670757466b.41.1769705474350;
        Thu, 29 Jan 2026 08:51:14 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c500bsm273799366b.54.2026.01.29.08.51.09
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:51:09 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fb2314f52so760040f8f.0
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 08:51:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVriuFb102f5BQlbRDfjX9dDuwJdphQyH/VuburFJntStQDT7lDYo+rAr8M2K8VoJxxqQV8Tx/cnG6Ing==@vger.kernel.org
X-Received: by 2002:a05:6000:2405:b0:435:9522:2bc9 with SMTP id
 ffacd0b85a97d-435f3a6ccb7mr399351f8f.5.1769705468701; Thu, 29 Jan 2026
 08:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108063524.742464-1-yelangyan@huaqin.corp-partner.google.com>
 <20260108063524.742464-3-yelangyan@huaqin.corp-partner.google.com> <ffqvva5kgyh25mpquackob7fnlaxseu5stgevneqynwa7m77b3@totpb762p6te>
In-Reply-To: <ffqvva5kgyh25mpquackob7fnlaxseu5stgevneqynwa7m77b3@totpb762p6te>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Jan 2026 08:50:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XKqFTNYopxV9H8rnjEYAgDebW42Ot92aZYiex5MP1wnQ@mail.gmail.com>
X-Gm-Features: AZwV_Qi0Z8168L4gaPZktw99T6_nZRbAiWWywdG0fr-ESdZGsorlaIsuTWXlIik
Message-ID: <CAD=FV=XKqFTNYopxV9H8rnjEYAgDebW42Ot92aZYiex5MP1wnQ@mail.gmail.com>
Subject: Re: [PATCH V3 RESEND 2/2] HID: i2c-hid: elan: Add parade-tc3408 timing
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 21, 2026 at 2:40=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Jan 08, 2026 at 02:35:24PM +0800, Langyan Ye wrote:
> > Parade-tc3408 requires reset to pull down time greater than 10ms,
> > so the configuration post_power_delay_ms is 10, and the chipset
> > initial time is required to be greater than 300ms,
> > so the post_gpio_reset_on_delay_ms is set to 300.
> >
> > Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Jiri, Benjamin, another I2C hid with bindings...

I guess maybe this could go through the input tree, but it needs
either Jiri's or Benjamin's ack? Is that the plan?

-Doug
