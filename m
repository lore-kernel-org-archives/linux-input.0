From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: sentelic - silence some underflow warnings
Date: Fri, 21 Aug 2015 09:33:36 -0700
Message-ID: <20150821163336.GD26302@localhost>
References: <20150821084656.GA25369@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35653 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbHUQdk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 12:33:40 -0400
Content-Disposition: inline
In-Reply-To: <20150821084656.GA25369@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, Aug 21, 2015 at 11:46:56AM +0300, Dan Carpenter wrote:
> I have a static checker that complains when we check for an upper bound
> but don't have a coresponding check for a lower bound.  With this code,
> the upper bound check seems not really required, so it is not a bug to
> leave the lower bound check out as well.  But let's silence the warning
> by making these variables unsigned.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thank you.

> 
> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> index cc7e0d4..11c32ac 100644
> --- a/drivers/input/mouse/sentelic.c
> +++ b/drivers/input/mouse/sentelic.c
> @@ -432,7 +432,7 @@ static int fsp_onpad_hscr(struct psmouse *psmouse, bool enable)
>  static ssize_t fsp_attr_set_setreg(struct psmouse *psmouse, void *data,
>  				   const char *buf, size_t count)
>  {
> -	int reg, val;
> +	unsigned int reg, val;
>  	char *rest;
>  	ssize_t retval;
>  
> @@ -440,7 +440,7 @@ static ssize_t fsp_attr_set_setreg(struct psmouse *psmouse, void *data,
>  	if (rest == buf || *rest != ' ' || reg > 0xff)
>  		return -EINVAL;
>  
> -	retval = kstrtoint(rest + 1, 16, &val);
> +	retval = kstrtouint(rest + 1, 16, &val);
>  	if (retval)
>  		return retval;
>  
> @@ -476,9 +476,10 @@ static ssize_t fsp_attr_set_getreg(struct psmouse *psmouse, void *data,
>  					const char *buf, size_t count)
>  {
>  	struct fsp_data *pad = psmouse->private;
> -	int reg, val, err;
> +	unsigned int reg, val;
> +	int err;
>  
> -	err = kstrtoint(buf, 16, &reg);
> +	err = kstrtouint(buf, 16, &reg);
>  	if (err)
>  		return err;
>  
> @@ -511,9 +512,10 @@ static ssize_t fsp_attr_show_pagereg(struct psmouse *psmouse,
>  static ssize_t fsp_attr_set_pagereg(struct psmouse *psmouse, void *data,
>  					const char *buf, size_t count)
>  {
> -	int val, err;
> +	unsigned int val;
> +	int err;
>  
> -	err = kstrtoint(buf, 16, &val);
> +	err = kstrtouint(buf, 16, &val);
>  	if (err)
>  		return err;
>  

-- 
Dmitry
