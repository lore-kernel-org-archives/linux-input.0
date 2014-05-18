From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] synaptics: Change min/max quirk table to pnp-id
 matching
Date: Sun, 18 May 2014 13:35:36 -0700
Message-ID: <20140518203535.GA13276@core.coreip.homeip.net>
References: <1400266009-5436-1-git-send-email-hdegoede@redhat.com>
 <1400266009-5436-4-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41780 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbaERUfi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 May 2014 16:35:38 -0400
Content-Disposition: inline
In-Reply-To: <1400266009-5436-4-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org

On Fri, May 16, 2014 at 08:46:49PM +0200, Hans de Goede wrote:
> Most of the affected models share pnp-ids for the touchpad. So switching
> to pnp-ids give us 2 advantages:
> 1) It shrinks the quirk list
> 2) It will lower the new quirk addition frequency, ie the recently added W540
>    quirk would not have been necessary since it uses the same LEN0034 pnp ids
>    as other models already added before it
> 
> As an added bonus it actually puts the quirk on the actual psmouse, rather then
> on the machine, which is technically more correct.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/mouse/synaptics.c | 149 ++++++++++------------------------------
>  1 file changed, 36 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 395ec9c..c5ec703 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -117,6 +117,31 @@ void synaptics_reset(struct psmouse *psmouse)
>  }
>  
>  #ifdef CONFIG_MOUSE_PS2_SYNAPTICS
> +struct min_max_quirk {
> +	const char * const *pnp_ids;
> +	int x_min, x_max, y_min, y_max;
> +};


Why don't we define this as 1 quirk per PNP id?

struct min_max_quirk {
	const char *pnp_id;
	int x_min, x_max, y_min, y_max;
};

?

Thanks.

-- 
Dmitry
