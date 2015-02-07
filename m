From: "Holmberg, Hans" <hans.holmberg@intel.com>
Subject: RE: [PATCH 2/2] input: gpio-joy - GPIO joystick driver
Date: Sat, 7 Feb 2015 07:53:02 +0000
Message-ID: <4B6D6D87A8FB62428BE0A3E38461A1AB18D6AF38@irsmsx105.ger.corp.intel.com>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1423215122-19947-3-git-send-email-hans.holmberg@intel.com>
 <20150206110257.GB10324@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33990 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbbBGHxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Feb 2015 02:53:05 -0500
In-Reply-To: <20150206110257.GB10324@leverpostej>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


> > +static int gpio_joy_probe(struct platform_device *pdev) {
> > +	struct device *dev = &pdev->dev;
> > +	struct input_dev *input;
> > +	struct gpio_joy_drvdata *ddata;
> > +	int i, err;
> > +	unsigned int debounce_ms;
> 
> This should be a u32 given you pass it to a function expecting a u32 pointer.
> 
> > +
> > +	ddata = devm_kzalloc(dev, sizeof(struct gpio_joy_drvdata),
> > +GFP_KERNEL);
> 
> Use sizeof(*ddata)
> 
> [...]
> 
> > +	return 0;
> > +fail:
> > +	return err;
> > +}
> 
> Given there's no cleanup, the fail path seems redundant.
> 
> [...]
> 
> > +static const struct of_device_id gpio_joy_of_match[] = {
> > +	{ .compatible = DRV_NAME, },
> > +	{ },
> > +};
> 
> The compatible string should be independent of DRV_NAME, because it must
> match the binding. The driver can be arbitrarily and independently renamed.
> 

I'll address all of these comments, thanks for reviewing!
Hans
