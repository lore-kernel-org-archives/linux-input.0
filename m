Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780997;
	b=R1iX1xsuOqEZ/Hn60JFSsnCN5B7t1e5XIy84/WW7GAv2C8GDyLsLGlqJeqzV1+TRAbAT
	 uzcPgFoQtyHdGvaEOEqeU7zD4Om+kabZoI5U0CV/ALdvN4cz1vtRn1APwFXCcqXdmuzD1
	 lKpA3Kxe2IFnq6Oa4N8i1Lp3nVDUDkYGxldRIiUJcBA12nwIQau64fXDmFwrbgzoaKE9p
	 BK0qGAOzcES/BKyt+JBqEz4dYNY7Y+jicdr3MjAHdh2ZFuW1qp0nDmDWCxEbwME60BGUD
	 nLR2AEtDOAu1vdowqrPjQcbFuEqkiIz4LWgiBtzJM8YBcdlZMhsRziC8wydln5WvtYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780997;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=A2oR25TfAqFTRaq2T50egnRcA+A2fhTzaJZw6MyR7fY=;
	b=Mh5UBUkFu0allqqOUq9dOU4KwS7ZhSPNd2FQRq9SG5/xR7m6+IjjHVvqGX+MnXOQ6VkF
	 nkBVGOGm7A1sjGHldnq6DZiyHTiVxYQZs4BisJ5LM/3PbmnE5UcGZLgwAWaok4BlRMDKZ
	 mv0/Pv5eDTfVg/NubkG2TG+TvxBRCP1d5DRzy7sXuxZWou8DwTLN9/7FHtX0e3hgFi0BX
	 Y6uKDflNJ0oM0mDAwP3KUV1na1on+nR0SGwTGxkl/EojUgjN80zB1WTOe0TWvdruUjvm4
	 n1RrxHdVOE9UOuMProre2tFORedSl8S5IU9RVPcJgys9EEMuV4M5SaZa12dLaCaFOfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnOvNSwY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A6606A31B;
	Wed,  4 Nov 2026 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnOvNSwY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55991F00A17;
	Wed,  4 Nov 2026 08:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780996;
	bh=A2oR25TfAqFTRaq2T50egnRcA+A2fhTzaJZw6MyR7fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mnOvNSwYaqxGjYEZY0u20DCToR0tXCXUuSGprnItmV40Y09dW+2rmM8FHVDNem7m8
	 Erniu4bTUbk6sSYKeKi9eo9JhEkjYMOTis3GRs00/SnBlEczHjo+h2SkvyIC8fQagi
	 HKYdANYqE8MF4oQswh2LM0rQJ2CJVCctx2QAyc4aO03hsSeq2jgbBPM2voVbk13Jop
	 Jcd86e0wf8UqhxvujHfPlndX75Dav3rMzl/lyeFNViP6hHH33SAhaeE/5wPp6U3OMc
	 LNyoHdsjt1L2u8JmLAzc4pK7D0u0eO7oQPWMe2Cr185ib0YcTfCsDF7Efi2QZsZncF
	 zEuIm1eabnxdw==
Date: Wed, 4 Nov 2026 08:29:51 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, mfd@lists.linux.dev,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Message-ID: <20261104082951.GE792264@google.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-3-clamor95@gmail.com>
 <179249578293.1833288.15514260998480602004@kernel.org>
 <CAPVz0n0kKRpOsUNxvUKiTPSY7bF3h+ruV05B+9jSvs9NOxthkg@mail.gmail.com>
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
In-Reply-To: <CAPVz0n0kKRpOsUNxvUKiTPSY7bF3h+ruV05B+9jSvs9NOxthkg@mail.gmail.com>

On Tue, 03 Nov 2026, Svyatoslav Ryhel wrote:

> вт, 3 лист. 2026 р. о 13:43 Lee Jones <lee@kernel.org> пише:
> >
> > --- checkpatch.pl (4 issues) ---
> > Line 607: WARNING: DT compatible string "asus,sl101-ec-dock" appears un-documented -- check ./Documentation/devicetree/bindings/
> > Line 610: WARNING: DT compatible string "asus,tf101-ec-dock" appears un-documented -- check ./Documentation/devicetree/bindings/
> > Line 613: WARNING: DT compatible string "asus,tf201-ec-pad" appears un-documented -- check ./Documentation/devicetree/bindings/
> > Line 616: WARNING: DT compatible string "asus,tf600t-ec-pad" appears un-documented -- check ./Documentation/devicetree/bindings/
> > ----------------------------------
> >
> > On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:
> > > From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > >
> > > Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> > > TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
> > > and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> > > detection and common operations for EC's functions.
> > >
> > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/mfd/Kconfig                     |  16 +
> > >  drivers/mfd/Makefile                    |   1 +
> > >  drivers/mfd/asus-transformer-ec.c       | 569 ++++++++++++++++++++++++
> > >  include/linux/mfd/asus-transformer-ec.h | 100 +++++
> > >  4 files changed, 686 insertions(+)
> > >  create mode 100644 drivers/mfd/asus-transformer-ec.c
> > >  create mode 100644 include/linux/mfd/asus-transformer-ec.h
> >
> > [...]
> >
> > > +static int asus_ec_reset(struct asus_ec_data *ddata)
> > > +{
> > > +     int retry, ret;
> > > +
> > > +     guard(mutex)(&ddata->ecreq_lock);
> > > +
> > > +     for (retry = 0; retry < ASUSEC_RETRY_MAX; retry++) {
> >
> > As mentioned on v8, 'for (int retry = 0; ...)' is generally preferred for
> > throw-away loop variables.
> >
> 
> I must have overlooked this, appologies.
> 
> > > +             ret = i2c_smbus_write_word_data(ddata->client, ASUSEC_WRITE_BUF,
> > > +                                             ASUSEC_RESET);
> > > +             if (!ret)
> > > +                     return 0;
> > > +
> > > +             msleep(ASUSEC_ACCESS_TIMEOUT);
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> >
> > [...]
> >
> > > +static int asus_ec_probe(struct i2c_client *client)
> > > +{
> > > +     struct device *dev = &client->dev;
> > > +     struct asus_ec_data *ddata;
> > > +     const struct mfd_cell *cells;
> > > +     unsigned int num_cells;
> > > +     unsigned long irqflags;
> > > +     int ret;
> > > +
> > > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
> > > +             return dev_err_probe(dev, -ENXIO,
> > > +                     "I2C bus is missing required SMBus block mode support\n");
> > > +
> > > +     ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > > +     if (!ddata)
> > > +             return -ENOMEM;
> > > +
> > > +     ddata->info = device_get_match_data(dev);
> > > +     if (!ddata->info)
> > > +             return -ENODEV;
> > > +
> > > +     switch (ddata->info->variant) {
> > > +     case ASUSEC_SL101_DOCK:
> > > +             cells = asus_ec_sl101_dock_mfd_devices;
> > > +             num_cells = ARRAY_SIZE(asus_ec_sl101_dock_mfd_devices);
> > > +             break;
> > > +     case ASUSEC_TF101_DOCK:
> > > +             cells = asus_ec_tf101_dock_mfd_devices;
> > > +             num_cells = ARRAY_SIZE(asus_ec_tf101_dock_mfd_devices);
> > > +             break;
> > > +     case ASUSEC_TF201_PAD:
> > > +             cells = asus_ec_tf201_pad_mfd_devices;
> > > +             num_cells = ARRAY_SIZE(asus_ec_tf201_pad_mfd_devices);
> > > +             break;
> > > +     case ASUSEC_TF600T_PAD:
> > > +             cells = asus_ec_tf600t_pad_mfd_devices;
> > > +             num_cells = ARRAY_SIZE(asus_ec_tf600t_pad_mfd_devices);
> > > +             break;
> > > +     default:
> > > +             return dev_err_probe(dev, -EINVAL,
> > > +                                  "unknown device variant %d\n",
> > > +                                  ddata->info->variant);
> > > +     }
> > > +
> > > +     i2c_set_clientdata(client, ddata);
> > > +     ddata->client = client;
> > > +
> > > +     ddata->ec.dockram = devm_asus_dockram_get(dev);
> > > +     if (IS_ERR(ddata->ec.dockram))
> > > +             return dev_err_probe(dev, PTR_ERR(ddata->ec.dockram),
> > > +                                  "failed to get dockram\n");
> > > +
> > > +     ddata->ecreq_gpio = devm_gpiod_get(dev, "request", GPIOD_OUT_LOW);
> > > +     if (IS_ERR(ddata->ecreq_gpio))
> > > +             return dev_err_probe(dev, PTR_ERR(ddata->ecreq_gpio),
> > > +                                  "failed to get EC request GPIO\n");
> > > +
> > > +     BLOCKING_INIT_NOTIFIER_HEAD(&ddata->ec.notify_list);
> > > +     mutex_init(&ddata->ecreq_lock);
> > > +
> > > +     asus_ec_signal_request(ddata);
> > > +
> > > +     ret = asus_ec_detect(ddata);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "failed to detect EC version\n");
> > > +
> > > +     ret = asus_ec_init(ddata);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "failed to init EC\n");
> > > +
> > > +     /*
> > > +      * Systems using device tree should set up interrupt via DTS,
> > > +      * the rest will use the default low interrupt.
> > > +      */
> > > +     irqflags = dev->of_node ? 0 : IRQF_TRIGGER_LOW;
> > > +
> > > +     ret = devm_request_threaded_irq(dev, client->irq, NULL,
> > > +                                     &asus_ec_interrupt,
> > > +                                     IRQF_ONESHOT | irqflags,
> > > +                                     client->name, ddata);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "failed to register IRQ\n");
> > > +
> > > +     /* Parent I2C controller uses DMA, ASUS EC and child devices do not */
> > > +     client->dev.coherent_dma_mask = 0;
> > > +     client->dev.dma_mask = &client->dev.coherent_dma_mask;
> > > +
> > > +     return devm_mfd_add_devices(dev, 0, cells, num_cells, NULL, 0, NULL);
> >
> > Why not use 'PLATFORM_DEVID_NONE' or 'PLATFORM_DEVID_AUTO' here instead of a raw
> > '0' and hard-coded cell IDs in 'asus_ec_tf101_dock_mfd_devices'?
> >
> 
> There can be more then 1 EC in the tablet. PLATFORM_DEVID_NONE will
> not work in this case and PLATFORM_DEVID_AUTO should work, but one of
> EC is detachable (dock one) so devices there may need a fixed id. I
> can test if PLATFORM_DEVID_AUTO works, but may this be sent as a
> followup?

Sure.

-- 
Lee Jones
