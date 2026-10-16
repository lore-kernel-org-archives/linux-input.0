Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D12C0298
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120785; cv=none; b=S+fa4aYlkBvncspAGChHo6lYEM2CehLZ9Bm8Z+1iqoqfI1VDhbGOGkyhkmxHgknys76v/0eDH3JlcGoA3Zn88VpttitK4VQ9M96kUaQXg1GIGB3UPBPfBPEDYgusXHyLaM9kvh1NXcjk7jpg66UXJrNp3ViXJnJr3P6WWfaiMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120785; c=relaxed/simple;
	bh=LectKxnVPgl6kp2WA9jYepcXdH0Or/Oem/uGNpqc0Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe9oUIYUGBREWK+G3gvvdF6+FLHpsO9ei4ZuGltPqTkDaNKILrtZMy1ARJFmkMVZ2vDp0LSO+8k1acI26GRncGnASwCIvytUFU9h6LLK7dnaRrAlPq9LUaXyiwzOOViDn9dce/5+iR0on62Oww6ZCR+Z7VoLfiFfJx4mxJomhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg1ajv6k; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg1ajv6k"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1485672a91.2
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 20:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120784; x=1792725584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TOjkNOOOYODKC3hy+v06oUAuoKTO3qPUXNp5ApotnM=;
        b=Kg1ajv6kjU0Z6cZp3ZH8xseV3tBQbqf0kwH+M9ZHdiCPjZAEN6I4wLs1M7PaEZr9qm
         kGOg8iqybHR2ijRzXVm4AkdKalva+ynnn3wMxaFUXlcF58ltcPv2ETQNRIChI/69kZax
         gFTUD+tIpQPTa1EBY2owCxv4N/kCV1h/H61pRo/0v5ZnD6whQGXlcSaYRVj2QhrF7JMb
         ODxa4gJbvlEGRBMYUIjWE1kefdmaElTa9G9BSztApSJ5xn37LyL6aTIwjcSDzCHfPu/C
         jBZb3umQh2GTTFXERqqiJfSfhGY2C/Oke3I1Xo9HJyEpKJshLeLMa04Vt18OM4sxEO1o
         Sg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120784; x=1792725584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+TOjkNOOOYODKC3hy+v06oUAuoKTO3qPUXNp5ApotnM=;
        b=UN/p/qFxTrlPiNOwTIMeDemauszRrNbHAHbHLqxp+7Qt9UrA21F//v7/Sf6Kn1ULWf
         CvaIJ0ewP8pJ/SbFbVfxBSBVevYMv7aMj++yyyzFi3iULTQU+DjDJtcS1qkN9Rsrds6u
         Stg+ylEhDqa3EujuV0f3aWhzXfPGcYnglQHR1K0NCz8tIOamH6RjERafeq3HZpz1iUrJ
         Xl1yQXc7/DRL1LSXCDvqKFPdvIz+Frq8ArkJJbgp3UirSScZl+1oDdty+fUXS3jA9owW
         cbk1tDaWYsOMCUWEOVAMD5AZxJ5t1jxoNV7nJm3/auzXcbw40P+Mau+JS0UJ9vGiNneR
         GvHw==
X-Forwarded-Encrypted: i=1; AKwUvBx8MxL/pVXNKj1hQB9FwKVwA0wLuLhTsitODGRoSF46Id3TYLBI6+zaoC/bs4i7ZN5O1sugHUm4HNNcwA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL3cSVRs8TO/mm0JsUy4utjFTIM0AcCqte1fsAy6bBnIdm20c3A
	BuIZhCZl3+M9KYeTOMGKLXp9YClUaGyYWNu8jACZEIvmRJKxw1H8cB06
X-Gm-Gg: AYBFou3Cd+oaaHk5LoXwjpQBKXI5wc7aiTlVN87sTRCEMPfBHIzVHuavLzloydm12nT
	NKaMV2l6rrJHp608CQA75ycco0owhL9oAU7vCNAT5NsBSUFKDokU/bHj6a/4K78SGHVSGShe+1r
	oNVJcltBkUTPs0vc9k4iFWtddiYoyzWn05bcxnIP1X4hIlwnNmx8IDqkJGLnnhRLn1cPcCWOi6s
	sr0OT3N51LahzkHANeegCw9ZRRYS9Bjkc9/K4tSw0puMWnUjWZH+TwPcHYbRypxy5V67/EDnoXP
	3rAaRYYd01HL+TJ5DcvQwxZ+kvub1VCWJYAFqIf0WM+yzVUGL9dBTKIdF6WzVtN8THpR39rdt9+
	l5VicGQSKzjsY1NEQW6+gO63dtXdUwUQbCC2x2lP9oKTuMwQ8p1TKYl3Wvx9MvOwTk7/IZX9AF2
	uwEhjBnll6FhnNHSm1Jk/TCyUyM1N280bOcppcgL6Va59w+Z7BLYTCi4ux4nJ3TRVPIwKRCPI+d
	cLwyUPMmtwKnVil7baxL864inpDwlAmqqHkZQXSvFr7qFbKpMISuCRICkaJvhsw8E/8aCHAEqhK
	SPhensR6LOxBqnqo2ljalUq1bLmazqA3dkc=
X-Received: by 2002:a17:90a:d44d:b0:3aa:f4af:1e17 with SMTP id 98e67ed59e1d1-3ab3a9d6d17mr15840009a91.39.1792120783938;
        Thu, 15 Oct 2026 20:19:43 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([139.180.93.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ebe40sm1960144a91.6.2026.10.15.20.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:19:43 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: santroller: add driver for Santroller controllers
Date: Fri, 16 Oct 2026 16:19:37 +1300
Message-ID: <20261016031937.824565-1-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <sashiko-outbox-173648@kernel.org>
References: <20261016025403.779635-1-sanjay.govind9@gmail.com> <sashiko-outbox-173648@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Oct 2026 03:06:58 +0000, sashiko-bot@kernel.org wrote:
> > +	for (i = 0; i < SANTROLLER_NUM_PLAYER_LEDS; i++) {
> > +		if (sc->player_leds[i].brightness) {
> > +			player = i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	guard(spinlock_irqsave)(&sc->lock);
> > +
> > +	sc->player = player;
>
> Since the brightness array is read outside sc->lock, one thread might read a
> stale array, get preempted, and then overwrite the hardware state with an
> outdated player index after the other thread has updated the state. Moving
> the array read inside the lock would prevent this.

Agreed. The LED core only serialises writes to the same LED, so two
player LEDs can be set at once. I'll move the scan under the lock in
v2.

> In the driver core, dev_groups assigned to the driver structure are
> evaluated by device_add_groups() before the driver's probe() function is
> executed. Because hid_set_drvdata() is only called later inside
> santroller_probe(), drvdata is strictly NULL when this visibility check
> is performed. This causes it to return 0 and skip attribute creation.

This one is a false positive. really_probe() adds drv->dev_groups
after call_driver_probe() returns, so drvdata is already set when
is_visible runs. In testing the attribute is present on the gamepad
interfaces, and hidden on the configuration interface as intended.

> > +	scoped_guard(spinlock_irqsave, &sc->lock)
> > +		sc->output_enabled = true;
> > +
> > +	ret = hid_connect(hdev, HID_CONNECT_DEFAULT);
> > +	if (ret) {
> > +		hid_err(hdev, "failed to connect HID device: %d\n", ret);
> > +		goto err_stop_output;
> > +	}
>
> Does this mix goto-based error handling with scope-based cleanup?

The guard can't be jumped across here, but I'll move it into a
santroller_start_output() helper in v2 so probe only uses goto.

Thanks,
Sanjay
