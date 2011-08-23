From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch 2/2 -next v2] hid-lg4ff: add a kfree() to an error path
Date: Tue, 23 Aug 2011 10:46:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108231046030.13644@pobox.suse.cz>
References: <20110818134343.GB21927@shale.localdomain> <4E4D2E4A.3020205@bfs.de> <20110819080055.GH21927@shale.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53094 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754538Ab1HWIqK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 04:46:10 -0400
In-Reply-To: <20110819080055.GH21927@shale.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: walter harms <wharms@bfs.de>, open@bfs.de, list@bfs.de, HID CORE LAYER <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Fri, 19 Aug 2011, Dan Carpenter wrote:

> There is a small rare potential memory leak here.  Also Walter Harms
> points out that we can do a small cleanup as well by using kstrdup().
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> index dc38c2d..cbb0089 100644
> --- a/drivers/hid/hid-lg4ff.c
> +++ b/drivers/hid/hid-lg4ff.c
> @@ -435,12 +435,12 @@ int lg4ff_init(struct hid_device *hid)
>  		hid_err(hid, "Cannot add device, insufficient memory.\n");
>  		return -ENOMEM;
>  	}
> -	entry->device_id = (char *)kzalloc(strlen((&hid->dev)->kobj.name) + 1, GFP_KERNEL);
> +	entry->device_id = kstrdup((&hid->dev)->kobj.name, GFP_KERNEL);
>  	if (!entry->device_id) {
>  		hid_err(hid, "Cannot set device_id, insufficient memory.\n");
> +		kfree(entry);
>  		return -ENOMEM;
>  	}
> -	strcpy(entry->device_id, (&hid->dev)->kobj.name);
>  	entry->min_range = lg4ff_devices[i].min_range;
>  	entry->max_range = lg4ff_devices[i].max_range;
>  	entry->set_range = lg4ff_devices[i].set_range;
> 

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
