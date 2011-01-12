From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input:Regulator support in ROHM BU21013 touch panel
Date: Wed, 12 Jan 2011 00:40:50 -0800
Message-ID: <20110112084050.GB4644@core.coreip.homeip.net>
References: <1294814126-13632-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48034 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab1ALIk4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 03:40:56 -0500
Received: by iwn9 with SMTP id 9so280709iwn.19
        for <linux-input@vger.kernel.org>; Wed, 12 Jan 2011 00:40:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294814126-13632-1-git-send-email-naveen.gaddipati@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Cc: STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org, rydberg@euromail.se, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Naveen,

On Wed, Jan 12, 2011 at 12:05:26PM +0530, Naveen Kumar G wrote:
> @@ -456,6 +459,16 @@ static int __devinit bu21013_probe(struct i2c_client *client,
>  	bu21013_data->in_dev = in_dev;
>  	bu21013_data->chip = pdata;
>  	bu21013_data->client = client;
> +	dev_set_name(&client->dev, pdata->name);

Hmm, why is this needed?


> +
> +	bu21013_data->regulator = regulator_get(&client->dev, "V-TOUCH");
> +	if (IS_ERR(bu21013_data->regulator)) {
> +		dev_warn(&client->dev, "regulator_get failed\n");
> +		bu21013_data->regulator = NULL;
> +	}
> +	if (bu21013_data->regulator)
> +		regulator_enable(bu21013_data->regulator);
> +

I believe Mark prefers to fail initialization if regulator isn't
found/available and use dummy regulators on platforms that do not have
real one. Mark?

-- 
Dmitry
