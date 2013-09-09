From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: ALPS Touchpad- Improve the performance of
 alps v5-protocol's touchpad
Date: Mon, 9 Sep 2013 09:27:34 -0700
Message-ID: <20130909162734.GC25107@core.coreip.homeip.net>
References: <89B48266C4EEC447B3A3A031C8DE21870263AF93@SIXPRD0410MB394.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:40470 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab3IIQ1h (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 12:27:37 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so6434435pdi.33
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 09:27:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <89B48266C4EEC447B3A3A031C8DE21870263AF93@SIXPRD0410MB394.apcprd04.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "yunkang.tang@cn.alps.com" <yunkang.tang@cn.alps.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Tommy,

On Thu, Sep 05, 2013 at 05:50:55AM +0000, yunkang.tang@cn.alps.com wrote:
> <Change list>
> - Add the macro definition for v5 device.
> 
> --- linux-3.11/drivers/input/mouse/alps.h.orig 2013-09-04 19:51:33.837135870 +0800
> +++ linux-3.11/drivers/input/mouse/alps.h 2013-09-05 21:01:57.074314890 +0800
> @@ -18,6 +18,10 @@
>  #define ALPS_PROTO_V4 4
>  #define ALPS_PROTO_V5 5
>  
> +#define DOLPHIN_COUNT_PER_ELECTRODE 64
> +#define DOLPHIN_PROFILE_XOFFSET  8 /* [DOLPHIN] The number of the x-electrode offset value */
> +#define DOLPHIN_PROFILE_YOFFSET  1 /* [DOLPHIN] The number of the y-electrode offset value */
> +
>  /**
>   * struct alps_model_info - touchpad ID table
>   * @signature: E7 response string to match.
> @@ -69,7 +73,7 @@ struct alps_nibble_commands {
>   * @y: Y position for ST.
>   * @z: Z position for ST.
>   * @first_mp: Packet is the first of a multi-packet report.
> - * @is_mp: Packet is part of a multi-packet report.
> + * @is_mp: Packet is the last of a multi-packet report.
>   * @left: Left touchpad button is active.
>   * @right: Right touchpad button is active.
>   * @middle: Middle touchpad button is active.
> @@ -145,7 +149,7 @@ struct alps_data {
>  
>   int (*hw_init)(struct psmouse *psmouse);
>   void (*process_packet)(struct psmouse *psmouse);
> - void (*decode_fields)(struct alps_fields *f, unsigned char *p);
> + void (*decode_fields)(struct alps_fields *f, unsigned char *p, struct psmouse *psmouse);
>   void (*set_abs_params)(struct alps_data *priv, struct input_dev *dev1);
>  
>   int prev_fin;

Please do not separate changes in header files form changes in .c files
because patches need to be complete. If I were to apply this patch alone
it would break the compilation.

Thanks.

-- 
Dmitry
