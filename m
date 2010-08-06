From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] hid: picolcd: testing the wrong variable
Date: Fri, 6 Aug 2010 14:53:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008061453300.29919@pobox.suse.cz>
References: <20100806062848.GL9031@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52299 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761314Ab0HFMxk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Aug 2010 08:53:40 -0400
In-Reply-To: <20100806062848.GL9031@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, 6 Aug 2010, Dan Carpenter wrote:

> "ref_cnt" is a point to the reference count and it's non-null.  We really
> want to test the reference count itself.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> index 346f0e3..c0bdeba 100644
> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -547,7 +547,7 @@ static void picolcd_fb_destroy(struct fb_info *info)
>  	ref_cnt--;
>  	mutex_lock(&info->lock);
>  	(*ref_cnt)--;
> -	may_release = !ref_cnt;
> +	may_release = !*ref_cnt;
>  	mutex_unlock(&info->lock);
>  	if (may_release) {
>  		framebuffer_release(info);

Thanks a lot for spotting this. Applied.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
