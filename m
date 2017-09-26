From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - pr_err() strings should end with
 newlines
Date: Tue, 26 Sep 2017 09:15:39 +0200
Message-ID: <20170926071539.GD1063@mail.corp.redhat.com>
References: <bd3d877929973f6da9d9be35c3fa395294b27239.1506409239.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965122AbdIZHPp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 03:15:45 -0400
Content-Disposition: inline
In-Reply-To: <bd3d877929973f6da9d9be35c3fa395294b27239.1506409239.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arvind,

On Sep 26 2017 or thereabouts, Arvind Yadav wrote:
> pr_err() messages should end with a new-line to avoid other messages
> being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/rmi4/rmi_f11.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index bc5e37f..28296a9 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -596,7 +596,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
>  			/* Possible of having 4 fingers per f_state register */
>  			finger_state = rmi_f11_parse_finger_state(f_state, i);
>  			if (finger_state == F11_RESERVED) {
> -				pr_err("Invalid finger state[%d]: 0x%02x", i,
> +				pr_err("Invalid finger state[%d]: 0x%02x\n", i,

I am pretty sure not having the '\n' is the correct behavior.

Linus recently complained[1] about people trying to "fix" the printk
behavior, and it resulted that any printk will be shown on its own line
(unless there is an other printk with a KERN_CONT marker, which is
unlikely to happen). So basically such patch doesn't add much.

I am also pretty sure there has already been a thread[2 and others]
about these '\n' and from what I can remember, the end result was that
not having the line termination was the preferred syntax.

Cheers,
Benjamin

[1] https://lkml.org/lkml/2017/8/29/504
[2] https://lkml.org/lkml/2010/11/23/394

>  					finger_state);
>  				continue;
>  			}
> -- 
> 1.9.1
> 
