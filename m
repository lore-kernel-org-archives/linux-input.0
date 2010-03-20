From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Free the right keymap
Date: Fri, 19 Mar 2010 23:00:40 -0700
Message-ID: <20100320060040.GA27766@core.coreip.homeip.net>
References: <20100320044016.GA32767@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57247 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0CTGBU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 02:01:20 -0400
Received: by gwaa18 with SMTP id a18so148513gwa.19
        for <linux-input@vger.kernel.org>; Fri, 19 Mar 2010 23:00:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100320044016.GA32767@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, linux-input@vger.kernel.org

On Sat, Mar 20, 2010 at 12:40:16PM +0800, Yong Wang wrote:
> map is allocated in sparse_keymap_setup() and it should be freed
> instead of keymap.
> 

Indeed, thank you Yung.

> Signed-off-by: Yong Wang <yong.y.wang@intel.com>
> ---
>  drivers/input/sparse-keymap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
> index e6bde55..f64e004 100644
> --- a/drivers/input/sparse-keymap.c
> +++ b/drivers/input/sparse-keymap.c
> @@ -163,7 +163,7 @@ int sparse_keymap_setup(struct input_dev *dev,
>  	return 0;
>  
>   err_out:
> -	kfree(keymap);
> +	kfree(map);
>  	return error;
>  
>  }

-- 
Dmitry
