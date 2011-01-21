From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input:bu21013: Update the regulator name
Date: Fri, 21 Jan 2011 09:06:23 -0800
Message-ID: <20110121170623.GA27756@core.coreip.homeip.net>
References: <1295609905-2905-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56411 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923Ab1AURGc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 12:06:32 -0500
Received: by qwa26 with SMTP id 26so2009794qwa.19
        for <linux-input@vger.kernel.org>; Fri, 21 Jan 2011 09:06:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295609905-2905-1-git-send-email-naveen.gaddipati@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Cc: STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org, rydberg@euromail.se, lee.jones@linaro.org

On Fri, Jan 21, 2011 at 05:08:25PM +0530, Naveen Kumar G wrote:
> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> Update the regulator name for getting the regulator of
> the bu21013 touch device.

... because <list of reasons this change is needed>.

Thanks.

> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> ---
>  drivers/input/touchscreen/bu21013_ts.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
> index 1507ce1..03e60d3 100644
> --- a/drivers/input/touchscreen/bu21013_ts.c
> +++ b/drivers/input/touchscreen/bu21013_ts.c
> @@ -460,7 +460,7 @@ static int __devinit bu21013_probe(struct i2c_client *client,
>  	bu21013_data->chip = pdata;
>  	bu21013_data->client = client;
>  
> -	bu21013_data->regulator = regulator_get(&client->dev, "V-TOUCH");
> +	bu21013_data->regulator = regulator_get(&client->dev, "avdd");
>  	if (IS_ERR(bu21013_data->regulator)) {
>  		dev_err(&client->dev, "regulator_get failed\n");
>  		error = PTR_ERR(bu21013_data->regulator);
> -- 
> 1.7.2.dirty
> 

-- 
Dmitry
