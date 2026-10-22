Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792634342;
	b=BFuaIrawNhpV3te/eV15ffumuPk7/+sETV6Zi+Nu/MmfQ1kkYfqQpdwylv3s+MvQRGj2
	 /RoIJIPkSa98pWyB+SJ7DcsnyWB5EaKbMOpUhE33oCUU/aUT/lVjKMAdsFRBsOtsmG2JN
	 UU8RtHtxMLkEi2a3Hc6ylhoJjWAjlWL90+myXDmOTrlxGJ1bssqlLQAP8euxibw80/DeT
	 MxuuNj8Le3jtmD60d7ufYq3ZCdklf9fe+WVcdanWEBhjiI2eH63Qpxf6DOBEt67+zglBW
	 w757H/5fo2KXdBF0DHpcTK7bx8RWlBH05bpToTy3oNEI5jrgJ4Qq7qr8o8A0B079eTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
	b=BxHuQwHWEkc+KRndBqytu4s+Ap0oKWciJ7lAWXUHd1/UVHgvVBilrAxKQhtrA7GzlcTU
	 YJylukHvsTeQqS6tHK3RJ5jN4k+wOyIVKTLxzkcBw5DZJQobx9VdxMsh45+qbOWv1CKG/
	 D16SjGi7W492zSABiY6nYzRuNRjJFlteBTCaxX9ascrR9pW0GMIgfYBCpipkk+K4lqoTe
	 zCy05dIy12DjuOQThsMRgFtpapjMcWHm9EvpYB0vP9v0xw8cXKCUJ46FTVtxQES72MHIg
	 T6r26wTmhouyc/kP29mVirmUZrOA4qhtLZk9PpKlgo6MPZ+qC+KeEU3Qmia1AljGgLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=murgatroid.com;
	spf=pass smtp.mailfrom=murgatroid.com;
	dkim=pass header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=Dn22YTWF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18048606A31D
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 01:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18048606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=Dn22YTWF
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535a54bed9so1914054eec.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 18:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792634341; cv=none;
        d=google.com; s=arc-20260327;
        b=HiWlwBlLJsviQZUSk/0+PnRpm3ZDPj3ww30L9C+qasCzdoNXCYKMuL8UA2A6Q1/DDy
         vTroBScosowWiY1zCoUtRes4ePEuzL8JElu982SzfGQBPoixhV0mvVCIbMGfdmA+Ge9x
         9Qde7fpcuDR+mppBe6RgtxD3IT2WLZc0nt5fosAe9qTm/3GItKsS7bqK5/O4kC0SAiQP
         bnq4Ue154NvUgrHP1+e1SqkcBO0bzzKoeInJUnwdq6HcSQz2wa3ZdCRhcnlfr86UhQVo
         CIFq8Jh5ARDpxTYDZyJCbY8aPk8J6BHrUMVq8BHh/DkvndomkeTB4rXALJdcb54eQIED
         9PUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        fh=jLSqD3seewefuZ5IeOHhsOSZ5zkM5ZoW+WarVr9CNyI=;
        b=K2tJmRbezD7BxwSxqkv7iwXzNXtlUf/D953DvZMQQLzwpQFrHMWbQvAt/Ml2NwOUax
         gh8NiE9kmVUAYZLd9LKXy48TwH9w5182GqNY7ZnsOEC6uyOvJhCsqQ5miZ+MQ7maSA6i
         QApZBchNwCXnXAIs8s+ZRpYOIDn8d+wVVSW2rXNpwEV1dxglMdOBZp2P7yHevLyEEDBM
         Dg5QnpAipjrnNaz8eKXZ19iMjsH1pVzEkmhFDMNMDqJF+q2OCeZFnPUe51NdyhNcGoXi
         QMyBpQSKuM8KAV915LbuA9X+fAZzS11+V8WRmiuFxji9RwOt7Z3Ks/3tPgxMmeLbXrnA
         rlNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=murgatroid.com; s=google; t=1792634341; x=1793239141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        b=Dn22YTWFHXuz5eBGAfgcXhBaSngAcdqW6Ktq+DQbZGylcggyWaChglRW/PsuJhLKQg
         ttkF4JCIZP0NHjN2sKShcr4i3TjPFg+AUESLvr8tjPomsIvOO3VHDGgnFbu7HXRmkwJz
         kImqDIsxFiYu0K537EdLnpNStdF056NaZPRo14LbHN/aqM0mWS4rIhbcixaBq8jovoA8
         W6w1+JotaqCa3STOt6xyC2CdQVdq2ylm+m5PNfmvuVoXH0WeS7zIEsdTk6dsJR64Fv2s
         xW33Ws90oMWQ2mjlNcvVNYalCROvgRUMnn1KIjCqem8758v8B/qRmxfeeJxCtX06kTx/
         cZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634341; x=1793239141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        b=QsF9wIujlt9Sq4O7NzFwqFeZVXyW8XLSOvOXwBJI2D84cpxZbIer+HqbrF3M/EtZQI
         8c5bwncoH1wzsrx0mK/hK8HqLM6S6zAKMZiHUpbWbQEWiVIA+8UfRaElKquJ/0uGRsCl
         y14s1CS5oPDHtjBtsnS06ppBtcGSroET6HuaczvLYQBCvH7cApSvfjyaTXKg9xB3CVLC
         ryn6tkGZT7sSXaba9dqwfP0i+3QgEFLDXcwdFyyTalcvqT4j4CXcnvhcFABBINdQeY3r
         53EogKKfHb8EILcxV+LLNuK33KEA8tEXzJwkVoU91dqQr2ZjYWjLTY/03MzqTMqwPB/M
         +ovA==
X-Forwarded-Encrypted: i=1; AKwUvBzpwRKk/CMUUxrCtx6uyBz2CE5D7nfVSpkAh9qojXVotdCMUtxAYjUpgIMo3xjNLs46OY2ZYxIzD8ttxA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLIZBE5MrQxm06Z+VjhHP82ohvgBIQLLxhFaOHZN5rrUGDyuaZ6
	wegC4YHLwdo/tPZ0M1ycuKdBvwCNr0dqjt/pUZF2VlUv74DzHHrHHeJzZJ/W3m8ZtE9zWXIIaG4
	5ke63xNJMfVgqVx7ICFVcUpBsfhnc4xpxk43zyVlM
X-Gm-Gg: AYBFou1NDijI4yp26wCgSOzzWqFacBC8IFQHedesRjL7MEtg1l4fsUQDEgHJeIEQrzc
	LJCTw4Mbxo1AAle5D3tHjNa2XHRssPp1hTa7Ku2QsRMWtDqB+lbWIOr1+hv+EZPrqQy3s6tYSwc
	ORFn+zPSXJ++pysZsJiTvtdMcZAWkr1aArHSIcpmMqFa1wcIkLTXMIbIkTVezCzISedNCopQIZ+
	kKTcfI8eh7kbphdIp0rqDlO1tfyjaGvpa+rGOpLoD/0ib4Nn6KZwQK2TKC7Xwk3/SwoDmsyg2Qw
	J/Sem4S28uUXbJXQH2M8Lz4kjBhwLQExMjgYfKeZ6bJBUQ07GBDXpNQq4XP+lqajyPApZIdJLat
	pLh4ngxbu6qU0AHyCvbwsPBwn6Gzz3X4xvQgjV5WZ4VCPjOp3aK6oTqR7pMQNDr/ltkJTjInltm
	go9DeULn4E78v2ucVXXEm+ts8F0OF4nFJkplA=
X-Received: by 2002:a05:7300:e70c:b0:351:1bdb:e3b7 with SMTP id
 5a478bee46e88-3674cb37bb2mr5335214eec.15.1792634341036; Wed, 21 Oct 2026
 18:59:01 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019023420.83976-1-ch@murgatroid.com> <20261019023420.83976-2-ch@murgatroid.com>
 <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
In-Reply-To: <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
From: Christopher Hoover <ch@murgatroid.com>
Date: Wed, 21 Oct 2026 18:58:49 -0700
X-Gm-Features: AclHuK-UlpT4QZJ3hk8thqk-ORABl_Te8RQcU0z-w1fijnZP-8kQdVwWN9ZtSy0
Message-ID: <CACw0PsaJr6E0Y3AXoGKDUiKp4vsaA+GEJjPqEhYuSoKqDp1jUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback removal
 with raw events
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Lixu Zhang <lixu.zhang@intel.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  Is this issue actually reproduced or it was found by some AI tools?

Real life.   I wedged my kernel several times with an MCP2221A usb i2c brid=
ge.


On Wed, Oct 21, 2026 at 6:22=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sun, 2026-10-18 at 19:34 -0700, Christopher Hoover wrote:
> > sensor_hub_raw_event() holds pdata->lock while it looks a callback up
> > in dyn_callback_list and calls its capture_sample() and send_event().
> > sensor_hub_remove_callback() takes only dyn_callback_lock, so it can
> > unlink a callback and return while another CPU is between the lookup
> > and the call.  The sensor drivers remove their callback in .remove()
>
> Two spaces before "The".
>
> > and keep the struct hid_sensor_hub_callbacks in memory that devres
> > frees right after, so a report racing an unbind can call through
> > freed function pointers.
> >
> > Take pdata->lock in sensor_hub_remove_callback() too, outside
> > dyn_callback_lock as in sensor_hub_raw_event(), so the removal waits
> > for a report in flight.  pdata->lock is otherwise only taken in
> > sensor_hub_raw_event(), and callbacks are removed from process
> > context.
> >
> > Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christopher Hoover <ch@murgatroid.com>
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/hid/hid-sensor-hub.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 6470a290ebfc..7cf9f398592e 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -173,7 +173,14 @@ int sensor_hub_remove_callback(struct
> > hid_sensor_hub_device *hsdev,
> >       struct sensor_hub_data *pdata =3D hid_get_drvdata(hsdev-
> > >hdev);
> >       unsigned long flags;
> >
> > -     spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
> > +     /*
> > +      * sensor_hub_raw_event() holds pdata->lock while it looks
> > up a
> > +      * callback and calls it.  Taking it here too means no
> > report is
> > +      * still using the callback once it is unlinked, so its
> > owner may
> > +      * free it as soon as this returns.
> > +      */
> > +     spin_lock_irqsave(&pdata->lock, flags);
> > +     spin_lock(&pdata->dyn_callback_lock);
> >       list_for_each_entry(callback, &pdata->dyn_callback_list,
> > list)
> >               if (callback->usage_id =3D=3D usage_id &&
> >                                               callback->hsdev =3D=3D
> > hsdev) {
> > @@ -181,7 +188,8 @@ int sensor_hub_remove_callback(struct
> > hid_sensor_hub_device *hsdev,
> >                       kfree(callback);
> >                       break;
> >               }
> > -     spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
> > +     spin_unlock(&pdata->dyn_callback_lock);
> > +     spin_unlock_irqrestore(&pdata->lock, flags);
> >
>
> The patch looks fine. Is this issue actually reproduced or it was found
> by some AI tools?
>
> Thanks,
> Srinivas
>
> >       return 0;
> >  }
