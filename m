From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] [hid-sony] Fix typo in error message
Date: Tue, 9 Feb 2010 11:37:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002091137340.30967@pobox.suse.cz>
References: <1265392952.2383.314.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41434 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513Ab0BIKhw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2010 05:37:52 -0500
In-Reply-To: <1265392952.2383.314.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Fri, 5 Feb 2010, Bastien Nocera wrote:

> ---
>  drivers/hid/hid-sony.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 4e84502..96d723e 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -81,7 +81,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	sc = kzalloc(sizeof(*sc), GFP_KERNEL);
>  	if (sc == NULL) {
> -		dev_err(&hdev->dev, "can't alloc apple descriptor\n");
> +		dev_err(&hdev->dev, "can't alloc sony descriptor\n");
>  		return -ENOMEM;
>  	}

Applied, thanks for catching this.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
