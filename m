Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BA3CCFB5
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431444; cv=none; b=S9WW9RD7aPcM6M77tPEhzHWp4gzJAL97lYIwKJA+GE9xTSfXgxpPS6a0bc1BVpNyzYhNXS312X1rWVVSv9hq0vjISy7qDzBWdOcZablfW1YSpqm1uEe6yu/6aCIRfkHYA/LAJpIbwYaG66TOTTgW73dh4VKEQfYyWMERZQ4ASfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431444; c=relaxed/simple;
	bh=+lhr7dlhYBc9dr6zAHvWu646g3WjVVQ98sut5STYqaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0VqbDeLDcY9EuzpzDUOgW+zHR5wftz7xRCQfxSoq7MSEYraIpujX/G+w74qaIMR/mIwGjXUAODYi6i/T72bv4AU0IJJAHiR8x/F9xc6xrSVI2e4V/KkQfH3FLbhtObzaMfkBH0+ePCk1Z0nddcl7jibrqHGW7G+e74aBsnzVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1w18WM-0003qF-SU; Fri, 13 Mar 2026 20:50:06 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1w18WL-000864-28;
	Fri, 13 Mar 2026 20:50:05 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1w18WL-0000000HJee-2IC1;
	Fri, 13 Mar 2026 20:50:05 +0100
Date: Fri, 13 Mar 2026 20:50:05 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Andrew Thomas <andrew.thomas@touchnetix.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Marco Felsch <kernel@pengutronix.de>, 
	Henrik Rydberg <rydberg@bitmath.org>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v6 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <enyz3io3i7mzoaquexpkbsjtxmcuib7lxj334ii2yqvdgpvajb@aspqccwo7vnf>
References: <20260303-v6-10-topic-touchscreen-axiom-v6-4-8ac755add12b@pengutronix.de>
 <rnbwxsdiwjojk7354c6k4us6xxl3qpbyt2lrbhgqz77avrdwga@tqb6voucuysi>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rnbwxsdiwjojk7354c6k4us6xxl3qpbyt2lrbhgqz77avrdwga@tqb6voucuysi>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Hi Andrew,

thanks for your feedback! Please see below.

On 26-03-13, Andrew Thomas wrote:
> On Tue, Mar 03, 2026 at 11:41:22PM +0100, Marco Felsch wrote:
> >This adds the initial support for the TouchNetix AX54A touchcontroller
> >which is part of TouchNetix's aXiom touchscreen controller family.
> >
> >The TouchNetix aXiom family provides two physical interfaces: SPI and
> >I2C. This patch covers only the I2C interface.
> >
> >Apart the input event handling the driver supports firmware updates too.
> >One firmware interface handles the touchcontroller firmware (AXFW)
> >update the other handles the touchcontroller configuration (TH2CFGBIN)
> >update.
> >
> >Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> >---

...

> >+static int axiom_u02_enter_bootloader(struct axiom_data *ts)
> >+{
> >+	struct axiom_u02_rev1_system_manager_msg msg = { };
> >+	struct device *dev = ts->dev;
> >+	unsigned int val;
> >+	int error;
> >+
> >+	if (!axiom_driver_supports_usage(ts, AXIOM_U02))
> >+		return -EINVAL;
> >+
> >+	/*
> >+	 * Enter the bootloader mode requires 3 consecutive messages so we can't
> >+	 * check for the response.
> >+	 * TODO: Check if it's required to add a delay between the consecutive
> >+	 * CMD_ENTERBOOTLOADER cmds.
> >+	 */
> >+	msg.command = cpu_to_le16(AXIOM_U02_REV1_CMD_ENTERBOOTLOADER);
> >+	msg.parameters[0] = cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY1);
> >+	error = axiom_u02_send_msg(ts, &msg, false);
> 
> As mentioned before the delay between commands is too short and the
> next command is sent before u02 is ready, which means the driver fails
> to put axiom into the bootloader.

Please see my comment [1].

> Have you tested with an i2c speed of 400KHz?

Yes, my target platform is based on a i.MX8MP.

> All you need is to put true in above to wait for the bootloader command.
> error = axiom_u02_send_msg(ts, &msg, true);

Please see my comment [1].

> Just dont do it for the last command.

Please see my comment [1].

> I am not too sure why you are having issues with this, this is how we
> do it for all our devices.

Please see my comment [1].

On what platform do you perform the tests?

> >+	if (error) {
> >+		dev_err(dev, "Failed to send bootloader-key1: %d\n", error);
> >+		return error;
> >+	}
> >+
> >+	msg.parameters[0] = cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY2);
> >+	error = axiom_u02_send_msg(ts, &msg, false);
> 
> Here also.

Please see my comment [1].

> >+	if (error) {
> >+		dev_err(dev, "Failed to send bootloader-key2: %d\n", error);
> >+		return error;
> >+	}
> >+
> >+	msg.parameters[0] = cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY3);
> >+	error = axiom_u02_send_msg(ts, &msg, false);
> >+	if (error) {
> >+		dev_err(dev, "Failed to send bootloader-key3: %d\n", error);
> >+		return error;
> >+	}
> >+
> >+	/* Sleep before the first read to give the device time */
> >+	fsleep(250 * USEC_PER_MSEC);
> >+
> >+	/* Wait till the device reports it is in bootloader mode */
> >+	error = regmap_read_poll_timeout(ts->regmap,
> >+					 AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, val,
> >+					 FIELD_GET(AXIOM_U31_REV1_MODE_MASK, val) ==
> >+						AXIOM_U31_REV1_MODE_BLP,
> >+					 250 * USEC_PER_MSEC, USEC_PER_SEC);
> >+	if (error)
> >+		return error;
> >+
> >+	return 0;
> >+}
> >+
> 
> ...
> 
> 
> Other than the above comments I have no issues with the driver.

If you're fine with the patch you could add your acked-by [2] :)

> We can support more usages in a later patch.

Sure :)

[1] https://lore.kernel.org/all/4x3dnedfzf3rqzsy3wjdoj6yaxmy6kop37xhxeao4vjer7ifdi@35ux42ztq3eb/
[2] https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Regards,
  Marco
-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
