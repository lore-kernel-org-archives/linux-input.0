From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid: 3m: Output proper orientation range
Date: Sun, 19 Sep 2010 16:23:44 -0700
Message-ID: <20100919232343.GA6565@core.coreip.homeip.net>
References: <1284886583-30965-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54142 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0ISXXv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Sep 2010 19:23:51 -0400
Content-Disposition: inline
In-Reply-To: <1284886583-30965-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 19, 2010 at 10:56:23AM +0200, Henrik Rydberg wrote:
> The range of orientation values for height/width devices should
> be [0, 1], but is currently set to [1, 1]. Having min == max also
> breaks uinput device setup. Fixed with this patch.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Makes sense.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

> ---
>  drivers/hid/hid-3m-pct.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-3m-pct.c b/drivers/hid/hid-3m-pct.c
> index cd4b125..860d47c 100644
> --- a/drivers/hid/hid-3m-pct.c
> +++ b/drivers/hid/hid-3m-pct.c
> @@ -110,7 +110,7 @@ static int mmm_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			input_set_abs_params(hi->input, ABS_MT_TOUCH_MINOR,
>  					     f1, f2, df / SN_WIDTH, 0);
>  			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
> -					1, 1, 0, 0);
> +					0, 1, 0, 0);
>  			return 1;
>  		case HID_DG_CONTACTID:
>  			field->logical_maximum = MAX_TRKID;
> -- 
> 1.7.1
> 

-- 
Dmitry
