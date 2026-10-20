Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522490;
	b=RZ8UA8t/iG08zbTyqNFD1zZqNDvrNz64WkwuefVPGRqDbDekPyrCg06RyVwmQf25L0EY
	 O1pjDJ7eQQ3R9uEsqn2wdCZiPlnz24BZrYHkiLIRsLm+Octw15LHF/TwHKCNOmRt8R3Mh
	 0afYc/f+ZHiZjIpviQgi8jbukNrrFj4VJ1Vpy17P33UimuJ604dKGpQryWD4xIbuXXsCn
	 1s792cpUj0SmcePn6RN+I23JgiLKkczTFjJQt/I8avohfZFa02h/xuOsslSQ8b/2oXOOO
	 l3HHg+2BIJNa8fIPas8tT2WsEThDHNMTKjWV9gPE2dQUULN35GWZbHONZ0sv4L7qrxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=a+YGUJeEL21flQxeJgEyROLOEEmxFMPwen0F3bt91wI=;
	b=kSTBP8ZHUIPWB3+ySaWkH7aMTfgr8K1xM1oNdNFCQDDVvvIzAaDSCwQm1AldNQq4Ka+1
	 KrjfTPSc7Mm4BwvKUn1ab5WWoKmQFM1VpapdDHZAxs/soPeOdhZXq7V63b6oYllLtcO3l
	 8HC5wGzp6SHr44PzWkQWm23GxNv/rC64uGJjx8b7eaaEyPxpvkVQPCZ5ohInyrOcRXXjm
	 DbNMKppAxTBzi33LaYMNKQWPJC7PkNUuj2S7oHJCoqNCuEPbqp3WNRVFYdnEztyKwdx9/
	 7Za79hDquqs19utWAwqyud1lGfOQKX6r6byOZAEmCtv1Bhi9GzlOI0fZ6iX731WoIiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cNpSjyVD;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8F606A31E
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 18:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF8F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cNpSjyVD
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35b2c599f43so1399756eec.0
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792522488; x=1793127288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a+YGUJeEL21flQxeJgEyROLOEEmxFMPwen0F3bt91wI=;
        b=cNpSjyVDxeZMqcqxOqB9EKCdiKtPdvBLoG6NwPB2ME90BEBUSoASCok3BTJCWRzmch
         pNWcgsLpP4PYDmJr8a0L4mKvc7JsdLL2H7n7kPI2wZkDtIaq0W1rRg/MY6hUM/gy5Uoy
         W+m7CWwruUbFTIYyqnOJmBOL0w946NXdRSpxe6jaOK0BT0sCvBvGsnj6H5fBmWcWNvLZ
         msrgSrE2dYQ/4jED9CbuOpHR4ZW8ZY384J9TEKtFsWkaRluoI3p5WBWwaKkqlP4+GRbQ
         U4HwE9gc512DhP6yTqnRZIiJQwgX36aA+yBDDi2k7JIy8yC1YZIs0MXwbGp1hJ1veg6G
         SECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792522488; x=1793127288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a+YGUJeEL21flQxeJgEyROLOEEmxFMPwen0F3bt91wI=;
        b=HsUG9gZKwax+8gJPgm/Ce3NkrIE8r2PzvIb4E5zkjpXaxkZUA5zTXkkZ6OficLkaza
         Fw3Yixdab2F9rXbIG5SqdQyf2FGvp2EHOMg1QQ2+MV3BhbgnoirIYHvKzJCIDtGHUzCW
         N8KM76WtE4i5m8vyaPb3d9f1O3LuLgdPQGSkqjd0EqwagPyaLt7puDyniwbyM6N68rFN
         GqqGsFZmfLdEOXbUQfsk8DyEjY6FL8oyOBXiTScFI9Q4sbbF5VyxlXbIJhOgqoSfih8M
         e0XW6zBdD5cE4RyG31aEMfuTnlsQG54avZvw9ZJODA0uRhGgvwydX0wzVv28jLru8bRx
         w5Vg==
X-Forwarded-Encrypted: i=1; AKwUvBx1mtJtTk3+5gYvfy+Xxuv7NBkP8JInRD8lQ1dO1FWKWFk1oPvFofJI7gvtU8SGI7kPLEMp+dIwXrU/FA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI26SRCg07/1e3JT71qM8yrOP0xo7V2G2otli25Vwm0qnRBAh3i
	t7gyq1yhGDMzqmAPcqOu9p+aFIwskkeR6GA9UAiouPxlBPp5kqcNpcGc
X-Gm-Gg: AYBFou23/JyEXDHzJw830sMxRd+5VhFVvSivz01KIGxhjJryYd9SoyxAeuR1JJevN3p
	1C2vxsPUOfDCp7mgyLmRq6klBu4OhBSLGAKk3u2ENjgBMDaZPZGZm1W72AsFl7KfBY6D0nTKcjg
	TwrnFFbh2AOgjhce8ZjMz6MU7GJBZIeNas3D7k9Wu9lcPDbDpF890fiNv1xoeMDBDFTlWMV+WaO
	poMDBX36BQwQ3IULm72bq/0u0G8u9bluQ1ztEW6MeGeueXlYrHxZSG5KxhMylUcIT285gatgYDn
	OVtjf9m36OxbzOjQtsesTsvoL6W/SOXlQPOXgoJo37draUAhHD6pohwLEv4bXpI1qWrJZn+EtpL
	gD0dpavT5MWgyQ1p1od8pvqI/OUCfJkUDO7d0sGp8onOc+RZkh9pXpmK4/eBrWasRqrrh0f0Qda
	uoAfEfbCjJ26sGgT9cBQC0DS/N0cubx8jIM7A0izNfvrY0aOB4OchkVBlfFgk4DNPtuNnsCq5GS
	GX/jMbWQRQtg8lSLp2X25rLBAh0r4d3P3YJ36Qs
X-Received: by 2002:a05:693c:6382:10b0:35c:de00:93d3 with SMTP id 5a478bee46e88-3674f6143a2mr134088eec.40.1792522488031;
        Tue, 20 Oct 2026 11:54:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ed2absm606896eec.5.2026.10.20.11.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:54:47 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:54:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
Message-ID: <ate3WJz8gg9LUG9u@google.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-5-clamor95@gmail.com>
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
In-Reply-To: <20261019100406.103687-5-clamor95@gmail.com>

On Mon, Oct 19, 2026 at 01:04:03PM +0300, Svyatoslav Ryhel wrote:
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Add support for multimedia top button row of ASUS Transformer's Mobile
> Dock keyboard. Driver is made that function keys (F1-F12) are used by
> default which suits average Linux use better and with pressing
> ScreenLock + AltGr function keys layout is switched to multimedia keys.
> Only Dock keyboard input events are tracked for AltGr pressing.
> 
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> +
> +static void asus_ec_keys_setup_keymap(struct asus_ec_keys_data *priv)
> +{
> +	struct input_dev *dev = priv->xidev;
> +	unsigned int i;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(priv->keymap) < ARRAY_SIZE(asus_ec_dock_ext_keys));
> +
> +	dev->keycode = priv->keymap;
> +	dev->keycodesize = sizeof(*priv->keymap);
> +	dev->keycodemax = ARRAY_SIZE(priv->keymap);
> +
> +	input_set_capability(dev, EV_MSC, MSC_SCAN);
> +	input_set_capability(dev, EV_KEY, KEY_UNKNOWN);
> +
> +	for (i = 0; i < ARRAY_SIZE(asus_ec_dock_ext_keys); i++) {
> +		unsigned int code = asus_ec_dock_ext_keys[i];
> +
> +		if (!code)
> +			continue;

Nit: this check is not needed, input core will remove KEY_RESERVED (0)
from the keybit when device is registered.

> +
> +		__set_bit(code, dev->keybit);
> +		priv->keymap[i] = code;
> +	}
> +}
> +
> +static int asus_ec_keys_probe(struct platform_device *pdev)
> +{
> +	struct i2c_client *parent = to_i2c_client(pdev->dev.parent);
> +	struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct asus_ec_keys_data *priv;
> +	int error;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +	priv->ec = ec;
> +
> +	priv->xidev = devm_input_allocate_device(dev);
> +	if (!priv->xidev)
> +		return -ENOMEM;
> +
> +	priv->xidev->name = devm_kasprintf(dev, GFP_KERNEL, "%s Keyboard Ext",
> +					   ec->model);
> +	priv->xidev->phys = devm_kasprintf(dev, GFP_KERNEL, "i2c-%u-%04x",
> +					   i2c_adapter_id(parent->adapter),
> +					   parent->addr);
> +
> +	if (!priv->xidev->name || !priv->xidev->phys)
> +		return -ENOMEM;
> +
> +	asus_ec_keys_setup_keymap(priv);
> +
> +	error = input_register_device(priv->xidev);
> +	if (error)
> +		return dev_err_probe(dev, error,
> +				     "failed to register extension keys\n");
> +
> +	priv->nb.notifier_call = asus_ec_keys_notify;
> +
> +	error = blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
> +	if (error)
> +		return error;
> +
> +	ec->ext_keys_enabled = true;

I think this block (after input_register_device()) can go into open()
method for the input device.

> +
> +	return 0;
> +}
> +
> +static void asus_ec_keys_remove(struct platform_device *pdev)
> +{
> +	struct asus_ec_keys_data *priv = platform_get_drvdata(pdev);
> +	struct asusec_core *ec = priv->ec;
> +
> +	ec->ext_keys_enabled = false;
> +	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);

And this into close().

Thanks.

-- 
Dmitry
