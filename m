From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Date: Wed, 24 Feb 2010 19:27:53 +0100
Message-ID: <201002241927.53532.oliver@neukum.org>
References: <20100221002001.0a7e05a7@neptune.home> <20100224170049.0d04af3c@neptune.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:48610 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471Ab0BXS2P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Feb 2010 13:28:15 -0500
In-Reply-To: <20100224170049.0d04af3c@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>

Am Mittwoch, 24. Februar 2010 17:00:49 schrieb Bruno Pr=C3=A9mont:
> +static int picolcd_raw_event(struct hid_device *hdev,
> +               struct hid_report *report, u8 *raw_data, int size)
> +{
> +       struct picolcd_data *data =3D hid_get_drvdata(hdev);
> +       char hexdata[25];
> +       int i;
> +
> +       if (data =3D=3D NULL)
> +               return 1;
> +
> +       for (i =3D 0; i < sizeof(hexdata) / 2; i++)
> +               sprintf(hexdata+2*i, "%02hhx", raw_data[i]);
> +       if (size >=3D sizeof(hexdata)/2) {
> +               hexdata[sizeof(hexdata)-4] =3D '.';
> +               hexdata[sizeof(hexdata)-3] =3D '.';
> +               hexdata[sizeof(hexdata)-2] =3D '.';
> +               hexdata[sizeof(hexdata)-1] =3D '\0';
> +       } else
> +               hexdata[size*2] =3D '\0';
> +
> +       switch (report->id) {
> +       case REPORT_KEYPAD:
> +               if (size =3D=3D 3 && raw_data[0] =3D=3D 0x11 && data-=
>input_keys) {
> +                       return picolcd_raw_keypad(hdev, report, raw_d=
ata+1, size-1);
> +               } else {
> +                       dbg_hid(PICOLCD_NAME " unsupported key event =
(%d bytes): 0x%s\n", size, hexdata);
> +                       break;
> +               }
> +               break;
> +       case REPORT_VERSION:
> +               if (size =3D=3D 3)
> +                       dev_info(&hdev->dev, "Firmware version is %hd=
=2E%hd\n", raw_data[1], raw_data[2]);
> +
> +               spin_lock(&data->lock);

If I recall correctly raw_event is called in interrupt. As you take a s=
pinlock here,
the lock in code not called in interrupt must disable interrupts, or yo=
u may
deadlock.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
