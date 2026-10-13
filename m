Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0F55820F
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926535; cv=pass; b=ojlGsKPVCSRgmul8EW9wYxd3D61l2Te+wh0dLUO+6fFnPIbRBktUziLJ9aMrRcd6QwXaQpIpEl4LEJBzS+b3Te/jx9xXVGYbmVcQ44ah3JPmJzpBRu9nWL+Izo3eAKR0bDTVuiKWMWs+tiIMX3swpNXSeeKYwlDwyZBlB+i0rOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926535; c=relaxed/simple;
	bh=sf30vAcaJ++DLttGm/TNinMSo0jN9WDVolmb3olSr0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnl7sUwOACTBPKVG7xnGz/jW1kcSIjHeYXXG97F7UiOUKPsQnf5ST4JhXOT2UhRqTsh46QuUqCOYEu1jSkwDmgzGQxXG/UVP8YZTqdI3fXpFehhFKQnl8jiEDWV5303hxvgjEGkty4Q5GK17t7oqkvjC3ipHg6ftxUxfYcyRdpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sc7Gh42h; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sc7Gh42h"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-836c8bde2dcso22746257b3.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 14:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791926528; cv=none;
        d=google.com; s=arc-20260327;
        b=hkksnGANrkbsPt4wVqQf9Yig4KXmx/ACi2Pz9xVIkXGXK/Q0CWI/UKeU2cxIQuuNav
         TYJ0RLdK5xAScSa6uXqevflzNr+IV3uOw7djThky4hlSRojRm+T//evKaNUO/VbQHQqJ
         I0FFuzKF56//t0RnO2EsY8DYwEYIvD1YIqLwgr/Q2VOp0nZ8r6Jb/UlUVWFFN3rIG+FB
         mlDCOvct/RvvIfkBdE7eaEqIIORM5jSQkhAN1VQQ8X5hivcpiLesMZv2HU8kHYvQwdcj
         MWt7kJS7hHvKma5NRVOwsy9BIbURsdnpF+a+s2odDPzWnhJr+JPMtSKwSBCjsAN+s7yu
         8zHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tW1MH59A22+8G0RbZ3B3dj8ln/Mz2H51o5N7Shhczv4=;
        fh=j/h6zxYw0kS2P9cXkYJhshyyCmBkVzu55GsFqm/ikDE=;
        b=dr8nUMX/1reKcKosIB+QyrgH80ZkifS1qSSK+ZlED5ArMrXD+p/yoRh611ezToSv7u
         1E0xqaLxeFXyrzy5M3yCTxgzl0Tfpf5EGDm9cuKtj99iDAB9DvGsGTYc8z6EQfgqhWIb
         gPJ9Mf6lhqjkdcP4Vtr9TYJBQcRwgcl5A1mJ6F6iK9Tpr1XE1esXANDUi8twMvJmi96h
         1W23aWE18ZJoFYJSOIGIRXsFWT6FEeW5Xk+YIITMNrVVwN9qLgkBJ229OXVgB0eCeZc8
         oLJk414GM1uTOm6srvcFx4aNACjkX6TqKmlc02Ekbgr1acUJYZc0FKhIrlo57JuP0Mx+
         kHwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791926528; x=1792531328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tW1MH59A22+8G0RbZ3B3dj8ln/Mz2H51o5N7Shhczv4=;
        b=Sc7Gh42h6n0xBIW4jv8fFKe2zdPNW4uXbZLoU5mw34wx0S3tlmBSafIcAzh8tu4VIY
         pxY4mnOzgzmsLdfbyD+0t+6K2HKAO+hmJo//Gbu3+q5hLA8dVMikUJXaPWatgWbxA8eT
         M2J/XqcIQK3Fs3L+autqFqU2gzYUQXCbygCic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791926528; x=1792531328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tW1MH59A22+8G0RbZ3B3dj8ln/Mz2H51o5N7Shhczv4=;
        b=dRgp6Wr5OTjgZ1mc9t0jIqtULHst+dY5hvSQenObI2TzwcJntnia54ZD0HGK8+htkj
         djPZXxsDcWp2ARUcU9OXPp3hgtNkS2UAtk1RyUQljrl3aAPCSYYzxG2EVO6IzQq9t9Iv
         iriq2v+Uzvip5micnZr14kfzX++PRfieleqBEi8+bF5qz8pAMjJk3QZmowMg3tPgk/d4
         SD+lqy8WJ4TGdiN4onJDOwKTe1UMy8lzWVMjpN5m7CTl5e8i16qcnKlNHKYgUKyjvHD/
         +7/JNgYdEjXAD/YYdYjCAp7ySA3k//D4AyxDLmYytiMaCTVTm7OKXZU6JKf9uLUI9f2p
         Rwpw==
X-Forwarded-Encrypted: i=1; AKwUvByEn+E/6WoZ3I8qd3O9YgAGSZp9jSR7BALk0htW8BX7Dlb0OCVCBfH4fVUlPg85PiXccSMSfNlNj+3Scg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJm04jWjIL1dUomqvWRj+PV3WpvuG/hqqsOOlDuaob1XFRw/oqm
	Xdu/eEMyLMtr4tqkRZHED6PmogyDEWU6zupxc1Gd0j01uOwJeVQv7G5kiUMzTjCGSZ/OLcJqYzz
	ETAf0YmN39pJt2DEljgvf7o86DF2Ygvlox7vsf93W
X-Gm-Gg: AYBFou2Y8FBbyfQ1whlB0vMBK/jPGQ6npqD0Ff+O3oaMKpadEiWXMTlQEjBTG1TXoqo
	VmdrpLQKU+LVkibb9x0cvw6vQzNIsxiO/5T+/HLiXJ+ras0G1EdxfNimm3ls3ciyv3EciH132UL
	rdlVJFSOJ75Qm+zpiLbXvhn+2Cohqu3RUYGF7Ik5zgGHiydsztjHBhF4ulrU45d/PtDTphUmCmx
	GfqB/B4scRwF86Jk6VR/STyPXfuccIOK3srNamFpoMzxrk21ENSbIKGh3TSOWg2atliw8RksDDn
	C4dmZiXnYwXUzwmdJOjfCSZdqtHsCKNkAWgH4LWp3eDzu22XZiSdXWpOQF7U/GhidX1FB72kNwy
	n3aTmn3VddA==
X-Received: by 2002:a05:690c:4d4a:b0:887:f4fc:ee35 with SMTP id
 00721157ae682-8b07ed1fb6cmr47618147b3.19.1791926528330; Tue, 13 Oct 2026
 14:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-4-384af01da3ee@chromium.org> <sashiko-outbox-166154@kernel.org>
In-Reply-To: <sashiko-outbox-166154@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 14:21:57 -0700
X-Gm-Features: AclHuK8vj_2CnW3lS7fdTlkJRR8RuhSwUE7H_CFag_-G2v-URCUG4IFSzD-lQgw
Message-ID: <CAEe3GZH-QD4vj71c2AR6Y0VFhchBARBctYtfmur07nrgK5xBWQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] HID: spi-hid: add spi-hid driver HID layer
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:42=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] hid: output_report callback sleeps in atomic context
> --
>
> commit 954a3684cea1bad33a85c00ff6725f7553c75027
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
>     HID: spi-hid: add spi-hid driver HID layer
>
>     Add HID low level driver callbacks to register SPI as a HID driver, a=
nd
>     an external touch device as a HID device.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 02a7608c4b882..fca7a44eeb9f9 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > +static int spi_hid_send_output_report(struct spi_hid *shid,
> > +                                   struct spi_hid_output_report *repor=
t)
> > +{
> > +     guard(mutex)(&shid->output_lock);
> > +     return __spi_hid_send_output_report(shid, report);
> > +}
> > +
> > +static int __spi_hid_sync_request(struct spi_hid *shid,
> > +                               struct spi_hid_output_report *report)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +     int error;
> > +
> > +     reinit_completion(&shid->output_done);
> > +
> > +     error =3D __spi_hid_send_output_report(shid, report);
> > +     if (error)
> > +             return error;
> > +
> > +     error =3D wait_for_completion_interruptible_timeout(&shid->output=
_done,
> > +                                                       msecs_to_jiffie=
s(SPI_HID_RESP_TIMEOUT));
> > +     if (error =3D=3D 0) {
> > +             dev_err(dev, "Response timed out\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +     if (error < 0)
> > +             return error;
> > +
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_sync_request(struct spi_hid *shid,
> > +                             struct spi_hid_output_report *report)
> > +{
> > +     guard(mutex)(&shid->output_lock);
> > +     return __spi_hid_sync_request(shid, report);
> > +}
> [ ... ]
> > +static int spi_hid_ll_output_report(struct hid_device *hid, __u8 *buf,
> > +                                 size_t len)
> > +{
> > +     struct spi_device *spi =3D hid->driver_data;
> > +     struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +     struct device *dev =3D &spi->dev;
> > +     struct spi_hid_output_report report =3D {
> > +             .report_type =3D OUTPUT_REPORT,
> > +             .content_length =3D len - 1,
> > +             .content_id =3D buf[0],
> > +             .content =3D &buf[1],
> > +     };
> > +     int error;
> > +
> > +     if (!test_bit(SPI_HID_READY, &shid->flags)) {
> > +             dev_err(dev, "%s called in unready state\n", __func__);
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (shid->desc.no_output_report_ack)
> > +             error =3D spi_hid_send_output_report(shid, &report);
> > +     else
> > +             error =3D spi_hid_sync_request(shid, &report);
>
> [Severity: High]
> Can this code sleep in an atomic context?
>
> The HID subsystem requires the output_report callback to be asynchronous =
because
> it can be invoked from atomic contexts, such as softirqs for LED triggers=
 or
> force feedback.
>
> Both spi_hid_send_output_report() and spi_hid_sync_request() acquire a mu=
tex,
> which will sleep. Furthermore, spi_hid_sync_request() blocks by calling
> wait_for_completion_interruptible_timeout() in __spi_hid_sync_request() w=
hile
> waiting for the response.
>
> Will calling these synchronous primitives from the output_report callback=
 lead
> to a scheduling while atomic BUG and cause a kernel panic?
>
> > +
> > +     if (error) {
> > +             dev_err(dev, "failed to send output report\n");
> > +             return error;
> > +     }
> > +
> > +     return len;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D4

Not really. HID core doesn't call ->output_report() from atomic context
(LED updates are sent from a workqueue), and as noted in my reply
on the documentation patch, USB-HID and I2C-HID already sleep in
this callback too.
