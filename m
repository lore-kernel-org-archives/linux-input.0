From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add Alps touchpad 73 03 0a support
Date: Thu, 4 Oct 2012 00:25:38 -0700
Message-ID: <20121004072538.GE14217@core.coreip.homeip.net>
References: <506BA4FE.509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44138 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2JDHZm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Oct 2012 03:25:42 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so315947pbb.19
        for <linux-input@vger.kernel.org>; Thu, 04 Oct 2012 00:25:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <506BA4FE.509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Bludov <pbludov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Pavel,

On Wed, Oct 03, 2012 at 11:37:50AM +0900, Pavel Bludov wrote:
> Hi Dmitry,
> the patch is trivial:
> 
> E7 report is 73 03 0a
> command mode response is 88 08 1c
> absolute mode controlled by register c2c4


It looks like you mailer mangled the patch by line-wrapping it, and I
would also need your "Signed-off-by: ..." to be able to apply the patch.

Thanks!

> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index cf5af1f..1b640f2 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -112,6 +112,7 @@ static const struct alps_model_info
> alps_model_data[] = {
>         { { 0x73, 0x02, 0x64 }, 0x9b, ALPS_PROTO_V3, 0x8f, 0x8f,
> ALPS_DUALPOINT },
>         { { 0x73, 0x02, 0x64 }, 0x9d, ALPS_PROTO_V3, 0x8f, 0x8f,
> ALPS_DUALPOINT },
>         { { 0x73, 0x02, 0x64 }, 0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
> +       { { 0x73, 0x03, 0x0a }, 0x1c, ALPS_PROTO_V3, 0x8f, 0x8f, 0 },
>  };
> 
>  /*
> @@ -983,7 +984,7 @@ static int alps_enter_command_mode(struct
> psmouse *psmouse,
>                 return -1;
>         }
> 
> -       if (param[0] != 0x88 && param[1] != 0x07) {
> +       if (param[0] != 0x88 && param[1] != 0x07 && param[1] != 0x08) {
>                 psmouse_dbg(psmouse,
>                             "unknown response while entering command
> mode: %2.2x %2.2x %2.2x\n",
>                             param[0], param[1], param[2]);
> @@ -1302,6 +1303,12 @@ static int alps_hw_init_v3(struct psmouse *psmouse)
>         if (alps_enter_command_mode(psmouse, NULL))
>                 goto error;
> 
> +       reg_val = alps_command_mode_read_reg(psmouse, 0xc2c8);
> +       if (reg_val == 0) {
> +               if (alps_command_mode_write_reg(psmouse, 0xc2c4, 0x02))
> +                       goto error;
> +       }
> +
>         /* Check for trackstick */
>         reg_val = alps_command_mode_read_reg(psmouse, 0x0008);
>         if (reg_val == -1)
> 

-- 
Dmitry
