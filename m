From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Support for MosArt multitouch panel
Date: Wed, 10 Feb 2010 12:08:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002101207591.30967@pobox.suse.cz>
References: <20100206141713.EFC3C9520A@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44359 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233Ab0BJLIm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 06:08:42 -0500
In-Reply-To: <20100206141713.EFC3C9520A@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, chatty@enac.fr

On Sat, 6 Feb 2010, Stephane Chatty wrote:

> +static int mosart_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	int ret;
> +	struct mosart_data *td;
> +
> +
> +	td = kmalloc(sizeof(struct mosart_data), GFP_KERNEL);
> +	if (!td) {
> +		dev_err(&hdev->dev, "cannot allocate MosArt data\n");
> +		return -ENOMEM;
> +	}
> +	td->valid = false;
> +	td->activity = false;
> +	td->activity_now = false;
> +	td->first = false;
> +	hid_set_drvdata(hdev, td);
> +
> +	/* currently, it's better to have one evdev device only */
> +#if 0
> +	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
> +#endif

Could you please explain what is this about?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
