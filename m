From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mouse: lifebook: Fixed tabbing issue.
Date: Fri, 20 Mar 2015 09:37:21 -0700
Message-ID: <20150320163721.GA21014@dtor-ws>
References: <1426819047-7518-1-git-send-email-turnerbk84@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35468 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbCTQh1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2015 12:37:27 -0400
Received: by ieclw3 with SMTP id lw3so96661036iec.2
        for <linux-input@vger.kernel.org>; Fri, 20 Mar 2015 09:37:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426819047-7518-1-git-send-email-turnerbk84@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Brian K. Turner" <turnerbk84@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Mar 19, 2015 at 04:37:27PM -1000, Brian K. Turner wrote:
> Fixed a style issue where spaces where used instead of tabs.
> 
> Signed-off-by: Brian K. Turner <turnerbk84@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/lifebook.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
> index 23222dd..e5ed216 100644
> --- a/drivers/input/mouse/lifebook.c
> +++ b/drivers/input/mouse/lifebook.c
> @@ -256,8 +256,8 @@ static void lifebook_disconnect(struct psmouse *psmouse)
>  
>  int lifebook_detect(struct psmouse *psmouse, bool set_properties)
>  {
> -        if (!lifebook_present)
> -                return -1;
> +	if (!lifebook_present)
> +		return -1;
>  
>  	if (desired_serio_phys &&
>  	    strcmp(psmouse->ps2dev.serio->phys, desired_serio_phys))
> @@ -268,7 +268,7 @@ int lifebook_detect(struct psmouse *psmouse, bool set_properties)
>  		psmouse->name = "Lifebook TouchScreen";
>  	}
>  
> -        return 0;
> +	return 0;
>  }
>  
>  static int lifebook_create_relative_device(struct psmouse *psmouse)
> -- 
> 2.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
