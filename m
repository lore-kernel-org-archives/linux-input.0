Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793706876;
	b=1hFUqGi31P+8lg/aSzruPV+szXFILc2o/uJLL+pnQtbqlmsPRb4IlnDCcVLVehNEW6Y4
	 jtpwWT3st+97IYMi9BdTsi6GiI6HDA+AKUZKlureQ9HU4YWx0Mg1VqBH2dhZ76MnmSo1+
	 NwOresHcZZN1xXb9qoyCo1wmSWfEL4QHnV/DjxmzQ1mctPUCuIHBIxozNTP5RldlW/7S8
	 Hz6GM3b0YM5n4JOG8Rr5tKFmfxrmDeEb5oKn3bEqAVvibEJP42tSrAQwrMGLgm1sVCs8w
	 wlpVOcMW6JkpotWmfOVojykq70qI7MUxF+7/wP6l9XbdBK1b4QRcaPZ51VWOsGaALyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PM2HHelgPkDOM09SC4y+B9wXuK/MgDDM2iHXZ32cbZI=;
	b=1fxl79w3n7OuNrWrYp3UK0o1WMsrbxRbUYKoEjhtBFWrqXr206BAOb7hmhCQDmKL4goD
	 Qj+Y9jo3fT3YS7+t/FBRmw8r2SM9iHmFrixUuMX1CZDnIuDSFOIxsE+3Lh6U52hdf2dy/
	 eoiI3Qvteqb6igboZnR7xLT/tn+/GUr7mYOPrQ+BwKLv+vYIe3V2ohC930cml8g/OA1sU
	 2aBFWrmxgR0IniqG777Brd8u5vJJII66oPGFyqa3yHrmnfQAux01PRC1HcJCj3+b687jQ
	 72cV4exUAF8+VDsWG+STaj9O7l61rZUAJEXXO+RvCZD+ABFa1iHWjuPNV65IOppmQZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qQm/Q4zd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B5606A32C
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 11:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 932B5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qQm/Q4zd
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a18fc7a38so7737980eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 03:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793706875; cv=none;
        d=google.com; s=arc-20260327;
        b=Tgtu8YDNNUib1y6+DoG7qjGeI6oBNZN2tW5PJ2Z7JiSy8Kuscl1AzWQrKT41z6wTkl
         ie8Mu8kQECY0qDfh4ORsr1xl3P2hypJot+vUvgcqLUphm1SyFoBO7SM3P9ehHMiArony
         S/VXvzIWX/SsAeL12N0wCkr0AFdlwXbiir7yNrqxZUXxpdrE85+G6Xkj3NaqMmZYDOFx
         u61ld6O6QeYG9ELKLl+R93u9VK7iP7jVE4oeHD0ZsP0j7QyaXxBfopO0iduBEtRMeRtd
         f3Vd02pktEgrjy3HZ32nZGRihi1JAaE2Fbz5wGaEkcGZS6T1xJREQA/2NGsvqeJLmG+Z
         OpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PM2HHelgPkDOM09SC4y+B9wXuK/MgDDM2iHXZ32cbZI=;
        fh=hlyieHPsHkyT0HV4ne4W+Rdq2CNNYGRWnFUQXtP7yAQ=;
        b=IvIcp6vVc7dxqTY2Og5SFyJdgjZt0buVVD4Yr1SRWj+EtHJnqdoqmtAB0fvq0PwJNz
         PY40XALWX1SeL4/T7/JBJzeywM5maNqawO2KHv98cgyjsU0kkdKzDt/K+RIxy/PSant8
         1q0cHIrhLOeqcZrzqaC7w/UBJsdG2558IDo2Mdlwj6Ue/ft0/kWJwe1+FDylDMvfvP7H
         KcwEQpRK5lISiD6RtoprqZYsFl8ynRCKolDX+OPh1JOx6TgcUGHYXy0UqTtrfmeuiLku
         bzK76bsJEmShTZmee6jWEVV1LrQqh6KiiengKiLlpiuUo1UeiCWxq1akaV4IOGzQrt1o
         OEAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793706875; x=1794311675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PM2HHelgPkDOM09SC4y+B9wXuK/MgDDM2iHXZ32cbZI=;
        b=qQm/Q4zdJbAlItC8UuvQ+8FfXaJFfm/NaZyW2t8V7HiPJEKXbovYvJ8FlSKOYPQzug
         TMQwR+l+fPsCp3XP1Op2y+Qv0iA/q15TknDuAj/NpPmvPkR4N+AV3cQfzpEYsH+JrxUy
         bFS5wTy51SMkeVcDuCWAodPmxGIZStcEj84qOUhHRPfMiRphAe3I+LQSjW8sqo3Ygqb3
         uoAeQpSBP9Om9O0c7AT0NOhUHnYfWIBPyRrlE+wOA6ZtwackoIwwbqMj1iFXJGD8b3UR
         NnV18AIBEP7qZVCP+Pbc12ueclU7V6Z+P0gOUZEVIbgkJ/jZG785JkwfYy3WdWnQl4Gh
         /Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706875; x=1794311675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PM2HHelgPkDOM09SC4y+B9wXuK/MgDDM2iHXZ32cbZI=;
        b=wfbv4zcDM+rSefZAf76kNPnvU+YaThX881o4Y1Yw/+oDPaprpTLw2Wnp/Voc7Ez23i
         idqMq6mW7p6NrKiR3jPuZObmoAnkzn6RHRkHz0AABVjrB4OgrI6RLRe3TVQ5o8SkCicx
         IPDoTeA4/LmMbSKGVHJSy7ZnYSthmjfgu50bTDoQ1qPOyXLtRr6fo3WWE6lCKZFhQpbS
         0+l8G1+mT3nmQgsqr2nrzP9rjOncmf4Oay9e7vC95c0dWxU05Y977yj/IAOOuS6hs+BK
         /zCy+2wYOlrjRm+g17XD1OeMhzXJSMfCEggkbugEgcY0hMFfo1dt2csWRHJPEh31yVeV
         Pqmw==
X-Forwarded-Encrypted: i=1; AKwUvBxgs57iF3m4+3j+pVoFKrVdJURP++OurYBjnmfr4RTjhklMMKDDTCrpqYCdacGKIY5qwqHlsnFSI6w0Pw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZGz4iupoNbPbH71Cu5tZ+Y70Sv5ZA/sF+QXz7Qvtn52Ajw+LS
	cWBsMkIf8GqECoTmSMFYZUEfPf8jpW0Y4c5KPx/Nut/vMj62k2icvwb0RY5CDJ/lcs8UyCaPyyn
	0QOKXhbGPymn0mxWll1dq2NxSvjWKYrikgpgS
X-Gm-Gg: AYBFou1QpLGXEbLwk+juK/mk/hSPvEqHzziFs50mf0hoFUmqc/ng7X7rBSarjcURAPK
	aGa4TyJCaUH9Whznl9IiCh0+EPcbBPHY+mHIJalRjD7J4rIVZDi+lDFmsMvimeEaMXSFRvO6bB4
	iGgpT1uGv22C2ErxwIR7jtED550iDHQwhjkfrRyaRxdxVFhqyhw99/FQ5dK9fSZfbCYuAvcrbBw
	Ki3WZ9dJS2O60tEPHqbCvVk6zG41AuDYLN8lvB9ujXctlj8rEZHd/zDTmg4cPNNGpNqz6Mr8dhy
	2/EvfInOrStTXYOwnwhDSN3t3bho1DQxdmc52WLyxLU7+LQpUAdeVU6drMXQjNcc9mbR5QHxl6D
	mWt+bP72QGsktf+Cnmp8qGl8YdBp/7+JmiNdhblA630xBrM59tWxbq7G4XQJ7hDKcK6/h1A==
X-Received: by 2002:a05:693c:6381:20b0:36a:1d6a:596b with SMTP id
 5a478bee46e88-36a42412f55mr21504309eec.29.1793706874612; Tue, 03 Nov 2026
 03:54:34 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019100406.103687-1-clamor95@gmail.com> <20261019100406.103687-3-clamor95@gmail.com>
 <179249578293.1833288.15514260998480602004@kernel.org>
In-Reply-To: <179249578293.1833288.15514260998480602004@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Nov 2026 13:54:22 +0200
X-Gm-Features: AclHuK9k-JPaNaa2w2wyQuHafuZvZgRRQXAbt-BGJRbzly4wj0XcizvF3rWabus
Message-ID: <CAPVz0n0kKRpOsUNxvUKiTPSY7bF3h+ruV05B+9jSvs9NOxthkg@mail.gmail.com>
Subject: Re: [PATCH v12 2/7] mfd: Add driver for ASUS Transformer embedded controller
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 3 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:43=
 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> --- checkpatch.pl (4 issues) ---
> Line 607: WARNING: DT compatible string "asus,sl101-ec-dock" appears un-d=
ocumented -- check ./Documentation/devicetree/bindings/
> Line 610: WARNING: DT compatible string "asus,tf101-ec-dock" appears un-d=
ocumented -- check ./Documentation/devicetree/bindings/
> Line 613: WARNING: DT compatible string "asus,tf201-ec-pad" appears un-do=
cumented -- check ./Documentation/devicetree/bindings/
> Line 616: WARNING: DT compatible string "asus,tf600t-ec-pad" appears un-d=
ocumented -- check ./Documentation/devicetree/bindings/
> ----------------------------------
>
> On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> > TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
> > and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> > detection and common operations for EC's functions.
> >
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/mfd/Kconfig                     |  16 +
> >  drivers/mfd/Makefile                    |   1 +
> >  drivers/mfd/asus-transformer-ec.c       | 569 ++++++++++++++++++++++++
> >  include/linux/mfd/asus-transformer-ec.h | 100 +++++
> >  4 files changed, 686 insertions(+)
> >  create mode 100644 drivers/mfd/asus-transformer-ec.c
> >  create mode 100644 include/linux/mfd/asus-transformer-ec.h
>
> [...]
>
> > +static int asus_ec_reset(struct asus_ec_data *ddata)
> > +{
> > +     int retry, ret;
> > +
> > +     guard(mutex)(&ddata->ecreq_lock);
> > +
> > +     for (retry =3D 0; retry < ASUSEC_RETRY_MAX; retry++) {
>
> As mentioned on v8, 'for (int retry =3D 0; ...)' is generally preferred f=
or
> throw-away loop variables.
>

I must have overlooked this, appologies.

> > +             ret =3D i2c_smbus_write_word_data(ddata->client, ASUSEC_W=
RITE_BUF,
> > +                                             ASUSEC_RESET);
> > +             if (!ret)
> > +                     return 0;
> > +
> > +             msleep(ASUSEC_ACCESS_TIMEOUT);
> > +     }
> > +
> > +     return ret;
> > +}
>
> [...]
>
> > +static int asus_ec_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct asus_ec_data *ddata;
> > +     const struct mfd_cell *cells;
> > +     unsigned int num_cells;
> > +     unsigned long irqflags;
> > +     int ret;
> > +
> > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_=
BLOCK))
> > +             return dev_err_probe(dev, -ENXIO,
> > +                     "I2C bus is missing required SMBus block mode sup=
port\n");
> > +
> > +     ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > +     if (!ddata)
> > +             return -ENOMEM;
> > +
> > +     ddata->info =3D device_get_match_data(dev);
> > +     if (!ddata->info)
> > +             return -ENODEV;
> > +
> > +     switch (ddata->info->variant) {
> > +     case ASUSEC_SL101_DOCK:
> > +             cells =3D asus_ec_sl101_dock_mfd_devices;
> > +             num_cells =3D ARRAY_SIZE(asus_ec_sl101_dock_mfd_devices);
> > +             break;
> > +     case ASUSEC_TF101_DOCK:
> > +             cells =3D asus_ec_tf101_dock_mfd_devices;
> > +             num_cells =3D ARRAY_SIZE(asus_ec_tf101_dock_mfd_devices);
> > +             break;
> > +     case ASUSEC_TF201_PAD:
> > +             cells =3D asus_ec_tf201_pad_mfd_devices;
> > +             num_cells =3D ARRAY_SIZE(asus_ec_tf201_pad_mfd_devices);
> > +             break;
> > +     case ASUSEC_TF600T_PAD:
> > +             cells =3D asus_ec_tf600t_pad_mfd_devices;
> > +             num_cells =3D ARRAY_SIZE(asus_ec_tf600t_pad_mfd_devices);
> > +             break;
> > +     default:
> > +             return dev_err_probe(dev, -EINVAL,
> > +                                  "unknown device variant %d\n",
> > +                                  ddata->info->variant);
> > +     }
> > +
> > +     i2c_set_clientdata(client, ddata);
> > +     ddata->client =3D client;
> > +
> > +     ddata->ec.dockram =3D devm_asus_dockram_get(dev);
> > +     if (IS_ERR(ddata->ec.dockram))
> > +             return dev_err_probe(dev, PTR_ERR(ddata->ec.dockram),
> > +                                  "failed to get dockram\n");
> > +
> > +     ddata->ecreq_gpio =3D devm_gpiod_get(dev, "request", GPIOD_OUT_LO=
W);
> > +     if (IS_ERR(ddata->ecreq_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(ddata->ecreq_gpio),
> > +                                  "failed to get EC request GPIO\n");
> > +
> > +     BLOCKING_INIT_NOTIFIER_HEAD(&ddata->ec.notify_list);
> > +     mutex_init(&ddata->ecreq_lock);
> > +
> > +     asus_ec_signal_request(ddata);
> > +
> > +     ret =3D asus_ec_detect(ddata);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to detect EC versi=
on\n");
> > +
> > +     ret =3D asus_ec_init(ddata);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to init EC\n");
> > +
> > +     /*
> > +      * Systems using device tree should set up interrupt via DTS,
> > +      * the rest will use the default low interrupt.
> > +      */
> > +     irqflags =3D dev->of_node ? 0 : IRQF_TRIGGER_LOW;
> > +
> > +     ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> > +                                     &asus_ec_interrupt,
> > +                                     IRQF_ONESHOT | irqflags,
> > +                                     client->name, ddata);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to register IRQ\n"=
);
> > +
> > +     /* Parent I2C controller uses DMA, ASUS EC and child devices do n=
ot */
> > +     client->dev.coherent_dma_mask =3D 0;
> > +     client->dev.dma_mask =3D &client->dev.coherent_dma_mask;
> > +
> > +     return devm_mfd_add_devices(dev, 0, cells, num_cells, NULL, 0, NU=
LL);
>
> Why not use 'PLATFORM_DEVID_NONE' or 'PLATFORM_DEVID_AUTO' here instead o=
f a raw
> '0' and hard-coded cell IDs in 'asus_ec_tf101_dock_mfd_devices'?
>

There can be more then 1 EC in the tablet. PLATFORM_DEVID_NONE will
not work in this case and PLATFORM_DEVID_AUTO should work, but one of
EC is detachable (dock one) so devices there may need a fixed id. I
can test if PLATFORM_DEVID_AUTO works, but may this be sent as a
followup?

> > +}
>
> --
> Lee Jones
