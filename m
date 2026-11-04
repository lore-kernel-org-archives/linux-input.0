Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790147;
	b=gshP1D1FMjglxPcURSvu1aCz3vxc1rFt5ebfIECyGtYGa6KqQ1ePXksACJtBg3eA7v/I
	 PHMHJ9ruZqbqrRW+6LRymVrW6GxVaPW3abEGUYXobZ6r9DMRRTptl0OCtXbyks8GLsvUk
	 UrP+nRN+kWlbgs85pjeoR4d1VgxsTFIEIn9Rc5o/9y6oTIVl0VrquWpXn4E7fEhGS4qAJ
	 VZE7xEw6gXrVvxK1BUHaS/TQMH0DxLSMF/v6L6r2Mu9l3akgg6jKubLT8VFV26Ns17hRS
	 9CJqY2ML3/n619thyN1+xFnaXyqt1Zo94DS5SUK56H/G9Rp4X8BoHw5+/0h0nW1Th1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790147;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7VuWj7zEvZVZovhUG6+Wn2YICpsQy6MzIBw8j4mBmkc=;
	b=N4qKn91ISZrdL/8gBSneEnwYrLuIg0l1RSm8LTGiZp62AZ9I7DS0KUrFavNAE9z4Ofcj
	 3cg/cEhWzarJ2sLvVVjKSgRrV1lmhgKInQb1AgpFBeYHkF8dmeoLpXOeOgosHOgi9Vid8
	 Ko9VoMclYD6Fc7Hx74c5kq/5y6Dj+YUogPewXNWdUyf4Mhc80v1AvhO+gQ1hu32DzW1oX
	 dM8YcAOv8i0aCVlcE6HupxFSeIC5ijQR9iMxrdDIrZHt6YYmyVO//hzLHI6hU44ZS4kt7
	 IAHPZm5n9A4mILIdx9K22ZEN5O1Mf5qw3VY2p4aJgF7IaECApMp1DnrcdMU1eLBG+9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYavcA3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581ED606A335;
	Wed,  4 Nov 2026 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYavcA3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D778B1F00919;
	Wed,  4 Nov 2026 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793790146;
	bh=7VuWj7zEvZVZovhUG6+Wn2YICpsQy6MzIBw8j4mBmkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TYavcA3iWsNqIn2LSq2HAm/CowvFmf2BrmpRhdBUaFJu1pUOCNnlAR8n0xS2n/JMd
	 pxm7pGu3WlBksxD8jLb8TcgR69x+mgMsM1QieFse5cQKNK0QWQCbVhmkNxkFcV3L/l
	 OFJB1eg5Ri6Llp9lqbP+/FLgArUD7xM1Ue0tlvxoh011C5VUPWKPgQIEzXfH6dEhdt
	 DwIbk2Jujduo9GEV8XkWgl52gzviiL8DMgrPjNnbJWYYuUs8Bylxi8WtTsKvAiwG9K
	 NLkCpLES7XMD7/cLq2nbr/UZk7n9KJabkz6H5UYKlJxdBUGG/iGuhUB5mYow1URnWi
	 dyjWrmmBcwoXA==
Date: Wed, 4 Nov 2026 11:02:21 +0000
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
Message-ID: <20261104110221.GK792264@google.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-6-clamor95@gmail.com>
 <179249575817.1833288.1089755405582445022@kernel.org>
 <CAPVz0n0=6Z7E9iSc84xL6Jt=Xi=a=qmSwVsT5g-LMZ+mENFkzg@mail.gmail.com>
 <20261104082839.GD792264@google.com>
 <CAPVz0n2aCy9Kx5kK1EZD3qxN=KCSf=cB7ZnP1SedrrJc13sh2g@mail.gmail.com>
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
In-Reply-To: <CAPVz0n2aCy9Kx5kK1EZD3qxN=KCSf=cB7ZnP1SedrrJc13sh2g@mail.gmail.com>

On Wed, 04 Nov 2026, Svyatoslav Ryhel wrote:

> ср, 4 лист. 2026 р. о 10:28 Lee Jones <lee@kernel.org> пише:
> >
> > On Tue, 03 Nov 2026, Svyatoslav Ryhel wrote:
> >
> > > вт, 3 лист. 2026 р. о 16:03 Lee Jones <lee@kernel.org> пише:
> > > >
> > > > On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:
> > > > > From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > > >
> > > > > ASUS Transformer tablets have a green and an amber LED on both the Pad
> > > > > and the Dock. If both LEDs are enabled simultaneously, the emitted light
> > > > > will be yellow.
> > > > >
> > > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > > > ---
> > > > >  drivers/leds/Kconfig                    |  11 +++
> > > > >  drivers/leds/Makefile                   |   1 +
> > > > >  drivers/leds/leds-asus-transformer-ec.c | 125 ++++++++++++++++++++++++
> > > > >  3 files changed, 137 insertions(+)
> > > > >  create mode 100644 drivers/leds/leds-asus-transformer-ec.c
> > > > >
> > > > > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > > > > index 7ec2c8d785426..788e689fe875c 100644
> > > > > --- a/drivers/leds/Kconfig
> > > > > +++ b/drivers/leds/Kconfig
> > > > > @@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
> > > > >         To compile this driver as a module, choose M here: the module
> > > > >         will be called leds-as3668.
> > > > >
> > > > > +config LEDS_ASUS_TRANSFORMER_EC
> > > > > +     tristate "LED Support for Asus Transformer charging LED"
> > > > > +     depends on LEDS_CLASS
> > > > > +     depends on MFD_ASUS_TRANSFORMER_EC
> > > > > +     help
> > > > > +       This option enables support for charging indicator on
> > > > > +       Asus Transformer's Pad and its Dock.
> > > > > +
> > > > > +       To compile this driver as a module, choose M here: the module
> > > > > +       will be called leds-asus-transformer-ec.
> > > > > +
> > > > >  config LEDS_AW200XX
> > > > >       tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
> > > > >       depends on LEDS_CLASS
> > > > > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > > > > index 4d4b089156e24..3da746279bb81 100644
> > > > > --- a/drivers/leds/Makefile
> > > > > +++ b/drivers/leds/Makefile
> > > > > @@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_ADP5520)          += leds-adp5520.o
> > > > >  obj-$(CONFIG_LEDS_AN30259A)          += leds-an30259a.o
> > > > >  obj-$(CONFIG_LEDS_APU)                       += leds-apu.o
> > > > >  obj-$(CONFIG_LEDS_ARIEL)             += leds-ariel.o
> > > > > +obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)       += leds-asus-transformer-ec.o
> > > > >  obj-$(CONFIG_LEDS_OSRAM_AMS_AS3668)  += leds-as3668.o
> > > > >  obj-$(CONFIG_LEDS_AW200XX)           += leds-aw200xx.o
> > > > >  obj-$(CONFIG_LEDS_AW2013)            += leds-aw2013.o
> > > > > diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-asus-transformer-ec.c
> > > > > new file mode 100644
> > > > > index 0000000000000..1b129247ea6c6
> > > > > --- /dev/null
> > > > > +++ b/drivers/leds/leds-asus-transformer-ec.c
> > > > > @@ -0,0 +1,125 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +
> > > > > +#include <linux/err.h>
> > > > > +#include <linux/leds.h>
> > > > > +#include <linux/mfd/asus-transformer-ec.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/slab.h>
> > > > > +
> > > > > +enum {
> > > > > +     ASUSEC_LED_AMBER,
> > > > > +     ASUSEC_LED_GREEN,
> > > > > +     ASUSEC_LED_MAX
> > > > > +};
> > > > > +
> > > > > +struct asus_ec_led_config {
> > > > > +     const char *name;
> > > > > +     unsigned int color;
> > > > > +     u64 ctrl_bit;
> > > > > +};
> > > > > +
> > > > > +struct asus_ec_led {
> > > > > +     struct asus_ec_leds_data *ddata;
> > > >
> > > >
> > > > Why do we need 'struct ' at all?
> > > >
> > > > If we put 'const struct asusec_core *ec;' directly into 'struct
> > > > asus_ec_led', we can drop the outer wrapper struct and the back-pointer
> > > > completely.
> > > >
> > >
> > > You propose to allocate asus_ec_led for each led in a loop? I have not
> > > seen this done by other leds. The asus_ec_leds_data is driver ddata,
> > > asus_ec_led is each led individual structure.
> >
> > For your whole 2 LEDs, yes, I think that will be better.
> >
> > > > > +     struct led_classdev cdev;
> > > > > +     u64 ctrl_bit;
> > > > > +};
> > > > > +
> > > > > +struct asus_ec_leds_data {
> > > > > +     const struct asusec_core *ec;
> > > > > +     struct asus_ec_led leds[ASUSEC_LED_MAX];
> > > > > +};
> > > > > +
> > > > > +static const struct asus_ec_led_config asus_ec_leds[] = {
> > > > > +     [ASUSEC_LED_AMBER] = {
> > > > > +             .name = "amber",
> > > > > +             .color = LED_COLOR_ID_AMBER,
> > > > > +             .ctrl_bit = ASUSEC_CTL_LED_AMBER,
> > > > > +     },
> > > > > +     [ASUSEC_LED_GREEN] = {
> > > > > +             .name = "green",
> > > > > +             .color = LED_COLOR_ID_GREEN,
> > > > > +             .ctrl_bit = ASUSEC_CTL_LED_GREEN,
> > > > > +     },
> > > > > +};
> > > > > +
> > > > > +static enum led_brightness asus_ec_led_get_brightness(struct led_classdev *cdev)
> > > > > +{
> > > > > +     struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
> > > > > +     const struct asusec_core *ec = led->ddata->ec;
> > > > > +     u64 ctl;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);
> > > >
> > > > As requested on v6 and v8, why are we still using this bespoke accessor instead
> > > > of Regmap?
> > >
> > > https://lore.kernel.org/lkml/CAPVz0n0imF_ESoGMJSrEX7NOnBShFj8wehDtQKXZV_DMcGqq=A@mail.gmail.com/
> >
> > Sorry, I've slept since then, and subsequently forgotten this
> > conversation.  You can drop this request.
> >
> > > > > +     if (ret)
> > > > > +             return LED_OFF;
> > > > > +
> > > > > +     return ctl & led->ctrl_bit ? LED_ON : LED_OFF;
> > > > > +}
> > > > > +
> > > > > +static int asus_ec_led_set_brightness(struct led_classdev *cdev,
> > > > > +                                   enum led_brightness brightness)
> > > > > +{
> > > > > +     struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
> > > > > +     const struct asusec_core *ec = led->ddata->ec;
> > > > > +
> > > > > +     if (brightness)
> > > > > +             return asus_dockram_access_ctl(ec->dockram, NULL,
> > > > > +                                            led->ctrl_bit, led->ctrl_bit);
> > > >
> > > > Use 100-chars throughout to prevent early wrapping.
> > > >
> > > > > +     return asus_dockram_access_ctl(ec->dockram, NULL, led->ctrl_bit, 0);
> > > > > +}
> > > > > +
> > > > > +static int asus_ec_led_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +     const struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
> > > > > +     struct asus_ec_leds_data *ddata;
> > > > > +     struct device *dev = &pdev->dev;
> > > > > +     int ret;
> > > > > +
> > > > > +     ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > > > > +     if (!ddata)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     platform_set_drvdata(pdev, ddata);
> > > >
> > > > What consumes this?
> > >
> > > Seems to be an overlook, must have forgotten to remove it during 12
> > > iterations over last 10 month
> >
> > No problem, it happens.
> >
> > > > > +     ddata->ec = ec;
> > > > > +
> > > > > +     for (int i = 0; i < ASUSEC_LED_MAX; i++) {
> > > >
> > > > `i` isn't just a random iterator here - maybe call it `led`?
> > > >
> > >
> > > This is just a disposable iterator.
> >
> > It's a disposable iterator that is clearly a `led`.
> >
> > Thus my request for and improvement in the nomenclature remains valid.
> >
> > > v7 seem fine https://lore.kernel.org/lkml/20260702162425.GD2108533@google.com/
> > > v9 as well https://lore.kernel.org/lkml/20260702162425.GD2108533@google.com/
> >
> > These are the same link.
> >
> 
> Ooops, v7 https://lore.kernel.org/lkml/20260527144619.GA671544@google.com/
> 
> > > Yet again complains and nits
> >
> > That my job.  You're welcome.  =;-)
> >
> > Sometimes new things are found on re-review.
> >
> > Apologies for the disappointment.
> >
> 
> I will incorporate all your requests, but please, may you apply/check
> v13 a bit quicker. That would be awesome.

Sure.  =:-)

-- 
Lee Jones
