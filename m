From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] psmouse: Remove hardcoded touchpad size from the
 focaltech driver.
Date: Wed, 18 Feb 2015 11:57:17 -0800
Message-ID: <20150218195717.GB13997@dtor-glaptop>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
 <1423940502-12353-2-git-send-email-mgottschlag@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36820 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbbBRT5V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 14:57:21 -0500
Received: by pabkq14 with SMTP id kq14so3646477pab.3
        for <linux-input@vger.kernel.org>; Wed, 18 Feb 2015 11:57:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423940502-12353-2-git-send-email-mgottschlag@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathias Gottschlag <mgottschlag@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

On Sat, Feb 14, 2015 at 08:01:40PM +0100, Mathias Gottschlag wrote:
> The size has in most cases already been fetched from the touchpad, the
> hardcoded values should have been removed.
> 
> Signed-off-by: Mathias Gottschlag <mgottschlag@gmail.com>
> ---
>  drivers/input/mouse/focaltech.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
> index fca38ba..5d8cf98 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c
> @@ -67,9 +67,6 @@ static void focaltech_reset(struct psmouse *psmouse)
>  
>  #define FOC_MAX_FINGERS 5
>  
> -#define FOC_MAX_X 2431
> -#define FOC_MAX_Y 1663
> -
>  /*
>   * Current state of a single finger on the touchpad.
>   */
> @@ -131,7 +128,7 @@ static void focaltech_report_state(struct psmouse *psmouse)
>  		if (active) {
>  			input_report_abs(dev, ABS_MT_POSITION_X, finger->x);
>  			input_report_abs(dev, ABS_MT_POSITION_Y,
> -					 FOC_MAX_Y - finger->y);
> +					 priv->y_max - finger->y);

I wonder if we also want to camp teh vaue to 0, y_max... I know userspace is OK
with kernel reporting values greater than max value for the axis, but I worry
about negative vaues.

Thanks.

-- 
Dmitry
