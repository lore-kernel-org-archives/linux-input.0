Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938423C1086
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831513; cv=none; b=OfasYkhyv+O7jgRHDO2BPtwv0UNH1zS6QbdtRMs7Lp9vEnIzlJx3LgHCmsaSz8kCQWUEoWfA7FMbVcf+TCZCjI91NgLgPrivA2r5kjfAa6TfsrCEXoRzdLynuavjQbZYkEdPeCvzikgqzVg9C8PTkKwEAfyyUF6V1OK5VxxPYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831513; c=relaxed/simple;
	bh=NBSMnbPM1W36hu/yHVHtW29ZlumpRPrEdi13YOl8g8g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=YnLPBvVJECTSynH++68DRlBz97uVf+vSHQBzkOKUXEQeTUSs4BfcRCgXT5FfspN2LoGdeKewv8yPD2NIhjteOzauZsD4ARjWBBIAUU0gcICiHvfcbJeBssnUKBYPRBLZ1MFCtyD8znvtg4idoLOXEo39qqHNlLkrA551JnDBgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgTJFtvg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgTJFtvg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c33bb2f3e6cso252616666b.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791831511; x=1792436311; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEpxS2BqSJXJl5+I6AvkY7ywhTC6yC4LVyF9hL1MSqo=;
        b=TgTJFtvgl3933XLabcoNzo57A2oyy0ZPYzrFZY85SskmoE8/AuClWWQr7xKRW5Hq1w
         XORCAmTl/Ftc3yr1uwv7YMLzbDcHm17aKMbSqOjs85rOby+252ZVkFEx8nBP06QXPJPA
         Kc4guISjtpB4PCEQQjZ0amZ/WjG7VeeM/SpkKTxc718mqEEJSfxo1ZZPYN8n+JyAtE9R
         ntTXrCf1DfIhjdSMFMoYCbEC8Egub3NDIifUUYE6eS0wferEGotXUotwNpya2HRA5k8G
         l9niSDbxX5dM4n1O8PmWvVBzbm0lgKFLNraeb2lLQSoc3Hb5vGQbAgMy1Jadw/yqM676
         O6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831511; x=1792436311;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEpxS2BqSJXJl5+I6AvkY7ywhTC6yC4LVyF9hL1MSqo=;
        b=OTl7kwue3Npwb3wd9oIIcEECTjPgzOyt+qK/YvEAKDO6Oaf80RO0wx7WpfUPXcQH5l
         NjGU1DWdct/MpVcBg3g9QVFMFEkb2YvO7LzPRkCiizz7ogQoEh/JMYHfHanwM+j9OtC9
         KOxZ+e+wdRHew1GG3PohiKICztyRzwpOaV4tEA89OYIXoUGblx29vOk7bJ9TiHoE3VXF
         Xdd5zNeuJq7zyW8xvxQRn4lifAS77W+qdb0iQkam9THymW4mJxpuTxQ8sXizfcaKZR0U
         VbcUiGVeq9yfz6NFz5FzAggo9V9iEqOP4hiQ/hnMs7V6p/vpjppXUKQ5WIVCIkMzEZ/s
         9Pxw==
X-Forwarded-Encrypted: i=1; AKwUvBwTn9a080A/1oK9YlC20DTmp7aKuHCvghWyvIwlJorAo6Da7ghiG329vcqwCcOGC7aACRCyBIc5S/mVwA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIR5pKSSV4A+MvmF0wpJDnTWUqOUcQu4MCV/ylP42PyGwSkjpuo
	V7u4Lkxt4J8xVU+2DS+WexcPoYjWmVTZRdJ9LTnL5H08LUux/GstkGJG
X-Gm-Gg: AYBFou35HwRIvrUr8q9oV7V6bYhECwPjXr1KB8QsD4WvqcZ+bcuABt/Q3HCBY/Y2qWd
	UCWOzlWLJlE+t4XbLSDQuJ31KOfCsrXmwhSmSq04UPP40/G8R0H9dlrVqHj37eBfSoSImqJb0bI
	PKJsjm8aJADbXhv1a/ipUc0syjFgPVTjpxRPKJmrcS9Q7EYruX2WN3qfogEJ+mwSRvr58H+8eyo
	KXYx4fFfbvnNwB86TX3jg8tNAsdj30+HTKAjg7wAne+l0BZzX0wPMH8pF0Wmt/05RKkKySd8471
	FDlhYQRrR6gkhzXlVPfvuHaiQwZKejkVaGSk1+mQQ4CRnVfwb6ufpfA2Yxm50Xhy7S3qVL5zccy
	UETM/GFdjTa1JekbPpzGo0PfRuC14lpR6c93tiWcRtr1xxreNR91dUWTyGHMShFv9YkDwIJ2+C/
	pLAWN5MGoJqxhu46suEGhPBPARjf1mrvnFacG4a0Bj2/evdHsGl+7h10w70gb98JZM
X-Received: by 2002:a17:906:4786:b0:c2e:513a:e964 with SMTP id a640c23a62f3a-c31aa0e1b8emr1079340166b.49.1791831510652;
        Mon, 12 Oct 2026 11:58:30 -0700 (PDT)
Received: from localhost ([46.205.201.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ae4a94sm499682466b.82.2026.10.12.11.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 11:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 20:58:28 +0200
Message-Id: <DM339BDR8JE2.1FJ5827JZIBWD@gmail.com>
Subject: Re: [PATCH v4 4/5] Input: hynitron-cst816x: time out gesture key
 release
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
To: "Daniel Golle" <daniel@makrotopia.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1791233147.git.daniel@makrotopia.org>
 <d73d26d8c9d75fa230e3dd64058acb65f45da64d.1791233147.git.daniel@makrotopia.org>
In-Reply-To: <d73d26d8c9d75fa230e3dd64058acb65f45da64d.1791233147.git.daniel@makrotopia.org>

On Mon Oct 5, 2026 at 11:12 PM CEST, Daniel Golle wrote:
> The controller reports a gesture code once and can then stay quiet
> until the next touch, which leaves the gesture key pressed for as long
> as the panel is left alone. Release the gesture keys 40 ms after the
> last report that carried a gesture code, so that the release comes
> from whichever happens first, the timeout or a report without a
> gesture code. The 40 ms matches TSC200X_PENUP_TIME_MS, chosen there
> for the same want of a lift event from the controller, and has to stay
> above the interval between consecutive reports of a held gesture.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v4: follow the keycode lookup and the single read of patch 3
> v3: use timer_shutdown_sync() in the devres teardown action
>     (Sashiko AI review)
> v2: skip the release when the interrupt handler re-armed the timer
>     while the timer callback waited for the lock (Sashiko AI review)
>
>  drivers/input/touchscreen/hynitron-cst816x.c | 52 ++++++++++++++++++--
>  1 file changed, 49 insertions(+), 3 deletions(-)
>

Tested on Raspberry Pi 4B with CST816S panel.
Reported coordinates and gestures are valid.

Thank you!

Tested-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
