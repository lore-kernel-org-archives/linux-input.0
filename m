From: Eduard Hasenleithner <ehasenle@gmail.com>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED control
Date: Fri, 2 Sep 2011 23:48:46 +0200
Message-ID: <CAJur_i+Aegs7ju_iwasE0XB5KWvO6mAFeZVyoqKaE4aC3GDHbg@mail.gmail.com>
References: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>
	<20110506155204.GA4754@core.coreip.homeip.net>
	<4DC421BF.9020204@hasenleithner.at>
	<20110506164301.GA27419@core.coreip.homeip.net>
	<4DC4309B.9080605@hasenleithner.at>
	<BANLkTik2dYnc9tboMdb1KNC_o-YLmMV81w@mail.gmail.com>
	<1304704667.10308.2.camel@Nokia-N900-42-11>
	<loom.20110602T114644-725@post.gmane.org>
	<BANLkTi=E4BEpF0G90q4zNHtVLvpTDhWtvA@mail.gmail.com>
	<20110817071724.GF29361@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62472 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab1IBVsq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Sep 2011 17:48:46 -0400
Received: by iabu26 with SMTP id u26so3433285iab.19
        for <linux-input@vger.kernel.org>; Fri, 02 Sep 2011 14:48:46 -0700 (PDT)
In-Reply-To: <20110817071724.GF29361@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry.

It has been quite some time since our last conversation and I didn't
look in my inbox so frequent.

Thanks for reworking the patch to meet the requirements. The patch
appears to work for the status led, but not for the button images. I
tracked down the problem to a wrong command being used in
wacom_led_putimage. Please see inline. After I changed this line, the
kernel driver was also able to put images. I'd be happy to see the
patch in 3.2, but I'm not in a hurry.

Eduard

2011/8/17 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> +static int wacom_led_putimage(struct wacom *wacom, int button_id, co=
nst void *img)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned char *buf;
> + =C2=A0 =C2=A0 =C2=A0 int i, retval;
> +
> + =C2=A0 =C2=A0 =C2=A0 buf =3D kzalloc(259, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!buf)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Send 'start' command */
> + =C2=A0 =C2=A0 =C2=A0 buf[0] =3D WAC_CMD_ICON_START;
> + =C2=A0 =C2=A0 =C2=A0 buf[1] =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 retval =3D wacom_set_report(wacom->intf, 0x03,=
 WAC_CMD_ICON_START,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf, 2, WAC_CMD_RETRIES);
> + =C2=A0 =C2=A0 =C2=A0 if (retval < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 buf[0] =3D WAC_CMD_ICON_XFER;
> + =C2=A0 =C2=A0 =C2=A0 buf[1] =3D button_id & 0x07;
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < 4; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[2] =3D i;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(buf + 3, im=
g + i * 256, 256);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D wacom_s=
et_report(wacom->intf, 0x03, WAC_CMD_ICON_START,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
buf, 259, WAC_CMD_RETRIES);

Here is the error: WAC_CMD_ICON_START instead of the correct
WAC_CMD_ICON_XFER was used. Don't ask my why the command has to be
specified two times.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Send 'stop' */
> + =C2=A0 =C2=A0 =C2=A0 buf[0] =3D WAC_CMD_ICON_START;
> + =C2=A0 =C2=A0 =C2=A0 buf[1] =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 wacom_set_report(wacom->intf, 0x03, WAC_CMD_IC=
ON_START,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0buf, 2, WAC_CMD_RETRIES);
> +
> +out:
> + =C2=A0 =C2=A0 =C2=A0 kfree(buf);
> + =C2=A0 =C2=A0 =C2=A0 return retval;
> +}
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
