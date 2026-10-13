Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4885625EA
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929715; cv=pass; b=D1Jc7Boblm+ue8Y9yvep+huv2cNyHc2teiNnc+29TC6txnx1MS6HIkyl87r5BHVS7mwQpcX4QaJsJbN4+/3gqHtCwUsnVCYZstl6TF8i09zbwfImo31GZhfKTa32BSmhgyWCtGRXmphU8hEaoPs1ybpnkm0J+B8ljWPyNAejLPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929715; c=relaxed/simple;
	bh=YoOftzpeEReVb6O4VclP/t8iOYPrrpNMFEoppDguHGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRpmWH3OIZU6wdrIbJsByz+RxC/4q84sbSWdAzSf/0KD51CZBz4uwMlJnKoQ0I6DVcCOb9m5gdE9v43AZ4sSnaXENLaj5mCTl00FRwPcj3tknkdk+lU1/406CKn5tbo+FFiEp0okvysl+Gf2tfMf7Z6rlhPsiKqNefbjplLruIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CU2M3KlD; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CU2M3KlD"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0a28a720aso22022277b3.2
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791929712; cv=none;
        d=google.com; s=arc-20260327;
        b=KAeBpCSxmSHi06M44FQkOGoXBLhTKrS2BJXY81WG/8nbzIdYOerll78wEqgIoCDvgC
         HAw4HzzGzMxI1UVYFdJLNy67D3fhWhfl8ZgUwTqWtUxoZj+E2Q0I4KPtr+5UtV7jpIWL
         RPsynhWUovlu6g1JDaFL29Tx5t5UBRzbw6qZ8vueCQd0AjUJujHbLYaH4KdRO7y6d+oP
         8xgbKa/l9GryKy7vGI0gkYae5TzNyAUy2ze8TgLO34h1OE1z13lFdgLM8eGwTMIfT8nS
         UxlbEESanLhTpshbJg6aRCAinz5kwXp55jwpYHa0kePbU6UtEcj0d0GFGpa2IOnUAkQG
         7GJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gu1pMEg3izEfc/rQ67eSbYz040q7y2e9OLH8nvi7wBU=;
        fh=17tnt/B5nHSRI9E38cE1dkbiihK3qjC/htYiebErGPA=;
        b=XZKgyKt5V8/WsmislNrbxC+z8orULbCGRfnoS+/gZhrOa/HXa/mG4mYZp9uxdrhrJA
         d2wBAUCHTSIxjZiq9dkJW/CRPeligW0cUfpRV/K9dAds5yoWMUD1zmuadisw6J8CM1LM
         32x0Rx0GeCcq0aaWjm31j54Zu8hqAYebeyom+dyxJufuooKthwFhMWGM+YiRCmLuGuhG
         vQH6ApqmpXh2qY7Q1kg5yu9PLqLajcbRChU7sPnD8Ble0YQaSOZYlenUJJK6sr48h54I
         3955AcaRjVWNTyn9+450e3X8kuf6b736zCwda+mX4lxjwY8JWf+5HMYu0kHD+UXe6Tm4
         iwZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791929712; x=1792534512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gu1pMEg3izEfc/rQ67eSbYz040q7y2e9OLH8nvi7wBU=;
        b=CU2M3KlDWGShhDGLsvVmNHaag52sVAPgnsl/46rX4qmt6Oq5kdhpnE2Ya2eqYjeKAl
         nqoIYb2uYCDSy6x6hc0GVKf0hy99xPkaUTbhAOx4fojhEw+lm/yYy/l9joKVl39iSRwp
         MOANNDIM2El7Nbfv1Of3F4DOG75+7iqqBEKUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929712; x=1792534512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu1pMEg3izEfc/rQ67eSbYz040q7y2e9OLH8nvi7wBU=;
        b=sxb3URxnIxQcliSJ3Pi5y5vdA3QVZXpSu6cgU/0xzTDyekHLvgdG13cxbhtu3CFhCF
         Lv1Rdqew/leXpc6HfsHrLhlpI0AdCMMoql18VkBcidT6x7O7V2jeeecJjVXDZl7I090N
         HKpm1DC7FraGb/tmoIHrCCAA+cqekvXe54pc17gmqKvSTy7GaZ+kLC+Ge0EInirQ0JAZ
         WHlnn0rxDj/3UkZalhJ5yzHZAnCxkiRQKjDFuJHI60kzX8ZUd02DcsfrtBVCpj5jyrzY
         3SjOt2Dgg3mKOYuNMaOPhtLm1EEJEbcs8zx48uKp0/sPcFxTnwqH+eOBKPxldB1RmhJw
         VIvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDv2uHfVGG0fb6yaWEFG+zH96o/TSjDBzx0pDB3ZVSy8saF37PweSDeVQr7cKBoOFxTys+uZj6cPgihw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/n47DNcDWR1ICjlqV/VglKuDhXDdPIE+XzXir9xxkMjc1Pmp4
	2zRbL1Lm0Q02vS8FJRN/5b+t04RtX3xJ2Eu5BRHDtDwe+5K6iImN+bIlhxpgOcp7WcGaBNljEFd
	cde36L4s1jsW/1rhuIaEDPXn9Xu4sNNFt5c3ngNGJ
X-Gm-Gg: AYBFou0nfwL9lIvVaM98lXJx5I3Ivg9VOAYH853iMM+XTQf2bP98rluvHfpsOAvP+0w
	bl28ZLmcJc2FLi9QXezGa1fsnV3B3ELGpJXzwUsV6WGu0vNwJRbO0U5QVMrJrRChsTn+3TN78Nn
	bHUGbseelJMmSDptj7HLfzYjhs0Mjuw1QahXae5UYvEQmVIox9BZ0siRCVU5Ep4qvIUXZxadILg
	wB8hOCX8iHODyGMK7C0SCXBbAWoZC3vnlXeoQ6SZpUDXBi1B2U5jX/4+bzkcRvAC3EOR+eTYMdO
	jw1ZbWoKjuAIoli7GTxHMWEUzSfDBXn3acTi03qQLQOICLnDuOibjWbdGO0j/Ec47NlbFhBWdOJ
	nGOKOGX9Ziw==
X-Received: by 2002:a05:690c:e1d9:10b0:8ae:dfee:cd30 with SMTP id
 00721157ae682-8b07ee80677mr35220177b3.56.1791929712213; Tue, 13 Oct 2026
 15:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-7-384af01da3ee@chromium.org> <sashiko-outbox-166152@kernel.org>
In-Reply-To: <sashiko-outbox-166152@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:15:00 -0700
X-Gm-Features: AclHuK8LY0flPJXmLlCRmm3TtT6hKXqXYTxefNgnCBXeN5jvcX9L7jCw_bXXSqQ
Message-ID: <CAEe3GZFCEBXTQqGw+JdppYm7hCwuoBTXuAf104ru5nArKwes9A@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] HID: spi-hid: add ACPI support for HID over SPI
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:41=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] spi-hid: data race on bus_error_count in spi_hid_error_handler
> --
>
> commit a262e333d16eb58c8aa593f81c7497790c2b01b7
> Author: Angela Czubak <acz@semihalf.com>
>
> HID: spi-hid: add ACPI support for HID over SPI
>
> Detect SPI HID devices described in ACPI.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 83678e6835818..f4e9b4e1294ed 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
>
> [ ... ]
>
> > @@ -327,8 +303,21 @@ static void spi_hid_error_handler(struct spi_hid *=
shid)
> >
> >       shid->power_state =3D HIDSPI_ON;
> >
> > -     shid->ops->deassert_reset(shid->ops);
> > +     error =3D shid->ops->deassert_reset(shid->ops);
> > +     if (error) {
> > +             dev_err(dev, "failed to deassert reset: %d\n", error);
> > +             shid->bus_error_count++;
> > +             shid->bus_last_error =3D error;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: Low]
> Does this introduce a data race with other updaters of bus_error_count?
>
> Userspace sending an output report via __spi_hid_send_output_report() che=
cks
> SPI_HID_READY locklessly. If SPI_HID_READY is read as 1 just before
> spi_hid_error_handler() clears it, the output report path proceeds to acq=
uire
> io_lock and invoke spi_hid_output(), which updates bus_error_count on err=
or
> (under io_lock).
>
> Because spi_hid_error_handler() updates bus_error_count here without hold=
ing
> io_lock, both threads can execute shid->bus_error_count++ concurrently, w=
hich
> can lead to lost increments or torn reads via sysfs.

This is harmless in practice: bus_error_count and bus_last_error are
only debug counters shown in sysfs, and losing an increment would
need two failures at the same moment.

>
> > +             /*
> > +              * Without a successful reset the device will not send a =
reset
> > +              * response, so no IRQ would trigger another recovery att=
empt.
> > +              * Retry from here; reset_attempts bounds the number of t=
ries.
> > +              */
> > +             set_bit(SPI_HID_ERROR, &shid->flags);
> > +             schedule_work(&shid->reset_work);
> > +     }
> >
> > +     /* Balance disable_irq() above; a retry disables it again. */
> >       enable_irq(shid->spi->irq);
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D7
