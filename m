Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47151DFDE
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739893; cv=pass; b=TM8QhScUpaAu5D5Lp6tDJtLf8qCBD0R4xS0Id0YbUR7hZ5zj346CX3I2UynOdrXLBU4z7fhiWi43IpO/Zsfy8wozyyIHB/82EqkOvY16/e5oG526/gV7G21yOLOtYLNUsMqyMjYWqMg/gxx2SCCZJatLPHoOyATU2+sAFvLWJDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739893; c=relaxed/simple;
	bh=K4FG+7Z79h5g4fLJ/g3dvEVzqs0twnXv4gdci60OilM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZBN5ecGVovyBh0fFEZmj2blDJZ7AvQ2s39ZFqR5lUDJ3CD+R4Goob8RnCzGFBOFCiuXl8+1tsugC5oEazKar5khXLrcQtmBIvOTOQI502IIKHgalFKfGPczEBx8xS58KN43TViUoMYG2AcTsOrGDGnV0i0CDR62GFEEL7zTbVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JES5PW+N; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JES5PW+N"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664bb15d05dso2428405d50.3
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 20:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783739891; cv=none;
        d=google.com; s=arc-20260327;
        b=JPMWIL7YJMuKKNWdvUyDYIM1k65GRNjijMgosgPUE+8Mo+QQSa4NunNqr4edfIFvEb
         HAUSJ7PX3nTUAxIMhv0PxN33qrWrTqz1NABVkUzhaTAPh2aeRs3qKb/Nvwje459Tl7XF
         dcrGxwE4L/g9H4m2TEZiXgvbqoOWhIpCuCy9FkP+Mk3VKIKyd9BUkK62Grvde8u4WHne
         mosD30XV3dXu0/gM1TdYlqoAZjO3nOGTq++/VuedNRWN9jrMTftBxlWYjGiYdEDhwOQt
         l4JvFUhwE+6VNGtlPNhGGUoXmUlrwYYZVg7rwM4ykw0GtGwL8KvSfJKq/HK7y5lfHhrT
         hwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=guNLAwfgrj4JsKCCSaivnU7c3xaH6IyNfwNJ85O+2q4=;
        fh=+FjvbUApRKEvQTO6pQbKyokQqAihFkt+cjnrYW+k+BU=;
        b=lYz6qGwcxSmBM7qGagEoO4B/E5soTn1oRMsSIXyuFdIp/vslsSVCoxuneI9u3+gObO
         8WNwbPo51wWFb20F4tbOB5ocjk/nmNkkM0V42lgezmRTiU37/iaWHyb5wcab/YA/pTwp
         4V9ofJ4AwnAZn/1+MlWUtjYBxyE8a37w9IvDPgUOW7q/EFUFQWIkJzdb7ogi1UYCCbTN
         xkB2o4KjBnkZpZ7jmfjBsfzXqdQ5DIcxg541+0FXFY6MUzpPCfV1p28rSaLoGQrmvQ3l
         hpmAlgDMsQWD9RKNYvHD5cLNY5RDArsxRwjHtIY6BdSs6wVH92mJDfOgxh1+jQvcqY/K
         7fag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783739891; x=1784344691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=guNLAwfgrj4JsKCCSaivnU7c3xaH6IyNfwNJ85O+2q4=;
        b=JES5PW+NtPBaJaZGBtCCBUL7keV0I0VyTkfCHA31m2RB9JqaeMZoASkbplhHKI2VW2
         /WeY5WBeuKeUTcRf6QEPqnYpilx80q7i3cwS9EFL2/n3mGmWpcTZ2aCCUKvIAhtIdNr5
         uP4j+BieKHqesJhNmyys/jP1/jVQuSl2QvQ7c6i8DdjwJRGo8SnwuRfFNIyMnN9ZgKxT
         7ZuQRi//VubF4JFKHpxgiMK5b4KMGjyBf8RndJY5rtZsVVoI8Q7qTpzYlXaXtsH0V1sv
         BbxijeRJK4OLibUesxK9hD6e30dO4I2Vsl9kQiUbHT2n6iRHWnftFwIgqqqPeRv8Nh9a
         YWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783739891; x=1784344691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=guNLAwfgrj4JsKCCSaivnU7c3xaH6IyNfwNJ85O+2q4=;
        b=la3nUlmTGmHF/7D5PbBDD/D+tKnX6oKAbHemcxeaQX2NEkafYGo6Qd2S1ckybyV43y
         iUBcCedTBw+OJTiwawOboOM0dIlX0sYt0bVuHrthg2lPqJsq6K8quTfW5Klhc4La3ZFt
         aIes+cEIcAjUMfs3OIM6MFXVz+SBVld9SaRLcTdfFi1cHRQlwpEqBOHXcc/QXhmASWhb
         DOhuLBRGR9VrvDyhY1vT3yfRwQ9Iun/b7m8z2aIUHL2fTdZYTuF9vKfei9et9y0g+2mm
         ccyFuMlBZkPRsIv7AdCYJVG6ol96JxisIEheQBaL/YF12rACBtCLOxGr9oKvACpxScnm
         7Yqg==
X-Forwarded-Encrypted: i=1; AHgh+RoO4I4OiDmnOEX8FRLH+9p8iqQ7cj+6MyfM9hmDOy+Q61vtDiwEMLmK5pcP7UDpI45eM2p6hoH+nodndg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4ByyX27JQDWawgk4bPcYmxlM0OKh3sT4AZMM4v4wrRyRPWMB
	a45zJK1G426Fd1k/SjciFEzHUBHKheTVgF/AlQcJkitAQbtFD9LqUdgC/ENv1zit/s9xag//ppe
	dtMMYmd+i9mY9tDigIVRx6Euin74XWjs=
X-Gm-Gg: AfdE7cnzSWXUdIWdRQ8UPIr69+yvFQLBTnxOnKMJeqw5VEE3Jf+US2zr2OuDvKHhxed
	bn3wLsMCmoKg47l9pW9icCMz83uesQUSWBYCIQ5uLYF5sS6e4blsu0HoJgYd5tkRzd4ny2WbHaG
	bhiHP6WN6D0j/iUS7bd1pDjp/CBM2L0IMP9LdIge+a3UEsQBuIKDAsGotLYLqrNOPatKT48Kro4
	MwGY/rrznwQnQo7kG3fHcptLP4e3tG3EuRk9fXfScuSW6ekmeJnYCWO0hvXOUWX8AnlBeSE
X-Received: by 2002:a53:d3cb:0:b0:667:8b9c:e6c4 with SMTP id
 956f58d0204a3-667d7cdda7cmr976523d50.104.1783739890795; Fri, 10 Jul 2026
 20:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-qt1050-calibration-status-bit-v3-1-cc9ae3f0b2ec@gmail.com>
In-Reply-To: <20260710-qt1050-calibration-status-bit-v3-1-cc9ae3f0b2ec@gmail.com>
From: Miles Krause <mileskrause5200@gmail.com>
Date: Fri, 10 Jul 2026 23:18:00 -0400
X-Gm-Features: AVVi8CdX_yj_m_XkuG1QVw9yMigw13icHi9JChsUn70iAqddBIKYw9xMqdXBj_A
Message-ID: <CAA6QAMKe5n_=XENzyPassuRXuR06LF83cs-U0oxKYAWEe8aN-Q@mail.gmail.com>
Subject: Re: [PATCH v3] Input: qt1050 - wait for calibration to complete
To: mileskrause5200@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Marco Felsch <m.felsch@pengutronix.de>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard this series. Further review showed that the
calibration sequence requires hardware validation and a broader
investigation than this patch provides.

Thank you for the review.

On Fri, Jul 10, 2026 at 10:52=E2=80=AFPM Miles Krause via B4 Relay
<devnull+mileskrause5200.gmail.com@kernel.org> wrote:
>
> From: Miles Krause <mileskrause5200@gmail.com>
>
> The CALIBRATE flag is set when calibration begins and clears when it
> finishes. regmap_read_poll_timeout() stops when its condition becomes
> true, so the existing condition returns when calibration starts instead
> of waiting for it to finish.
>
> First wait for the flag to become set, then wait for it to clear before
> continuing with the soft reset. Use a 500 ms completion timeout to leave
> margin beyond the usual calibration time.
>
> Fixes: cbebf5addec1 ("Input: qt1050 - add Microchip AT42QT1050 support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260711024428.ED7FF1F000E9@smtp.kernel=
.org
> Signed-off-by: Miles Krause <mileskrause5200@gmail.com>
> ---
> Compile-tested on x86_64 with:
>
>   make O=3Dout allmodconfig
>   make O=3Dout W=3D1 drivers/input/keyboard/qt1050.o
>
> Sparse-tested with:
>
>   make O=3Dout-sparse allmodconfig
>   make O=3Dout-sparse C=3D1 CHECK=3Dsparse drivers/input/keyboard/qt1050.=
o
> ---
> Changes in v3:
> - Wait for calibration to start before waiting for completion.
> - Increase the calibration completion timeout to 500 ms.
> - Link to v2: https://patch.msgid.link/20260710-qt1050-calibration-status=
-bit-v2-1-a58da64bdf7e@gmail.com
>
> Changes in v2:
> - Invert the polling condition to wait for calibration to finish.
> - Reframe the change as a bug fix based on Sashiko's review.
> - Link to v1: https://patch.msgid.link/20260710-qt1050-calibration-status=
-bit-v1-1-e4f7d1d797b6@gmail.com
>
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> To: Rob Herring <robh@kernel.org>
> To: Marco Felsch <m.felsch@pengutronix.de>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/input/keyboard/qt1050.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1=
050.c
> index f9f480c91032..8cd061587302 100644
> --- a/drivers/input/keyboard/qt1050.c
> +++ b/drivers/input/keyboard/qt1050.c
> @@ -27,7 +27,8 @@
>  #define QT1050_FW_VERSION      0x01
>
>  /* Detection status */
> -#define QT1050_DET_STATUS      0x02
> +#define QT1050_DET_STATUS              0x02
> +#define QT1050_DET_STATUS_CALIBRATE    BIT(7)
>
>  /* Key status */
>  #define QT1050_KEY_STATUS      0x03
> @@ -498,9 +499,18 @@ static int qt1050_probe(struct i2c_client *client)
>                 return err;
>         }
>         err =3D regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, s=
tatus,
> -                                status >> 7 =3D=3D 1, 10000, 200000);
> +                                status & QT1050_DET_STATUS_CALIBRATE,
> +                                10000, 200000);
>         if (err) {
> -               dev_err(dev, "Calibration failed: %d\n", err);
> +               dev_err(dev, "Calibration did not start: %d\n", err);
> +               return err;
> +       }
> +
> +       err =3D regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, s=
tatus,
> +                                      !(status & QT1050_DET_STATUS_CALIB=
RATE),
> +                                10000, 500000);
> +       if (err) {
> +               dev_err(dev, "Calibration did not complete: %d\n", err);
>                 return err;
>         }
>
>
> ---
> base-commit: c8f174900926d3b58cd048ac33b4cbb3de419bfe
> change-id: 20260710-qt1050-calibration-status-bit-0b2e479ffd4b
>
> Best regards,
> --
> Miles Krause <mileskrause5200@gmail.com>
>
>
