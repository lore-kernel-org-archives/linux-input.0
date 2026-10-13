Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCFB3D6CCF
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932816; cv=pass; b=ElXyMtqa4SMRqpG0zSM4Qc6TjLKOt7BON16Q5ogVM37Po0bkMjCVyQeB94l3oYTb8kRtgKgJ2Bj7poMmmUFDRgta7AfSRJd3GLG+XFp/njrnA4gKg23CCSB3T5Faw68u/da5OI3XcXmG99fBIJLnCuu/z115peCC7tGfPPBOLVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932816; c=relaxed/simple;
	bh=OJKCxitzFX7Devyeo1RMIWQKY4aZ2+94sv/X63QES54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgcJ4Ep/bECVrN6FN9bv+UEL4eTriV+s3Bugo2FU0cwPmjGB43PLN74eJS3HGaj3C4O3uFE5fo/kJfvksh/fJPjIh12pAMzxCaB8G4RRNZBaiBZvEqC7+UX5O1VoGCs0dFwdjk+8GQKxr6isXPtOIQHRJRKhFcWQkq5J+LyQXyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LhjcfavC; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LhjcfavC"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8871ada1a26so3816617b3.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 16:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791932813; cv=none;
        d=google.com; s=arc-20260327;
        b=UE+a2ja9dbfDoIyw3Gq5rvgQCch+WH2exC7U/M2jfU+qUZVk/UgXp3/CkfODjFdBwD
         nC20jQAqxv+wAOBBqIFWTKY2DUlEGN/709pQu0G1O5TFlaOLlZC54+lcodoS4k1J5tNW
         tOHZ6qAtJ0qx1FFxk71fWjEKP90fhQhej6Nun5PeQyfGodXQaS56ZPWlrIftu1bmtXeM
         +P5WgEGCFlUzMChAX0YTIMCGhmqS/EY2PY3Fa0vFo9H71ALz/05GTnEm4iCDkijqiZD/
         BlSzKnJet7eIwWKRGf+uIKoFT7oE/vkHoUoWXlTLBqhyFKB/eaRb7lMTEoDyTS6fg3HB
         t5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QntlmUV+IlR8FFxFh/1ODDrw2JuP6ngb9YrJOIy5BCA=;
        fh=ncgXunX0gIvrom1WiS1cFWIZma4g4Mh7NZhFG/vhRZ4=;
        b=lbGQgmT6GOiUj8mGzDiI+7ZF4JCdb1fx6jSxlBGcapX/EQC18BHAHc4DPHIcbq7w24
         p9fO2nrx4uuzhJBaz3szhtB4oLAlvonmzlcFehzbrJ3U3QD72Orri06IlalMJqCj1UZX
         cvcfx/YFjj5nssOmv7nCFm+vCNcVkCkDdTQv3EvsW1pDzEr8w0suBke/DWVRApIQTMvV
         LNbf3nTeC5ZkL4JAPV70V/P+9MGtK7xhTS81BypCLK5xvwbDMUk9NNA2qUKrp/Mr1sTz
         /TIO4EIuBjQuKOz7baVAoixVSe3I2HPTbuYjvQiNk6DMvqneN91QI09evg4A74NdyS0E
         8O6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791932813; x=1792537613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QntlmUV+IlR8FFxFh/1ODDrw2JuP6ngb9YrJOIy5BCA=;
        b=LhjcfavCp9bD3Kt6BHrZPKZfe7C83QVgolYum5AlSX/RQHfYq7ACFgSFfiyOa/MYIh
         g0vbeOCvoXidnwGNuYun4Y0vu65zajMlnhekuDSSZW3gSwbAxqwHNV9YSK8aFT7zDXHP
         LDJJGDFwHjPC3wbXiDX9/gohTj454dcIuMHDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791932813; x=1792537613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QntlmUV+IlR8FFxFh/1ODDrw2JuP6ngb9YrJOIy5BCA=;
        b=qOLels8uke82cQWR5OX4urJBPhGPL03y7MyO9zFTXeCxi6WqbsT7CtNecgI034VQ1r
         WCgbjGhtZ4sg2zmxauT3YcwHbmIVHKDibnj83esvmwqwC8Daupa2wOVjslnUgNwoo9Hl
         5t0hOKp4WheedK6+Y61Pw2ML7SRYp85GR3GTj++Zu3hBlB+P7W8RBMwPlke6qaI0Uve1
         aFKty20W9ajPwqfjlMS80YXwX3BxAWl3PXKYs06NgmIwWkN39mAJpTFtcHSog+xloYaI
         CKEeXq5CT/7hJqrQ04kPm4Dklj4ol7eDRrL/p0Ncp2hjz6eJKwvu6nlrbRlOheXJu2MH
         K4sg==
X-Forwarded-Encrypted: i=1; AKwUvBzd9FAGlr+WaZEtzTQQq0fM5nECml2qBks4cYCY0zP+tg/EUV/qMmgvzVRKZh13+xxELz7nks3N/xWRdw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIOPusz8viKtadE7pA/4XRDnzc9G06Zrm17rPAoIUSw5eMoBLdF
	t70DDPPf1ZbyYEpVs9B8ajCdSh3gMuWkrSQs7h2qgut3CB8jIZhOY8hGxOJ8EtAxQpOFG+tRcPD
	aSitRkbZcnFeHRzo0Ymv+pRBeC5ScgjM/NkfCGVk2
X-Gm-Gg: AYBFou1tVrX7ixfCVL5JGQ8ULyGS6mIC9WPHfBPG7/tZn0erugL/9XmbJBZc9UjOxWv
	SfdofCmlPwl/H9Rwb3oQyp/yIEBEE9Hhw2WJ79iG2gdUcrvO7loxEk5DExL+giq2ZU5rgPgitqW
	5i53VmnlEW7ZaLG4+k5BC89vwWeLoaF67VBqwjcvTA+GWdB1iS/+PqGmgJXw28YVujXh5IVjpvi
	GFXNwq8UMI9SqUP8ePu9N0R83mybi/dmDLuvHvAtDTZFWoByFCC7nfIRKoEjSSZoLDQtPR3f36+
	1Cz1SjL3+drKYvwSkxgMT/Q5Drnl0SPieLt1OFI3Y2HuGamJsCk/Y65cBiaVSaJ+xnHPZuXIyMJ
	Yw2AvEylpFg==
X-Received: by 2002:a05:690c:82e:b0:8ac:805b:3a6e with SMTP id
 00721157ae682-8b07edb832amr35007727b3.25.1791932813416; Tue, 13 Oct 2026
 16:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-11-384af01da3ee@chromium.org> <sashiko-outbox-166150@kernel.org>
In-Reply-To: <sashiko-outbox-166150@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 16:06:42 -0700
X-Gm-Features: AclHuK_EPiuPXQkmP4djXq_D1z67MVt8XUJL6Sx0kl0aGpRUcTZIlzf43HHn9kY
Message-ID: <CAEe3GZH07w_-Be--FnoVJXvOXtQ4pnjO1T8CMkejVaUFrVC9VA@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] HID: spi-hid: add panel follower support
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-trace-kernel@vger.kernel.org, robh@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] spi-hid: Inconsistent wake IRQ configuration for panel followers
> --
>
> commit 4c8d0ec463c5dbd300c392f3f924992096f8ebc1
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add panel follower support
>
> This commit adds support to the spi-hid transport driver to act as a
> panel follower, allowing its power state to be sequenced with a display
> panel.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > @@ -1577,21 +1676,17 @@ int spi_hid_core_probe(struct spi_device *spi, =
struct spihid_ops *ops,
> >               }
> >       }
> >
> > -     error =3D shid->ops->power_up(shid->ops);
> > -     if (error) {
> > -             dev_err(dev, "%s: could not power up\n", __func__);
> > -             return error;
> > -     }
> > -
> > -     error =3D shid->ops->deassert_reset(shid->ops);
> > -     if (error) {
> > -             dev_err(dev, "%s: failed to deassert reset: %d\n", __func=
__, error);
> > -             shid->ops->power_down(shid->ops);
> > -             return error;
> > +     if (shid->is_panel_follower) {
> > +             error =3D spi_hid_register_panel_follower(shid);
> > +             if (error)
> > +                     return dev_err_probe(dev, error,
> > +                                          "Failed to register panel fo=
llower\n");
>
> [Severity: Low]
> Does this sequence leave a dangling, inactive wake IRQ attached to the
> device when it is a panel follower?
>
> In spi_hid_core_probe() just prior to this block, the code checks
> device_can_wakeup(dev) and unconditionally allocates the wake IRQ via
> devm_pm_set_wake_irq().
>
> However, if the device is a panel follower, it calls
> spi_hid_register_panel_follower() here. Inside that function, it checks
> device_can_wakeup(dev) again, warns the user, and forcibly disables the
> capability:
>
>     if (device_can_wakeup(dev)) {
>         dev_warn(dev, "Can't wakeup if following panel\n");
>         device_set_wakeup_capable(dev, false);
>     }
>
> Because the capability is disabled after the IRQ is already requested, it
> appears to waste resources by allocating an IRQ that is immediately rende=
red
> unusable. Should the panel follower check and the potential clearing of t=
he
> wakeup capability occur before the wake IRQ is requested?

This is harmless: devm_pm_set_wake_irq() doesn't request a new IRQ,
it only marks the existing one as the wake IRQ, and the PM core only
arms it when wakeup is enabled. i2c-hid has the same sequence (the
I2C core sets the wake IRQ before the panel follower check).

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D11
