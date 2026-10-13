Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FC5437FA
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932291; cv=pass; b=auQgYg1/gqxr9cPK9VDH9R9WwdN0T8JV3sWIK3+jasNwrmKLjJxp0CvPJLssKPy1cw9id25ECvHb3zKsApR/Yv4JTlhzzHjtMxfDNb2hJK2wz5d7jJjs4dH27yjx17eStTDZdS5eDzkdZLqsUEO1FL5aGwPos1Yr33qXN1yd02g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932291; c=relaxed/simple;
	bh=0EpohbfYukostjZXI2ncT+Tc3ZmFCLMbMduDseGX9/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjnw8aFqjagPVz2Yx1/eEcLJdvwVISCSLySCRrLT127PwJnN9ifmHUe+mqqL0qaeojRUgQ4/30IaMwNiQhokA9aUn7+9eb8MNykybRBECe5I4yl53+egQm3cFTxpdisfxZhjDQ5ySO1i83X6zKMWzKpCzI8td/hsH+/sHlBnMII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oZBUNVUP; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZBUNVUP"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab43af5e97so34643817b3.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791932287; cv=none;
        d=google.com; s=arc-20260327;
        b=cLHgYx/aKS/6lriNDQSO40af/oS498LBzbnRL353Oo6E7koTrNuc+sd0dX+DLhpmre
         P2RW3NXscwY+lZsJjBMXcZqK3zDql5HV+7DxCue1zFSvgVd1HEXDjODvOcQx9n5IzjEo
         +hMAr2/SK4+C8BhoSdQMko+VbWXc0A91EMYLhy7y7CeQX4nODYHjtC+ROQ01/bOsPSYG
         w2309hpj2ojypkWEzbOOzgkiauukzIzRsQDzWENQ08Sj4Om2z0PvEuFjqG0bmskteV2b
         PxFvqkcHSBVFBBbHxsSDWXKIZ110d4HAIP/WuvzAYHLpthndD2ANtyymakrPpOq9ejjF
         8/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNT5k/R5hoaf9iRJyFQonm0fN6tqHDSkSoHBE1CtQE8=;
        fh=BnWVTRa+4CzGfopSPvVG2uACWr8TZFA1UPUXAE70XoU=;
        b=dp0GL4jGq7ElkvGXYvC3CPd87K4gRKHVeJUR7fGOmnOzqE53Xd/pFT1fSzyaGmkeLB
         jsH6VmaiWx62YlNRh8Oo1f0hQJF7eBRD/LA9Ibmh41POcRHg/iDByPCs8quMLMiteCTT
         Hp6dQPDlkTZeVPA8S1gonZ8Z+XOcW8FMYZet7XrKwrSWvv0spskcHS1M0wldo43zUh97
         x4QZtrAz5RTkBAP7TC/yMnOxWpbGSJCsn/PEqUqyX5U33NI/9IUTNnHNjqGL4qq+A/RC
         6gOySDet5cmRT1cA5I38QBfk2LbWMCsTomUsA3Qw/6aQuoneze3PZ/BhMuVu/7tVQRhL
         VA4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791932287; x=1792537087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNT5k/R5hoaf9iRJyFQonm0fN6tqHDSkSoHBE1CtQE8=;
        b=oZBUNVUPz9F891EBANCiJ1zpQtqx5ZnytrriGsQTtVDwjEfrozhfX3EUQSXt4Uq32m
         o/62ov5r2iWb0s27TnHD0DtzR75APPg3LI3NvusDHxoQodUNP2XVpwpT7JjY5USRURBy
         GVmXzV+oBz6/YA6VdTe2OhtUQVY1rruxWflo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791932287; x=1792537087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNT5k/R5hoaf9iRJyFQonm0fN6tqHDSkSoHBE1CtQE8=;
        b=Z30gpCiuZergp8uMplXUE9CyJGAej2disaqFw/OTjfeylZiX5cklkdEaPeK4wlMkKE
         8U29hsknz8Py4U9tWyDoS984q4qAVRVh4XKzc/hUkk7K/9S8RHW6zgJGeG9tn73q2sW0
         r1cCZwJYm1zBGVd9+2n7do28fqEDpoRC1Ihdwl4r/lTc70J0hxVHFX6t33GBRwWqrCSe
         faf7E3PokPrJkmsiScKexJZl6DqPow+6TWjhB03iT92JHqLpTWfMVtjg/kiukPqPZnN0
         sffANuYlLaz5slyTW/e3nnokgJN+AZrEiPR3yN/JKtTSHD2JNkhLafF8B4/sg7WTeRAd
         50OQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9JeAVbZIRLLDfSK7M1FQ1RFHG29ykiHi10UUBXT6xvAhh6L0GTGKKRVn7sGzqVqGuk2qOMIUV3oY34w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJqMQba8lCKIxrEbEwmbg9O9jZOWhE6oMOsC1IfMF3NN0SOewX5
	K3UayUwr9sna0siYr/AogyU+qfB2KngUtczdjZv4bljlfh4EzSNE7URus7RVA/JJNR1eA0Y/4wk
	W0vKzem9JRosgyRXgFllJrx+aku7Q2NnxNV8gbBmW
X-Gm-Gg: AYBFou2C9VOK+A2Oh4JaRg6sBCOFNjfh4zRtJd5Yr2jS4Xa1sy7FxCdVxTP4SypOqza
	5sWniGMTYrLwPgXw0jiXz3z3fTB4MvmEZ16FHSFT83i/soXWdCzmP3maNh9pKZudykyGd98KF3r
	D1NR8hnnX7w62w8/kLEkwFmOWLQEux24Jl/0n4/dcztM2aEThzDC68OR93cTNQ6oNmU/+KP7uy5
	g6xpOb96ZMI+mjDT1blHy2LKSP7Mr1dBzo1XHJNWFYmqORdKQ2ZA4qORhMVRWW+6ybQocFshTb+
	y7rqTjzCLCGelTEykL2q6nTLbz2DXF5Z1GQLKdt6gTN4o7+wO02bbE7/3MzDI+sYb8UHV+Zx2D2
	TIYUWZLEqAw==
X-Received: by 2002:a05:690c:47c4:b0:8ac:927:f7e5 with SMTP id
 00721157ae682-8b07ed0a2e1mr37669057b3.10.1791932287599; Tue, 13 Oct 2026
 15:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-10-384af01da3ee@chromium.org> <sashiko-outbox-166155@kernel.org>
In-Reply-To: <sashiko-outbox-166155@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:57:56 -0700
X-Gm-Features: AclHuK81HkBfvQ90JSsC-kMkz_kzpA8f9XGiSlSkqkbfMIOwnBJRPKPpuZiMjK8
Message-ID: <CAEe3GZGdbXdbqLjAmubh6EwdZ=FgzSDphmTy6YR53PySnH4cvQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] HID: spi-hid: add power management implementation
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:43=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] spi-hid: hid_driver_reset_resume() races with error recovery d=
uring resume
> --
>
> commit e43c402ebe88a8dd98c0bab5a81f64d825faf560
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
>     HID: spi-hid: add power management implementation
>
> This commit implements power management callbacks for the HID over SPI
> driver. It introduces suspend and resume operations, handling device
> power state and reset coordination during system transitions.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index f4e9b4e1294ed..66bfc251bd915 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > +static int spi_hid_resume(struct spi_hid *shid)
> > +{
> > +     int error;
> > +     struct device *dev =3D &shid->spi->dev;
> > +     bool was_reset =3D false;
> > +
> > +     guard(mutex)(&shid->power_lock);
> > +     if (test_bit(SPI_HID_DEAD, &shid->flags)) {
> [ ... ]
> > +     enable_irq(shid->spi->irq);
> > +
> > +     /*
> > +      * For devices that may wake up, process work that was pending wh=
en
> > +      * suspend cancelled reset_work. Otherwise suspend already droppe=
d it.
> > +      */
> > +     if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
> > +         test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
> > +         test_bit(SPI_HID_ERROR, &shid->flags))
> > +             schedule_work(&shid->reset_work);
> > +
> > +     if (shid->hid) {
> > +             if (was_reset)
> > +                     spi_hid_wait_for_reset(shid);
> > +             error =3D hid_driver_reset_resume(shid->hid);
>
> [Severity: Medium]
> Does hid_driver_reset_resume() race with error recovery here?
>
> In spi_hid_resume() (drivers/hid/spi-hid/spi-hid-core.c), the power_lock =
is
> acquired at the beginning of the function and held until it returns.
>
> If a wakeup-capable device suspends while an error recovery is pending
> (the SPI_HID_ERROR flag is set), spi_hid_suspend() cancels reset_work and
> leaves the device powered on.
>
> During system resume, spi_hid_resume() reschedules reset_work to handle t=
he
> pending error. However, because the device was left powered on, was_reset=
 is
> false, causing spi_hid_resume() to skip spi_hid_wait_for_reset().
>
> It then immediately calls hid_driver_reset_resume() while still holding
> power_lock. Because reset_work requires power_lock to execute
> spi_hid_error_handler(), the scheduled error recovery is blocked until
> spi_hid_resume() returns.
>
> Consequently, hid_driver_reset_resume() attempts to communicate with the
> device synchronously while it is physically still in an unresponsive erro=
r
> state, which will time out or fail, aborting the device resume.

This needs an error to be pending exactly at suspend on a wakeup-enabled
device. Error recovery still runs right after resume, so I'd rather keep
the resume path simple.

>
> > +             if (error) {
> > +                     dev_err(dev, "%s: failed to reset resume hid driv=
er: %d\n",
> > +                             __func__, error);
> > +                     return error;
> > +             }
> > +     }
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D10
