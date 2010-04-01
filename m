From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH v6 1/8] hid: new driver for PicoLCD device
Date: Thu, 1 Apr 2010 18:58:45 +0200
Message-ID: <201004011858.45859.oliver@neukum.org>
References: <20100324233707.7243b04d@neptune.home> <20100330223224.18fe4f3e@neptune.home> <20100330223350.32044891@neptune.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:55428 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab0DBIqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Apr 2010 04:46:35 -0400
In-Reply-To: <20100330223350.32044891@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>

Am Dienstag, 30. M=C3=A4rz 2010 22:33:50 schrieb Bruno Pr=C3=A9mont:
> +static ssize_t picolcd_operation_mode_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_=
t count)
> +{
> +       struct picolcd_data *data =3D dev_get_drvdata(dev);
> +       struct hid_report *report =3D NULL;
> +       size_t cnt =3D count;
> +       int timeout =3D 5000;
> +       unsigned u;
> +       unsigned long flags;
> +
> +       if (cnt >=3D 3 && strncmp("lcd", buf, 3) =3D=3D 0) {
> +               if (data->status & PICOLCD_BOOTLOADER)
> +                       report =3D picolcd_out_report(REPORT_EXIT_FLA=
SHER, data->hdev);
> +               buf +=3D 3;
> +               cnt -=3D 3;
> +       } else if (cnt >=3D 10 && strncmp("bootloader", buf, 10) =3D=3D=
 0) {
> +               if (!(data->status & PICOLCD_BOOTLOADER))
> +                       report =3D picolcd_out_report(REPORT_EXIT_KEY=
BOARD, data->hdev);
> +               buf +=3D 10;
> +               cnt -=3D 10;
> +       }
> +       if (!report)
> +               return -EINVAL;
> +
> +       while (cnt > 0 && (*buf =3D=3D ' ' || *buf =3D=3D '\t')) {
> +               buf++;
> +               cnt--;
> +       }
> +       while (cnt > 0 && (buf[cnt-1] =3D=3D '\n' || buf[cnt-1] =3D=3D=
 '\r'))
> +               cnt--;
> +       if (cnt > 0) {
> +               if (sscanf(buf, "%u", &u) !=3D 1)
> +                       return -EINVAL;
> +               if (u > 30000)
> +                       return -EINVAL;
> +               else
> +                       timeout =3D u;
> +       }
> +
> +       spin_lock_irqsave(&data->lock, flags);
> +       hid_set_field(report->field[0], 0, timeout & 0xff);
> +       hid_set_field(report->field[0], 1, (timeout >> 8) & 0xff);
> +       usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
> +       spin_unlock_irqrestore(&data->lock, flags);
> +       return count;
> +}
> +
> +static DEVICE_ATTR(operation_mode, 0644, picolcd_operation_mode_show=
,
> +               picolcd_operation_mode_store);

This violates the one file =3D=3D one attribute rule.
Can you change this interface?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
