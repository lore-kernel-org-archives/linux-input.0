Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795445623;
	b=kfC6kpQ6lW5xEgOLD418nL7yhY4FKMmM7VGTaXZ/7ciw+8da4Dz+b72KivhS/KioQlD4
	 x2dpQi3qHEi4dISKtMGnIuan8TJi62n/GT5gGpY2UzboHNN7iZd+WQuqw0iyUqf8XKs1p
	 M+UvaFLCm9ZpC0fKxKkvkhdKsLBgRxUd0nDXo6SlXxVbaa04Dm+krnenyhXgcW+3yGdwU
	 1OigET/xGYKrZtSmq9tS4QwWcQf+5XqUKxkg/b6LdZMVvhJWI2JIMcfhFt+46Sc8SiQAb
	 5uClE46BJcwpnQy5fy+ZO8wey5gG8/MZY+3BG7XM/b08ZNQbH790yeKykhqQC4tg46w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KiznapJ9s3bPtI2/myOJZGBSxLKcyfy/8YV0Q+JSslA=;
	b=0ArnZqv5yxzslwGGx7Jsqhlhvy37DYjp0djmcebcAKrqqfg8M6fvpQtPaaHsTuZjxSse
	 CNbC8EU5IkWVOo72Bd6aWyt2rJb+MyzWkFPn9WjdshYNxXtyKSsIfGlVQqIpr9qIA/Nlo
	 obsV/gKwYC+PA+xJCc4GouPc8A9ZglJ0v3DxHQOXxoB+3ZKU5jOf8RxGVaXolv8uvQVya
	 Y5sRPI6/oYP9rxbzn9a47GGLjmKXlbvVLoGnnxNn1XI9mJcP7tH/LKU+qbUq/0gziYlDh
	 B5njeD8IRwBfS1RmFlAgF9e8mKGtvuxfb35yWARcHhCipYLLDpfwCe4GV++EAEGXOLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PiMZSRJb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964B60A260B
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 14:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5964B60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PiMZSRJb
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a2761c69fbso2177693c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:53:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795445622; cv=none;
        d=google.com; s=arc-20260327;
        b=YA0KjrLyJ4gDRQOws5IYFjB0Dqv2+Bw8B97t743ld+/9n7Z0VdWNZa/qHzLErNIEJE
         bo88YNxuyvcn+5//RU9vSW5lNK3i4btj48UYG5KYXjHhUbiIjizC33gLRBzdq2R6j4ZI
         nJUnmIlxEs2oZVkEVZqjfJXrZB1+5WM4c8xvKMw/zHCaZCtL6v2H9jyzUp1r6eXjuw5O
         OTwnjKFNWy+wUNSP8XdbzXfSQIrkqogeWAvGfVwEMRiPSUuzlac7JPef7QhOJBBXLwiI
         LbYEYgrKfQVvWIyDzL9WA3eEanoJPiJ4JzC4CiliQ2YN3izHUAGpkYcCQNwqbXSy0xxb
         tb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KiznapJ9s3bPtI2/myOJZGBSxLKcyfy/8YV0Q+JSslA=;
        fh=nc5zgZ/tfOX1G6+PmqoRw0KZruSo4ojF98hiWk0jb2U=;
        b=HwSHN1m/JJJu419Ll7M6rdPAlll6pPhH0a2qTlQETkWG0SAphKocXxSe9kc/PwBWJt
         igwdDQZjVZutj+S52A33NBaUELJYECjQiAdDHNz6zITcx9mO2clwdUwuay4/FCL805bX
         PVkCbCKBSfhmaChEgT5+qFSQStG5Lb7iCekd2+M9BQBYoSafpXI1iSyYxp6P021G+9Qj
         AWQSsx4Ps48O/NBAsAGbWAnnudR32DpFTcO+P6nypgbB+OlKUmOgUaOC9wKMA/li5zmM
         GWGLwa3f4bn5P3JAcRY/TdBMYpfO2Lw7BBzOqisDswcQzxJBQBXcLDxG47pMUjqAsfHr
         Fj6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445622; x=1796050422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KiznapJ9s3bPtI2/myOJZGBSxLKcyfy/8YV0Q+JSslA=;
        b=PiMZSRJb2hdBJuWT4yy1Me5kar1Bb5BK9zXWfbSJNUiKI2c52eYNVL79YciceBNL+M
         8Uy8NcuE003k0Ra4dJbY/I2OQ2kOmAdUNusOEQIuD18kosJLs8Nd2jAkDHjeutoGAc8j
         Vxkh18cQc5ZmUSSXDzSFr5BabGnAkKFgo237umXEUjEc6W7JOesNQVtjLuL31kG8ZYD9
         AMSJuAwByl7OcWJgcYIN46052MA7BQr+/f68mNeEFOL62LhmDQWs9/Udw+C3eJzxUZ+W
         7uy+z1OcbFDEglGQ33vXk3oj8rZJ3ymlqJYv42FAbaKR5Rt9q4WOkaa6ZkLX9Z0RYi0K
         EiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445622; x=1796050422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KiznapJ9s3bPtI2/myOJZGBSxLKcyfy/8YV0Q+JSslA=;
        b=fuHnSzg6/4rNzcrPldElfYpomuPVpffunXKK+gwvlU8w6qvEpCemTHHwZWS6XxTj37
         ACvPmwT5KnoVsowNaNDIRPy85ImCqj6/NLzOCMlk+cfegEM3HwQArNMbruphhWmyg0Pp
         tCS4sAZO1ltYN5Vhr2WNWWMjKFrEiC/53Mi3gDHo0tEj4l5SbQNxNwrLi0lDASHTLs2R
         1nRCZB0FjHHbgMgRH1XBlt/w3b6448pvqm6Im1bJy/0tCcjBXispnHfEiTtmdc6unCOz
         B6mqgHrJboj/xMx5AfegAdrIUNc5Kp7FMEDqpkF3Qp5afqnwDYZS2uSgnDyKQSAEh59K
         iKdw==
X-Forwarded-Encrypted: i=1; AL+hErGtE3DSc6psFSvisDdLSdF6aOGaup1Awx2ea8LV+aH4nkeHoflut8DJOTMyRqQU/qrzYgJmPsoWTWXILg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/57zMwkV+Xsks5HXv3sPc3q/XXrCLXuh+Gto/Rl6ewX4UCnJOU
	kxd46wNx7PGqusrY1AXjLH+joi3Z9j9/Sa212FzJzqgnuKlxbkkj37wJgY/VEaRp61mHYr3PkTw
	vIvqCO5YONamzUjTPI7zAAV91m3Ixgy0=
X-Gm-Gg: AZFdTZeAhI00w2uVJDXHceQSRLLOcNCU2OWXqmAO8v4GIGJl8CeQk3TY79Y7v94pnci
	F6xcSh5e9P8ugdOxqkYqWDR3J/ld6G49kFQKX6OOarUF0Dk+wF6/axEtx8lkNJ7iv7BbJD8HYa6
	Spg/78FB49vVx2u4SYajsf7L0VRmtTLSXKvk0JkIHurfH5Hl0V56q2zdQ1DWqyNMDHU8asp3LW1
	w/3BnvdY02dbEOBJkrSNxyu620M2DGU+f53MpIp6HPkv/6UpvBmL14JvroYedDumu8Ba1gCSEb+
	QVVw12p/U+C6e5PnbCMa6dEKKp2Mx4y9bslm4fE4HKDFDQDci5K4G1JUgHRFq2dxShuM0BNWLI7
	0LM+NyOkT6vbWks4VmAfkWZo5TGycvC0D2BU=
X-Received: by 2002:a05:7022:ea56:20b0:1b2:4e2c:6838 with SMTP id
 a92af1059eb24-1b5568cf7a0mr13384775c88.15.1795445622228; Mon, 23 Nov 2026
 06:53:42 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123124715.351511-1-ayaanmirzabaig85@gmail.com> <3d83eafc370354cef4280fd70d1228191486a212.camel@linux.intel.com>
In-Reply-To: <3d83eafc370354cef4280fd70d1228191486a212.camel@linux.intel.com>
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Date: Mon, 23 Nov 2026 20:23:30 +0530
X-Gm-Features: Aa3M54p4k_LbVFdwSVxSxoz8NO28fV58yQh4DUC_tyGXKDsdGjchmGgw3AVrmX8
Message-ID: <CAJi8Lv_M2uuiiJXPMqo2pptYT9gK_5uYBh2tWMp7CP=iUsgouA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Zhang Lixu <lixu.zhang@intel.com>, 
	Zheng Shuhao <viennaoffh@gmail.com>, Arnav Kapoor <kapoorarnav43@gmail.com>, 
	Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Srinivas,

My apologies. I missed changing NULL to data in sensor_hub_remove() again.
I've fixed it, verified the diff, and am sending v4 now.

Thanks,
Ayaan

On Mon, Nov 23, 2026 at 7:51=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2026-11-23 at 18:17 +0530, Ayaan Mirza Baig wrote:
> > In sensor_hub_remove(), spin_lock_irqsave(&data->lock, flags) is held
> > while calling device_for_each_child(), which iterates child devices
> > via
> > klist_next() and acquires the driver core's &k->k_lock.
> >
> > Because &data->lock is acquired in softirq context by
> > sensor_hub_raw_event() while &k->k_lock is acquired elsewhere with
> > softirqs enabled, nesting &k->k_lock under &data->lock triggers a
> > SOFTIRQ-safe -> SOFTIRQ-unsafe lockdep warning and risks an ABBA
> > deadlock between process context and softirq context.
> >
> > Move spin_lock_irqsave()/spin_unlock_irqrestore() into
> > sensor_hub_finalize_pending_fn() and pass data through
> > device_for_each_child(), so &data->lock is only held while inspecting
> > and completing each child's pending state after klist_next() releases
> > &k->k_lock.
> >
> > Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-
> > data on remove")
> > Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
> > Closes:
> > https://lore.kernel.org/all/6afddf21.a11fe2ad.1b4426.0003.GAE@google.co=
m/T/
> > Suggested-by: Zheng Shuhao <viennaoffh@gmail.com>
> > Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> > ---
> > Changes in v3:
> >  - Actually pass 'data' instead of NULL to device_for_each_child()
> >    (missed in the v2 submission).
>
> Are you sending correct patch?
>
>
> -       spin_lock_irqsave(&data->lock, flags);
>         device_for_each_child(&hdev->dev, NULL,
>                               sensor_hub_finalize_pending_fn);
> -       spin_unlock_irqrestore(&data->lock, flags);
>
>
>
> Thanks,
> Srinivas
>
> >  - Drop the NULL platform_data guard since hid/for-next already
> > checks
> >    dev_is_platform() and !hsdev.
> >
> > Changes in v2:
> >  - Attempted to pass 'data' instead of NULL to
> > device_for_each_child().
> >
> >  drivers/hid/hid-sensor-hub.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index e9d6eb3b3831..090e5a232efa 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -808,6 +808,8 @@ static int sensor_hub_probe(struct hid_device
> > *hdev,
> >  static int sensor_hub_finalize_pending_fn(struct device *dev, void
> > *data)
> >  {
> >       struct hid_sensor_hub_device *hsdev;
> > +     struct sensor_hub_data *sd =3D data;
> > +     unsigned long flags;
> >
> >       if (!dev_is_platform(dev))
> >               return 0;
> > @@ -816,8 +818,10 @@ static int sensor_hub_finalize_pending_fn(struct
> > device *dev, void *data)
> >       if (!hsdev)
> >               return 0;
> >
> > +     spin_lock_irqsave(&sd->lock, flags);
> >       if (hsdev->pending.status)
> >               complete(&hsdev->pending.ready);
> > +     spin_unlock_irqrestore(&sd->lock, flags);
> >
> >       return 0;
> >  }
> > @@ -825,14 +829,11 @@ static int
> > sensor_hub_finalize_pending_fn(struct device *dev, void *data)
> >  static void sensor_hub_remove(struct hid_device *hdev)
> >  {
> >       struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
> > -     unsigned long flags;
> >
> >       hid_dbg(hdev, " hardware removed\n");
> >
> > -     spin_lock_irqsave(&data->lock, flags);
> >       device_for_each_child(&hdev->dev, NULL,
> >                             sensor_hub_finalize_pending_fn);
> > -     spin_unlock_irqrestore(&data->lock, flags);
> >
> >       mfd_remove_devices(&hdev->dev);
> >       /* Clients share one HID open; release it if references
> > remain. */
