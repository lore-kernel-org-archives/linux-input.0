From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH v6 7/8, needs improvement] hid: add suspend/resume hooks for hid drivers
Date: Sun, 11 Apr 2010 15:38:30 +0200
Message-ID: <201004111538.31009.oliver@neukum.org>
References: <20100324233707.7243b04d@neptune.home> <alpine.LNX.2.00.1003311415000.24576@pobox.suse.cz> <20100411130226.4086a92d@neptune.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:34234 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab0DKNic convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 09:38:32 -0400
In-Reply-To: <20100411130226.4086a92d@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>

Am Sonntag, 11. April 2010 13:02:26 schrieb Bruno Pr=C3=A9mont:
> Where do I find the bluetooth HID bits? I've been searching through k=
ernel
> sources (under drivers/) but did not find bluetooth code trying to
> register a HID device...

net/bluetooth/hidp/core.c

> Below an updated patch which also calls the hook for auto-suspend cas=
e.
> The patch compiles but I've not runtime-tested it yet (especially for
> the auto-suspend part, as I'm not sure what should trigger it).

Looks basically good.

> As far as I understand the code, in auto-suspend case if the driver
> sends commands to the device it will have to call usbhid_wait_io().
> Please correct me if I'm wrong!

No, only if it wants to know that the command has finished.
hid_submit_out() will queue IO in the autosuspended case
and schedule a resumption.

> @@ -629,6 +632,11 @@ struct hid_driver {
>         int (*input_mapped)(struct hid_device *hdev,
>                         struct hid_input *hidinput, struct hid_field =
*field,
>                         struct hid_usage *usage, unsigned long **bit,=
 int *max);
> +#ifdef CONFIG_PM
> +       int (*suspend)(struct hid_device *hdev, int auto_suspend);

It would be better to pass the full message.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
