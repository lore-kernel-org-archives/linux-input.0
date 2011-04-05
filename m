From: Eduard Hasenleithner <ehasenle@gmail.com>
Subject: Re: [PATCH v2] Wacom Intuos4 LED and OLED support
Date: Tue, 5 Apr 2011 20:12:07 +0200
Message-ID: <BANLkTimvgdahQyu94Ep=C8JU_Cfra_kdjg@mail.gmail.com>
References: <1301817429-12782-1-git-send-email-eduard@hasenleithner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48298 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab1DESMI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 14:12:08 -0400
Received: by iwn34 with SMTP id 34so625848iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 11:12:08 -0700 (PDT)
In-Reply-To: <1301817429-12782-1-git-send-email-eduard@hasenleithner.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry.

I have been encouraged by Ping Cheng to submit the OLED matrix display
patch for the Intuos4 to the linux-input mailing list. In absence of
any comment by you on this issue, I'm a bit lost. Could you give
something like a quick ACK (e.g. you will have a look into it later,
when you have time) or NACK (e.g. no way for inclusion, needs major
change, ...).

Thanks,
Eduard

2011/4/3 Eduard Hasenleithner <eduard@hasenleithner.at>:
> This commit enables control of the LEDs and OLED displays found
> on the Wacom Intuos4 M, L, and XL. For this purpose, an IOCTL
> interface is added to the wacom input driver. The IOCTLs can be
> issued on the raw USB device of the tablet.
>
> Summary of changes:
> * A new ioctl-number (0xB2) for the Wacom IOCTL is allocated.
> * A new header file for the IOCTLs is introduced
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(include/linux/usb/wacom-dev.h)
> * Implementation of LED and OLED control in wacom_wac.c
>
> Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
