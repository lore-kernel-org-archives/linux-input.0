From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Tue, 30 May 2017 10:11:17 +0200
Message-ID: <20170530101117.3b7a7186@free-electrons.com>
References: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
        <20170529144538.29187-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43071 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdE3ILT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 04:11:19 -0400
In-Reply-To: <20170529144538.29187-2-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, fery@cypress.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, maxime.ripard@free-electrons.com

Hello,

Couple more comments in addition to the more extensive review done by
Maxime.

On Mon, 29 May 2017 16:45:37 +0200, Mylène Josserand wrote:
> +static int cyttsp5_startup(struct cyttsp5 *ts)
> +{
> +	int rc;
> +
> +	rc = cyttsp5_deassert_int(ts);
> +	if (rc) {
> +		dev_err(ts->dev, "%s: Error on deassert int r=%d\n",
> +			__func__, rc);

I don't think it's very common to put __func__ in error messages,
especially when dev_err() already prints the name of the dvice.

> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Launch the application as the device starts in bootloader mode
> +	 * because of a power-on-reset
> +	 */
> +	rc = cyttsp5_hid_output_bl_launch_app(ts);
> +	if (rc < 0) {
> +		dev_err(ts->dev, "%s: Error on launch app r=%d\n",
> +			__func__, rc);
> +		goto exit;

Replace "goto exit" by "return rc;" since anyway the exit label
doesn't do anything.


> +static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> +			 const char *name)
> +{
> +	struct cyttsp5 *ts;
> +	struct cyttsp5_sysinfo *si;
> +	int rc = 0, i;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts) {
> +		rc = -ENOMEM;
> +		goto error_alloc_data;

Just return directly here (because the of_node_put is useless, see
below).

> +	}
> +
> +	/* Initialize device info */
> +	ts->regmap = regmap;
> +	ts->dev = dev;
> +	si = &ts->sysinfo;

So "si" is never NULL.

> +	if (si) {

And therefore you can do this unconditionally.

> +		__set_bit(EV_KEY, ts->input->evbit);
> +		for (i = 0; i < si->num_btns; i++)
> +			__set_bit(si->btn[i].key_code, ts->input->keybit);
> +
> +		rc = cyttsp5_setup_input_device(dev);
> +		if (rc)
> +			goto error_init_input;
> +	}
> +
> +	return 0;
> +
> +error_init_input:
> +	input_free_device(ts->input);

What about using devm_input_allocate_device() ?

> +error_startup:
> +error_setup_irq:
> +	dev_set_drvdata(dev, NULL);
> +error_alloc_data:
> +	dev_err(dev, "%s failed.\n", __func__);
> +	if (dev->of_node)
> +		of_node_put(dev->of_node);

As Maxime said, this is not necessary.

> +static int cyttsp5_remove(struct device *dev)
> +{
> +	const struct of_device_id *match;
> +	struct cyttsp5 *ts = dev_get_drvdata(dev);
> +
> +	input_unregister_device(ts->input);
> +
> +	dev_set_drvdata(dev, NULL);
> +
> +	match = of_match_device(of_match_ptr(cyttsp5_of_match), dev);
> +	if (match && dev->of_node)
> +		of_node_put(dev->of_node);

Ditto.

I'm also not sure that doing a dev_set_drvdata(dev, NULL) is really
needed in ->remove() and in the ->probe() exit path.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
