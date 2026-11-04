Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780925;
	b=s7ZrKHFkuJH95fcNA/1k70XvN7/spk8LYZ0Fm1Kct02ciRoh3CmE57mQf3ghuYgcAHTl
	 XLZRY6VKekRgucSarotWU3pE07jJ01gTjxh8v55MlZCjy7+PoGr3W34iFnWeKbrSWqz76
	 YZUxdGAwoto4gD/rqEUWVNXfW953dOMQtHY6X6i25RN8e/Vyu53neYk9WYK5OB4Bvi8u9
	 Tc92FeXG2yykPXArvL8qa7k+eOFqv8vGWhfLcH6epL5FvMRebv/zHeVelH/G4hYOX08wd
	 PiE7Xf+1GMMK7tjo2uGHFYqJK2Y5LHspcofWFfEpdtvH3VFJGg9xe+UQ+cWx42JTrhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780925;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=GjJDp8CTHMSlDMbc6XRZQCDEEf2kmsgLRv3b4Kr7DvQ=;
	b=Ogh6OxCvgcO59sT8D4ZqkpEcvLEbrkxaC9SZ1+orGRVMRU8hWEBqcLzl1PJR9QUgPu4m
	 SiV0BUJyPwVuZSPNUMvCXEr6Ck9UW6eXpo54OGkf0AF6mlpXoRJzQdtCFsQLwZvcxrKWD
	 LjityETszCvt00maXzLlGijgViJxeX9c58GVZsGz+GNSmDPA4FJQE0rBX/m3ssRa3JS4+
	 8BEGC5W9bqUFjsfxfsjB5fpXw05/G7R/cxXUHFgh27Is5m7ygphBJX8ITznqIhydWWBNk
	 ciFK46ZkyhRg4VkYSgZ34WQ1lTUqLqDQyAVqQpqVUpcqduD+fNCb53PSQbmM9Pmk24A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDptMS7b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D97606A326;
	Wed,  4 Nov 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDptMS7b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5001F000C1;
	Wed,  4 Nov 2026 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780924;
	bh=GjJDp8CTHMSlDMbc6XRZQCDEEf2kmsgLRv3b4Kr7DvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bDptMS7by0DYPilGz4lezQHQHvvu1P5tWmxD0ToL5hG+6zDSioJLRD6rgUUDJMqo3
	 eNPLmIV55rvRb6AsR3fqB7zi0N7nkf3kD633FvFL0jdF5nhUqraeMiBmq894P/xT1d
	 jDS2+C0LLTg9tpfHaf2eLQ1J/AvuOyzNmYkxG71yeiIDZKcPZvoGq6ii17XMRCH1Nr
	 4U3vFQyrJFJbSnhU7mhqPp+iRRyALxWTrt/9XV+SWCnEkm1blDWkbi2NNFIVwX9eRF
	 attzArUDCuywowQvBGBR/aK+1ib7QhXmvhvLyyAFnvRo0kTzKhYJDsCLDTU97MoPm8
	 IKzO3X4Swa8eA==
Date: Wed, 4 Nov 2026 08:28:39 +0000
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
Subject: Re: [PATCH v12 5/7] leds: Add driver for ASUS Transformer LEDs
Message-ID: <20261104082839.GD792264@google.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-6-clamor95@gmail.com>
 <179249575817.1833288.1089755405582445022@kernel.org>
 <CAPVz0n0=6Z7E9iSc84xL6Jt=Xi=a=qmSwVsT5g-LMZ+mENFkzg@mail.gmail.com>
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
In-Reply-To: <CAPVz0n0=6Z7E9iSc84xL6Jt=Xi=a=qmSwVsT5g-LMZ+mENFkzg@mail.gmail.com>

On Tue, 03 Nov 2026, Svyatoslav Ryhel wrote:

> вт, 3 лист. 2026 р. о 16:03 Lee Jones <lee@kernel.org> пише:
> >
> > On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:
> > > From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > >
> > > ASUS Transformer tablets have a green and an amber LED on both the Pad
> > > and the Dock. If both LEDs are enabled simultaneously, the emitted light
> > > will be yellow.
> > >
> > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > ---
> > >  drivers/leds/Kconfig                    |  11 +++
> > >  drivers/leds/Makefile                   |   1 +
> > >  drivers/leds/leds-asus-transformer-ec.c | 125 ++++++++++++++++++++++++
> > >  3 files changed, 137 insertions(+)
> > >  create mode 100644 drivers/leds/leds-asus-transformer-ec.c
> > >
> > > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > > index 7ec2c8d785426..788e689fe875c 100644
> > > --- a/drivers/leds/Kconfig
> > > +++ b/drivers/leds/Kconfig
> > > @@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called leds-as3668.
> > >
> > > +config LEDS_ASUS_TRANSFORMER_EC
> > > +     tristate "LED Support for Asus Transformer charging LED"
> > > +     depends on LEDS_CLASS
> > > +     depends on MFD_ASUS_TRANSFORMER_EC
> > > +     help
> > > +       This option enables support for charging indicator on
> > > +       Asus Transformer's Pad and its Dock.
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called leds-asus-transformer-ec.
> > > +
> > >  config LEDS_AW200XX
> > >       tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
> > >       depends on LEDS_CLASS
> > > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > > index 4d4b089156e24..3da746279bb81 100644
> > > --- a/drivers/leds/Makefile
> > > +++ b/drivers/leds/Makefile
> > > @@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_ADP5520)          += leds-adp5520.o
> > >  obj-$(CONFIG_LEDS_AN30259A)          += leds-an30259a.o
> > >  obj-$(CONFIG_LEDS_APU)                       += leds-apu.o
> > >  obj-$(CONFIG_LEDS_ARIEL)             += leds-ariel.o
> > > +obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)       += leds-asus-transformer-ec.o
> > >  obj-$(CONFIG_LEDS_OSRAM_AMS_AS3668)  += leds-as3668.o
> > >  obj-$(CONFIG_LEDS_AW200XX)           += leds-aw200xx.o
> > >  obj-$(CONFIG_LEDS_AW2013)            += leds-aw2013.o
> > > diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-asus-transformer-ec.c
> > > new file mode 100644
> > > index 0000000000000..1b129247ea6c6
> > > --- /dev/null
> > > +++ b/drivers/leds/leds-asus-transformer-ec.c
> > > @@ -0,0 +1,125 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/leds.h>
> > > +#include <linux/mfd/asus-transformer-ec.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +enum {
> > > +     ASUSEC_LED_AMBER,
> > > +     ASUSEC_LED_GREEN,
> > > +     ASUSEC_LED_MAX
> > > +};
> > > +
> > > +struct asus_ec_led_config {
> > > +     const char *name;
> > > +     unsigned int color;
> > > +     u64 ctrl_bit;
> > > +};
> > > +
> > > +struct asus_ec_led {
> > > +     struct asus_ec_leds_data *ddata;
> >
> >
> > Why do we need 'struct ' at all?
> >
> > If we put 'const struct asusec_core *ec;' directly into 'struct
> > asus_ec_led', we can drop the outer wrapper struct and the back-pointer
> > completely.
> >
> 
> You propose to allocate asus_ec_led for each led in a loop? I have not
> seen this done by other leds. The asus_ec_leds_data is driver ddata,
> asus_ec_led is each led individual structure.

For your whole 2 LEDs, yes, I think that will be better.

> > > +     struct led_classdev cdev;
> > > +     u64 ctrl_bit;
> > > +};
> > > +
> > > +struct asus_ec_leds_data {
> > > +     const struct asusec_core *ec;
> > > +     struct asus_ec_led leds[ASUSEC_LED_MAX];
> > > +};
> > > +
> > > +static const struct asus_ec_led_config asus_ec_leds[] = {
> > > +     [ASUSEC_LED_AMBER] = {
> > > +             .name = "amber",
> > > +             .color = LED_COLOR_ID_AMBER,
> > > +             .ctrl_bit = ASUSEC_CTL_LED_AMBER,
> > > +     },
> > > +     [ASUSEC_LED_GREEN] = {
> > > +             .name = "green",
> > > +             .color = LED_COLOR_ID_GREEN,
> > > +             .ctrl_bit = ASUSEC_CTL_LED_GREEN,
> > > +     },
> > > +};
> > > +
> > > +static enum led_brightness asus_ec_led_get_brightness(struct led_classdev *cdev)
> > > +{
> > > +     struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
> > > +     const struct asusec_core *ec = led->ddata->ec;
> > > +     u64 ctl;
> > > +     int ret;
> > > +
> > > +     ret = asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);
> >
> > As requested on v6 and v8, why are we still using this bespoke accessor instead
> > of Regmap?
> 
> https://lore.kernel.org/lkml/CAPVz0n0imF_ESoGMJSrEX7NOnBShFj8wehDtQKXZV_DMcGqq=A@mail.gmail.com/

Sorry, I've slept since then, and subsequently forgotten this
conversation.  You can drop this request.

> > > +     if (ret)
> > > +             return LED_OFF;
> > > +
> > > +     return ctl & led->ctrl_bit ? LED_ON : LED_OFF;
> > > +}
> > > +
> > > +static int asus_ec_led_set_brightness(struct led_classdev *cdev,
> > > +                                   enum led_brightness brightness)
> > > +{
> > > +     struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
> > > +     const struct asusec_core *ec = led->ddata->ec;
> > > +
> > > +     if (brightness)
> > > +             return asus_dockram_access_ctl(ec->dockram, NULL,
> > > +                                            led->ctrl_bit, led->ctrl_bit);
> >
> > Use 100-chars throughout to prevent early wrapping.
> >
> > > +     return asus_dockram_access_ctl(ec->dockram, NULL, led->ctrl_bit, 0);
> > > +}
> > > +
> > > +static int asus_ec_led_probe(struct platform_device *pdev)
> > > +{
> > > +     const struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
> > > +     struct asus_ec_leds_data *ddata;
> > > +     struct device *dev = &pdev->dev;
> > > +     int ret;
> > > +
> > > +     ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > > +     if (!ddata)
> > > +             return -ENOMEM;
> > > +
> > > +     platform_set_drvdata(pdev, ddata);
> >
> > What consumes this?
> 
> Seems to be an overlook, must have forgotten to remove it during 12
> iterations over last 10 month

No problem, it happens.

> > > +     ddata->ec = ec;
> > > +
> > > +     for (int i = 0; i < ASUSEC_LED_MAX; i++) {
> >
> > `i` isn't just a random iterator here - maybe call it `led`?
> >
> 
> This is just a disposable iterator.

It's a disposable iterator that is clearly a `led`.

Thus my request for and improvement in the nomenclature remains valid.

> v7 seem fine https://lore.kernel.org/lkml/20260702162425.GD2108533@google.com/
> v9 as well https://lore.kernel.org/lkml/20260702162425.GD2108533@google.com/

These are the same link.

> Yet again complains and nits

That my job.  You're welcome.  =;-)

Sometimes new things are found on re-review.

Apologies for the disappointment.

-- 
Lee Jones
