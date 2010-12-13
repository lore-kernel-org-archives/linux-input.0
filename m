From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] input: keyboard: MCS5080: support suspend/resume.
Date: Mon, 13 Dec 2010 01:00:26 -0800
Message-ID: <20101213090026.GF21401@core.coreip.homeip.net>
References: <4CE6179A.5050404@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f170.google.com ([209.85.214.170]:56148 "EHLO
	mail-iw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab0LMJAd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 04:00:33 -0500
Received: by iwn6 with SMTP id 6so8824937iwn.1
        for <linux-input@vger.kernel.org>; Mon, 13 Dec 2010 01:00:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE6179A.5050404@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Kim, HeungJun" <riverful.kim@samsung.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>

Hi Kim,

On Fri, Nov 19, 2010 at 03:22:18PM +0900, Kim, HeungJun wrote:
> This patch supports suspend/resume functions for mcs5080 touchkey
> driver.
> 
...

> @@ -181,6 +188,9 @@ static int __devinit mcs_touchkey_probe(struct i2c_client *client,
>  		goto err_free_irq;
>  
>  	i2c_set_clientdata(client, data);
> +
> +	pm_runtime_set_active(&client->dev);
> +

Why is this required? Won't this effectively disable PM suspend/resume?

Thanks.

-- 
Dmitry
