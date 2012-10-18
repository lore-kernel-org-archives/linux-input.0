From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: edt-ft5x06 - convert to use simple_open()
Date: Wed, 17 Oct 2012 23:50:45 -0700
Message-ID: <20121018065045.GB12838@core.coreip.homeip.net>
References: <CAPgLHd_P7=SeFYvC8EepyNy7Lm-NUTBokTpMDhFVbS_sfhx+UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57108 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab2JRGut (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Oct 2012 02:50:49 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so8000316pad.19
        for <linux-input@vger.kernel.org>; Wed, 17 Oct 2012 23:50:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPgLHd_P7=SeFYvC8EepyNy7Lm-NUTBokTpMDhFVbS_sfhx+UQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: rydberg@euromail.se, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Wed, Oct 17, 2012 at 04:29:23PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> This removes an open coded simple_open() function and
> replaces file operations references to the function
> with simple_open() instead.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)

Applied, thanks Wei.

> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 099d144..d9c6007 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -491,14 +491,6 @@ static int edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
>  DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
>  			edt_ft5x06_debugfs_mode_set, "%llu\n");
>  
> -static int edt_ft5x06_debugfs_raw_data_open(struct inode *inode,
> -					    struct file *file)
> -{
> -	file->private_data = inode->i_private;
> -
> -	return 0;
> -}
> -
>  static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
>  				char __user *buf, size_t count, loff_t *off)
>  {
> @@ -579,7 +571,7 @@ out:
>  
>  
>  static const struct file_operations debugfs_raw_data_fops = {
> -	.open = edt_ft5x06_debugfs_raw_data_open,
> +	.open = simple_open,
>  	.read = edt_ft5x06_debugfs_raw_data_read,
>  };
>  
> 
> 

-- 
Dmitry
