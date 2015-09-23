From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid-core: Avoid uninitialized buffer access
Date: Wed, 23 Sep 2015 14:09:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509231409120.30132@pobox.suse.cz>
References: <d1f3f51b2808c78266fec8b786514288defc23a8.1442619093.git.dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47370 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbbIWMJr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 08:09:47 -0400
In-Reply-To: <d1f3f51b2808c78266fec8b786514288defc23a8.1442619093.git.dvhart@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Purdie <richard.purdie@linuxfoundation.org>, linux-input@vger.kernel.org, stable@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>

On Fri, 18 Sep 2015, Darren Hart wrote:

> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> hid_connect adds various strings to the buffer but they're all
> conditional. You can find circumstances where nothing would be written
> to it but the kernel will still print the supposedly empty buffer with
> printk. This leads to corruption on the console/in the logs.
> 
> Ensure buf is initialized to an empty string.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> [dvhart: Initialize string to "" rather than assign buf[0] = NULL;]
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: linux-input@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> ---
>  drivers/hid/hid-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 70a11ac..c0fbf4e 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1611,7 +1611,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>  		"Multi-Axis Controller"
>  	};
>  	const char *type, *bus;
> -	char buf[64];
> +	char buf[64] = "";
>  	unsigned int i;
>  	int len;
>  	int ret;

Applied to hid.git#for-4.3/upstream-fixes.

Thanks,

-- 
Jiri Kosina
SUSE Labs

