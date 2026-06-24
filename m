Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4132517AF
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340904; cv=pass; b=KRTa3F9bT5Jy4xxPYDId0jivVD3d0ktQBKsvHnSieZEHpw94JYW783YxyRtklY/HviSvbcdPsVSCXCe3qCjOiGHUnBce3BqHjwcxcZdReOdqR4Zacvhki3NO6Jw0+Nfcbww2MJxpMT3kEcDYMuyUhw3Vl4LamRqpAXdNcSY16bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340904; c=relaxed/simple;
	bh=lGJ2gfHSnw57MpbofjpuTPtD42d8yiISwF4In2IuKDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6NeDf8BMQRvmIfKKDpaYWncSrVBmmJiUruExFxZiI86MXrIdEotY8XuImw6j3Pw/2gjyEd+BY33LbavV8jsxGbQDUwVYN3GedWhJ6SEiMqtgyMix0VQ3FA5InrPqh1JMYABNVVzQ97x3H4HDhRv9IoYEc3Cq+WoJJRuJn23zl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dW2p/xDn; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dW2p/xDn"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662d484ff3bso1612907d50.1
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 15:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782340900; cv=none;
        d=google.com; s=arc-20240605;
        b=aGdHgd4lR4HwEPQIJuKTg+nE8c6SS1IdJUpLcXBPQcxTCgTCrK2yu888z4CJG2k15h
         KDEkrToTRQroVAzjRU9wLsji4H+bfTPCVdxpB0Rrs9zhbabbkSdU10RW0yWHn9on1+vc
         vlFOBLkf0oxXNfu9RJbwLWNPpkS0XHf7xCbcbzz3Ub8pqTgmTWgQUx3C2j/PWoN39zai
         +kSCgOVAWcRW8clIcQ6qUNEE9w9LC80UDcqZVCSGTwW9ocjOmIr7NfZgtgmAs+yrPm7O
         CQkXlpRE0U0lWp3uW4MnNN0g9vFdIl7bzvMVV8Gfn5C896nnKUSkom04/IujnVpc9afX
         aNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1uYuwI5UQMrf4FOORVNSBAqq2rAsy2aYavTdYoUa1c=;
        fh=/X37NMGJuGV1fvx9euliAs/QCHvyVyiXUAvz4jqoFpE=;
        b=Jt6MJz68MmiITS0tO/5PU/8xZFFWZrdn1V64H9yzSNy8O7B0l1B5Kms+LMoV4GvykJ
         srvnRHtadDr4e1b2pOgegSg+SsvX0PpeRXb3cK2d/gEn9LdnicxmgDIxUobgIwSTHyzM
         +UrzOwTU67WWeO2FG2GdA9gWUPmciAc9ASQ5FG82nez1lT0USm1IUBgkoOPn6BX54kGT
         qU5Rf1p4uvkNs5CCSPyV4EIjglb9DnYFkDJ+dax8sYOscuVl2i+MR3WF9g5ZX0YcPy19
         XK9ZwOlVqYIRkRx61pYJiKrgT1COMQvZAQzS8jgoudcSnSYqtt7ccgVky7t1FNUtltCY
         gzOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782340900; x=1782945700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1uYuwI5UQMrf4FOORVNSBAqq2rAsy2aYavTdYoUa1c=;
        b=dW2p/xDnzbQ9mbLScYUzd7PnKSNpkJESeKG924BUrn1jmL+ljc7KtHQWWvBud+Ewcg
         unlN6D3NkMo2vpwQG5L2TCvgRJzsO2lmtdfD0rVsnr9yaCzHyM9hjE7qEHNZb7IWmAFY
         EEBzWBepqhknWSDvwRVluuvBYEoTbWoyNNNHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340900; x=1782945700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1uYuwI5UQMrf4FOORVNSBAqq2rAsy2aYavTdYoUa1c=;
        b=TRX01LOWY9H34sS8GrHIbhjzxpS1D57NK2iAggNxwGUFFiuFEh/rLwZ0BiXOmYhenJ
         zWVebkF0NBDWkMSY9orI4QO2kvl/kp8g9PwyS4NXCicvWwUofDY3AdNemAjIsXiAgEIx
         egPyrxzz65k8utjWTlJrXHKdCzvpvvH9TseuNdDOV6HOdXNQGd9yPeMoJlLX7xJ0wTwX
         3ubHYsYgaGq23/vLucoysWtC1v+DCaeXDNeNj9zK1NFzOQIz1diqcxYNlZup53xiJKmI
         l7O3VIsD3lgzwpACMdsqVMomPIdru91Ea7Qbi6oKRLEMbUFA65n4XByO1qahPUi88g59
         sg7g==
X-Forwarded-Encrypted: i=1; AHgh+RqCblIVEtH7oQ08EFaOLs1e4/8S8RLwRp9J2grMPa9aImIeTNUl+1CJCkiS+RnQUuObl/UGm8Y1dcci2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YygezL/a8BC1UBw+74rxOKInTLSi9KVgXHXP17iDBHlhx6q4du/
	ipAvudQ91E9BEEYnoIWNJOS+kJ8fwXBBE0bgT2yu4B3Unvo6x6D8sSu9VhDnn6rWex7cJmiw/Ou
	625sqEp+PBXacEuGMaeiDJDBIvOjhWWwyO0iWVtciAGcTOsL16o4FxrYh
X-Gm-Gg: AfdE7cnHWU8TJmcghqT3fv2V/i/JneakGcIX1RdTCU1nluc8BV3p6rqDJGKr0U3v9jf
	IUj1NjCIVYiE5A0UxL8RIFwUJzS7/4OjkLVr3CEKtpdijWdxYWHT8Rk+E5PZbkCEY9HZx7JVBMd
	cvjLV8/N1AKlO7kZmV8jtnfd1KOVfdVptYS4k64xv409umq5zVh+McZU3HJe3PkSxp8MYcejkjX
	CLSRYBmWLNLhxIXw8TPbwmeILl/K3s40L3Qh6D8tEA8w8YdtBET3GHBoxDHUHnL3etaoRDQaLm4
	n0oMCq2oEJRFNOT/FFL8n/JRTg==
X-Received: by 2002:a05:690e:13c6:b0:65d:7d86:7758 with SMTP id
 956f58d0204a3-6636e4fd15dmr4910430d50.59.1782340900600; Wed, 24 Jun 2026
 15:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-send-upstream-v4-3-b843d5e6ced3@chromium.org> <20260609045604.44FE71F00893@smtp.kernel.org>
In-Reply-To: <20260609045604.44FE71F00893@smtp.kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 24 Jun 2026 15:41:29 -0700
X-Gm-Features: AVVi8CcTKZzbbZlWyreRB8uD4ucjtFXbjur0kDwQgo7E4rh-_3tMMR2pon7swuI
Message-ID: <CAEe3GZFVuy_Y-qHtXtdiZkoQk3vK357ZnJO2A_1WroQASSbs8g@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] HID: spi-hid: add transport driver skeleton for
 HID over SPI bus
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:56=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Embedded arrays `read_approval_header` and `read_approval_body` =
are used for SPI DMA transfers without cacheline alignment, risking memory =
corruption.
> - [Medium] Unchecked return values of reset operations in `spi_hid_dev_in=
it` and `spi_hid_resume`
> --
>
> commit ea35a3a23739acaca367a8d250ef25c96d22df36
> Author: Angela Czubak <acz@semihalf.com>
>
> HID: spi-hid: add transport driver skeleton for HID over SPI bus
>
> Create spi-hid folder and add Kconfig and Makefile for spi-hid driver.
> Add basic device structure, definitions, and probe/remove functions.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > new file mode 100644
> > index 0000000000000..02a7608c4b882
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> > @@ -0,0 +1,213 @@
>
> [ ... ]
>
> > +/* Driver context */
> > +struct spi_hid {
> > +     struct spi_device       *spi;   /* spi device. */
> > +     struct hid_device       *hid;   /* pointer to corresponding HID d=
ev. */
> > +
> > +     struct spihid_ops       *ops;
> > +     struct spi_hid_conf     *conf;
> > +
> > +     enum hidspi_power_state power_state;
> > +
> > +     u32 regulator_error_count;
> > +     int regulator_last_error;
> > +     u32 bus_error_count;
> > +     int bus_last_error;
> > +     u32 dir_count;  /* device initiated reset count. */
> > +};
>
> [Severity: High]
> Does embedding the read_approval_header and read_approval_body arrays dir=
ectly
> in this struct for SPI DMA transfers risk memory corruption?
>
> When these buffers are passed as tx_buf to spi_sync() (e.g. in
> spi_hid_input_sync()), they lack the ____cacheline_aligned directive. On
> architectures with non-coherent DMA, cache maintenance operations could
> encompass adjacent struct members.
>
> Concurrent CPU writes to those adjacent members during the DMA mapping wi=
ndow
> will be destroyed, leading to memory corruption.
>
> Should these buffers be cacheline aligned, or dynamically allocated?

read_approval_header and read_approval_body arrays are not in this patch.

>
> [ ... ]
>
> > +int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
> > +                    struct spi_hid_conf *conf)
> > +{
>
> [ ... ]
>
> > +     /*
> > +      * At the end of probe we initialize the device:
> > +      *   0) assert reset, bias the interrupt line
> > +      *   1) sleep minimal reset delay
> > +      *   2) request IRQ
> > +      *   3) power up the device
> > +      *   4) deassert reset (high)
> > +      * After this we expect an IRQ with a reset response.
> > +      */
> > +
> > +     shid->ops->assert_reset(shid->ops);
> > +
> > +     shid->ops->sleep_minimal_reset_delay(shid->ops);
>
> [ ... ]
>
> > +     error =3D shid->ops->power_up(shid->ops);
> > +     if (error) {
> > +             dev_err(dev, "%s: could not power up\n", __func__);
> > +             return error;
> > +     }
> > +
> > +     shid->ops->deassert_reset(shid->ops);
>
> [Severity: Medium]
> Can hardware reset failures be masked here?
>
> The assert_reset and deassert_reset callbacks return integer error codes.
> However, their return values are ignored in spi_hid_core_probe() (as well=
 as
> resume paths).
>
> If deassert_reset() fails, the device may remain in reset, causing the dr=
iver
> to hang waiting for a reset response IRQ that will never arrive.
>
> Should these return values be checked and handled?
>
> > +
> > +     dev_dbg(dev, "%s: d3 -> %s\n", __func__,
> > +             spi_hid_power_mode_string(shid->power_state));
> > +
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-ups=
tream-v4-0-b843d5e6ced3@chromium.org?part=3D3
