From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 0/3] input - wacom_w8001: support one finger touch etc.
Date: Fri, 17 Dec 2010 13:21:07 -0800
Message-ID: <AANLkTim3XdFHEtcaJOCre22ECVKPDgwagHT71Cxq1yc3@mail.gmail.com>
References: <1292607369-22534-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:58340 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab0LQVVK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 16:21:10 -0500
Received: by wwi17 with SMTP id 17so956426wwi.1
        for <linux-input@vger.kernel.org>; Fri, 17 Dec 2010 13:21:08 -0800 (PST)
In-Reply-To: <1292607369-22534-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Chris,

Does this patchset address your comments? I didn't add your
reviewed-by since I want to get it from you directly.

Thank you.

Ping

On Fri, Dec 17, 2010 at 9:36 AM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> This is the v2 of adding one finger touch support for Wacom serial to=
uchscreen.
> It converts input_dev->keybit to __set_bit, supports pen or touch onl=
y devices,
> and adds one finger touch support to the driver.
>
> The patchset is based on git://git.kernel.org/pub/scm/linux/kernel/gi=
t/dtor/input.git next
>
> Ping Cheng (3):
> =A0 =A0 =A0input - wacom_w8001: use __set_bit to set keybits
> =A0 =A0 =A0input - wacom_w8001: Support pen or touch only devices
> =A0 =A0 =A0input - wacom_w8001: Add one finger touch support
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
