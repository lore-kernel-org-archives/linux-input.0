From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 2/2] elantech: Call psmouse_reset when elantech probe
 fails
Date: Tue, 17 Jun 2014 08:08:40 +0200
Message-ID: <539FDB68.5040804@redhat.com>
References: <CANq1E4S5xVuWO3THy2rB5O_8fsLeYCWAres2Xk5Pf1j1_Po=og@mail.gmail.com> <1402955589-23709-1-git-send-email-ulrik.debie-os@e2big.org> <1402955589-23709-3-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46494 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881AbaFQGIo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2014 02:08:44 -0400
In-Reply-To: <1402955589-23709-3-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>

Hi,

On 06/16/2014 11:53 PM, Ulrik De Bie wrote:
> elantech_init() calls elantech_set_absolute_mode which sets the driver in
> an absolute mode. When after this the elantech_init fails, it is best
> to turn the ps/2 mouse emulation mode back on by calling psmouse_reset()
> so that it can work as a regular mouse.
> 
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>

Looks good, this patch is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

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
> 
