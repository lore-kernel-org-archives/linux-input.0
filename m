From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: joydev: Fix JSIOCSAXMAP ioctl.
Date: Tue, 21 Sep 2010 01:03:42 -0700
Message-ID: <20100921080342.GA1365@core.coreip.homeip.net>
References: <1285051885-20417-1-git-send-email-kwwaters@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62718 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab0IUIDs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 04:03:48 -0400
Content-Disposition: inline
In-Reply-To: <1285051885-20417-1-git-send-email-kwwaters@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kenneth Waters <kwwaters@gmail.com>
Cc: steve@sk2.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 20, 2010 at 11:51:25PM -0700, Kenneth Waters wrote:
> Fixed JSIOCSAXMAP ioctl to update absmap, the map from hardware axis to
> event axis in addition to abspam.  This fixes a regression introduced
> by 999b874f.
> 
> Signed-off-by: Kenneth Waters <kwwaters@gmail.com>

Applied, thank you Kenneth.

> ---
>  drivers/input/joydev.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index d85bd8a..22239e9 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -483,6 +483,9 @@ static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
>  
>  	memcpy(joydev->abspam, abspam, len);
>  
> +	for (i = 0; i < joydev->nabs; i++)
> +		joydev->absmap[joydev->abspam[i]] = i;
> +
>   out:
>  	kfree(abspam);
>  	return retval;
> -- 
> 1.7.2.2
> 

-- 
Dmitry
