From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Thu, 27 Oct 2016 16:19:42 -0700
Message-ID: <20161027231942.GB12312@dtor-ws>
References: <1477603873-9143-1-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35700 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030400AbcJ0XTq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 19:19:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id s8so3795551pfj.2
        for <linux-input@vger.kernel.org>; Thu, 27 Oct 2016 16:19:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1477603873-9143-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, Oct 27, 2016 at 02:31:13PM -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> The input-mt driver pointer emulation from 'input_mt_sync_frame' regardless
> of the flags passed in to 'input_mt_init_slots' by device drivers.

Right, because needing single-touch (pointer) emulation is not property
of device or driver but rather consumer. If we get to the point where
everything is ready to accept multi-touch (are we there yet) then we can
stop doing pointer emulation altogether.

> 
> Pointer emulation is undesired on drivers, which didn't request this
> capability like the hid-sony driver for the Dualshock 4. This gamepad already
> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation would
> inject touchpad values into these sticks, which is undesired.

The driver should not be re-purposing events like that.
ABS_MT_POSITION_X and ABS_X should match.

Why doesn't driver follow Documentation/input/gamepad.txt?

> 
> This patch checks the flags INPUT_MT_POINTER / INPUT_MT_DIRECT from within
> input_mt_sync_frame to only allow pointer emulation when the feature was
> requested by the driver as the flags were set in input_mt_init_slots.
> ---
>  drivers/input/input-mt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index a1bbec9..30c8128 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -305,7 +305,8 @@ void input_mt_sync_frame(struct input_dev *dev)
>  	if ((mt->flags & INPUT_MT_POINTER) && !(mt->flags & INPUT_MT_SEMI_MT))
>  		use_count = true;
>  
> -	input_mt_report_pointer_emulation(dev, use_count);
> +	if (mt->flags & (INPUT_MT_POINTER | INPUT_MT_DIRECT))
> +		input_mt_report_pointer_emulation(dev, use_count);
>  
>  	mt->frame++;
>  }
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
