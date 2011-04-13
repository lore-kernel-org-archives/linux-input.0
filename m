From: Eduard Hasenleithner <ehasenle@gmail.com>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED control
Date: Wed, 13 Apr 2011 11:08:06 +0200
Message-ID: <BANLkTimWMNm7siYXXA2=3cmd+VY=wCcdOA@mail.gmail.com>
References: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39254 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895Ab1DMJIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 05:08:07 -0400
Received: by iwn34 with SMTP id 34so400076iwn.19
        for <linux-input@vger.kernel.org>; Wed, 13 Apr 2011 02:08:06 -0700 (PDT)
In-Reply-To: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduard Hasenleithner <eduard@hasenleithner.at>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Dmitry.

Did this new patch reach your inbox?

Thanks,
Eduard

2011/4/9 Eduard Hasenleithner <eduard@hasenleithner.at>:
> This commit enables control of the LEDs and OLED displays found
> on the Wacom Intuos4 M, L, and XL. For this purpose, a new "led"
> attribute group is added to the sysfs entry of the input device.
>
> This "led" group only shows up when the correct device (M, L,
> or XL) is detected. Four write-only attributes are created:
> * "luminance":
> =C2=A0 =C2=A0 =C2=A0 =C2=A0array of three integers specfying
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* status led brightness when no button is =
pressed (0..127)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* status led brightness when a button is p=
ressed (0..127)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* brightness of the OLED display (0..15)
> * "status_select":
> =C2=A0 =C2=A0 =C2=A0 =C2=A0specifies the id (0..3) of the status led,=
 -1 =3D none
> * "button_select":
> =C2=A0 =C2=A0 =C2=A0 =C2=A0specifies the button id (0..7) of the imag=
e
> * "button_rawimg":
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sets the raw image data of the button (bin=
ary, 1024 octets)
>
> Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
