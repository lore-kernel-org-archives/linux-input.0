Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523051;
	b=UPSHkcGaQnxl2Z0qNn8e6qWtDBbSPMChrqLl7ceh8BPk9ioILJqYxkM3mdc6K7HV3t8z
	 qNrCayfIP2VxTkN91ahHCBBP7O4ucMr2bYSpB5XFJ74UVYBgbGf7M4aGs1X2+KlD1MKJs
	 qc8Jl5MsnKgAL+kE6QSgauvfre+11Y88P+AvXMrc7XJ+KMROsvhBFdtJL4TgBnBj5/gxG
	 Lfe5PmwYEkSLFYtR5cYLy9U47Mmhc0t4N0GT95/q8d4W4RTRWoF5YH2t+kmpajW9lEOcH
	 o4baJ8tFQXtUeCvonfSXs1kIXzAinKPo2Tx/2wXPTKeHnOUe85HmauYX0T5B/p76/Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=7NqznRIlKLn/pELhTMEco0REzkh4v7wlCaqZptITogI=;
	b=FkKAx3QAqfoqNoyvlL2nuEtTTj3oAewCV6QOWRc46J3D2X/wqN5wQd0WsRB06CLiO7Fu
	 pFkEXpmjI/qyJdO/C4ABu9gxLUX3S3+MgLBJzzEXceIEelKCqu3kLqTLPLRdOK+t38Rj8
	 zx24tOaDsyYxtN15nL8gelBQlKT341LLP4WOPsVu944T5kBx65f2tjHACZEJLN+7AI7oR
	 r7PqLk2JGaixKS9iT1sSHPrACaTXHxU69YkYL7Aq7yNMqZCdOS7ZB+udZn+hyH3l+YzDf
	 JBkH/oGJFHfXWkkaSta25dJFgJhsuXBMwtqHG3Pf5KxO4GWsqBL+GlmMqVUWM/TDCDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLr4Pt+J;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC75606A31A
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 19:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC75606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLr4Pt+J
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-17bc533fda3so4292656c88.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792523050; x=1793127850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7NqznRIlKLn/pELhTMEco0REzkh4v7wlCaqZptITogI=;
        b=hLr4Pt+JNnJwfVdSIiwSzVwN2M1EdektMGoj8qGvTIg2MHi43g6P3LOjqDktLIrXJc
         /LbjGbnm0fv1Cio5pJKxGcmBKzdvQ1Bf8jSuV8V5JJip79CY3ECKV2x7PotCCn1kvzCQ
         4YaZ8G9IpdE+7Ow3oYO6+adNmYfrSPrPRZiHksLbJk7N1fryAL33UOp5jSq6Nup2ngpH
         wOl0+Aik0n+dpNKqrXJHKnb8BU2rkXjhhP8rhu7nQdn7ktiO6XlCo5a1Jmr294bKdHsr
         TPkfN5DqX8YEfDV0yTlKP0LpctSqRfqyj58P+bLiOitnTlcAmXRX4sdFHQMGgmS5yS9g
         opWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523050; x=1793127850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7NqznRIlKLn/pELhTMEco0REzkh4v7wlCaqZptITogI=;
        b=Rk83x9o5vAAQ2FQVKaWrP0aACvKz4bpusMq2VbfKjtJvp0RspaNZfx9C4i6LqU2H1y
         zFs3WhY2hHh95UTuaJnJwalQWYFbJRbjBXTMoZfbc/Fo9ZuPtkwl/O4WG9gPIy4H202n
         XmOpmksaAoDdPAyGwuPORpckS+4lCNcQvyPAYm0y5HqblxYKidPcCLFepoNBsVEW9FN+
         QC/qiJs4zD7er3deiMdJe0afonPlJwWrg4UJWldcwZOZLxHZYdBftPyzpgmRaIWQiMd7
         MisgtiRGNKi9lx8OPQ92SDB328Q0RbqY/0/OyUPP4524neeuWT5plW2xMWAlteFMBD4g
         PGnA==
X-Forwarded-Encrypted: i=1; AKwUvBxPS7sJSZRL3b9VXylwmvuEPs8Zb0WLzfVMiNaO+1SQNqSbOcFeVHRU4aWCHWb4l4ADj/w0LTJ+XhBiRQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJbMHSehGsB4zMVMHoCeJ9fnaAxM67FcMarcJOu1sac6uFQ1AAK
	Fibmm8cO276keR8UzqgTA2cVp+bxUnKk5FD/2Sx+DTuIPkM7vgHLO7FqTq34aw==
X-Gm-Gg: AYBFou0ZaEuRK9ftTw1cGZyYlOllRJpZ7S86tUYHyDmCG9r/5ym4EQcCpn9I4/sjjqX
	6LLWDxpeJ2v1FiVf/rdAymwoLiWkyvwAo2p4yBepFEL4/Prs9MppxfTt5WneIjKcDS4z+Yqjhr0
	MGLXJ84S4ohGbfATRiP3TMLpECOiooaqQhYd/+WeG7ITVDm/BDOrBfA//2tTaUYkxJK0T8NRewA
	A0z6peZN3qefZnKZd99c201V5efkooKixBtLMFXXft53A/U9HeAgOUQQiGovuLy90TQ7iY5rNuQ
	RS0o5EY3QpsZj3JhxXF4pD7X4nK3YG7rOoOodE3+2tQcYEMdeLtgdZMlsxXU1BVrugSK+06oEQX
	MaHxpfBVDj5xalUDV03HvpDQCoyZERRysZuXifN8A5A1Z6hbfkPbZJdnybX4ecCTEMCh4ptChfY
	9LpCKAJ2/UDEGizMutUfLm9nOJnyOTwFXpVGRn9CPzTbnFmF1u/xZdivM0dwVeDGvM1CTYFt2Dg
	KITrXwx1CqTAQfNhXLPbkNju2rs58yWZ0xT92e29dJkMO2z3PY=
X-Received: by 2002:a05:7022:e804:b0:13b:3132:6e99 with SMTP id a92af1059eb24-18512c38164mr17695167c88.20.1792523049985;
        Tue, 20 Oct 2026 12:04:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903aefe90asm552320c88.9.2026.10.20.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:04:09 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:04:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
Message-ID: <ate5K6ZdrSoBUI08@google.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-4-clamor95@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019100406.103687-4-clamor95@gmail.com>

On Mon, Oct 19, 2026 at 01:04:02PM +0300, Svyatoslav Ryhel wrote:
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Add input driver for ASUS Transformer dock keyboard and touchpad.
> 
> Some keys in ASUS Dock report keycodes that don't make sense according to
> their position, this patch modifies the incoming data that is sent to
> serio to send proper scancodes.
> 
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> +static int asus_ec_kbc_probe(struct platform_device *pdev)
> +{
> +	struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct asus_ec_kbc_data *priv;
> +	int error;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->ec = ec;
> +	priv->parent = to_i2c_client(pdev->dev.parent);
> +
> +	error = asus_ec_register_serio(pdev, 0, "Keyboard", 0);
> +	if (error)
> +		return error;
> +
> +	error = asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEND);
> +	if (error)
> +		return error;
> +
> +	priv->nb.notifier_call = asus_ec_kbc_notify;
> +
> +	error = blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "failed to register blocking notifier chain");

I think sashiko is right that we need to register the notifier first,
and in it check if serio ports are ready/registered or not. For that we
probably need a lock and set pointers or flags in serio's start()/stop()
or open()/close() methods.

This can be done as a followup I think.

Thanks.

-- 
Dmitry
