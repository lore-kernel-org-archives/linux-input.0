From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] input:Regulator support in ROHM BU21013 touch panel
Date: Wed, 12 Jan 2011 10:57:45 +0000
Message-ID: <20110112105745.GL6541@sirena.org.uk>
References: <1294814126-13632-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59397 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab1ALK5t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 05:57:49 -0500
Content-Disposition: inline
In-Reply-To: <1294814126-13632-1-git-send-email-naveen.gaddipati@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org, rydberg@euromail.se

On Wed, Jan 12, 2011 at 12:05:26PM +0530, Naveen Kumar G wrote:

> +	bu21013_data->regulator = regulator_get(&client->dev, "V-TOUCH");
> +	if (IS_ERR(bu21013_data->regulator)) {
> +		dev_warn(&client->dev, "regulator_get failed\n");
> +		bu21013_data->regulator = NULL;
> +	}
> +	if (bu21013_data->regulator)
> +		regulator_enable(bu21013_data->regulator);
> +

If you fail to acquire the regulator just return an error, there is
support in the regulator core for automatically providing a dummy
regulator (including in cases where some regulators are in use) so no
need to replicate this code in each driver or have lots of conditionals
for the regulator.

You're also not checking the result of regulator_enable().

>   */
>  struct bu21013_platform_device {
> +	const char *name;

As Dimitry said you should just use the dev_name() you get by default.
