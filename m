From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v4 2/2] elantech: Call psmouse_reset when elantech
 probe fails
Date: Fri, 22 Aug 2014 17:11:44 -0700
Message-ID: <20140823001144.GC24242@core.coreip.homeip.net>
References: <1408558692-11736-1-git-send-email-ulrik.debie-os@e2big.org>
 <1408558692-11736-3-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:61986 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbaHXVwh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Aug 2014 17:52:37 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so18947403pdj.16
        for <linux-input@vger.kernel.org>; Sun, 24 Aug 2014 14:52:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408558692-11736-3-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On Wed, Aug 20, 2014 at 08:18:12PM +0200, Ulrik De Bie wrote:
> elantech_init() calls elantech_set_absolute_mode which sets the driver in
> an absolute mode. When after this the elantech_init fails, it is best
> to turn the ps/2 mouse emulation mode back on by calling psmouse_reset()
> so that it can work as a regular mouse.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 5dd620a..771291c 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1620,6 +1620,7 @@ int elantech_init(struct psmouse *psmouse)
>  	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
>  			   &elantech_attr_group);
>   init_fail:
> +	psmouse_reset(psmouse);
>  	kfree(etd);
>  	return error;
>  }
> -- 
> 2.1.0.rc1
> 

-- 
Dmitry
