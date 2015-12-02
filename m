From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: psmouse - rename ps2pp_init() to ps2pp_detect()
Date: Wed, 2 Dec 2015 11:26:18 -0800
Message-ID: <20151202192618.GA24386@dtor-ws>
References: <20151202192044.GA12580@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35045 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbbLBT0V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 14:26:21 -0500
Content-Disposition: inline
In-Reply-To: <20151202192044.GA12580@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2015 at 11:20:44AM -0800, Dmitry Torokhov wrote:
> This makes Logitech PS2++ protocol implementation consistent with
> the naming in other protocols.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Well, if I did not forget to add drivers/input/mouse/logips2pp.c that
woudl be better...

> ---
>  drivers/input/mouse/logips2pp.h    | 4 ++--
>  drivers/input/mouse/psmouse-base.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/logips2pp.h b/drivers/input/mouse/logips2pp.h
> index 0c186f0..075fd32 100644
> --- a/drivers/input/mouse/logips2pp.h
> +++ b/drivers/input/mouse/logips2pp.h
> @@ -12,9 +12,9 @@
>  #define _LOGIPS2PP_H
>  
>  #ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
> -int ps2pp_init(struct psmouse *psmouse, bool set_properties);
> +int ps2pp_detect(struct psmouse *psmouse, bool set_properties);
>  #else
> -inline int ps2pp_init(struct psmouse *psmouse, bool set_properties)
> +static inline int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
>  {
>  	return -ENOSYS;
>  }
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index e909c6e..90d9218 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -699,7 +699,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>  		.type		= PSMOUSE_PS2PP,
>  		.name		= "PS2++",
>  		.alias		= "logitech",
> -		.detect		= ps2pp_init,
> +		.detect		= ps2pp_detect,
>  	},
>  #endif
>  	{
> -- 
> 2.6.0.rc2.230.g3dd15c0
> 
> 
> -- 
> Dmitry

-- 
Dmitry
