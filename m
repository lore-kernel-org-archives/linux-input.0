From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 0/3] Input: soc_button_array fixes and question
Date: Fri, 13 May 2016 17:57:42 +0200
Message-ID: <CAN+gG=EruMOcE=OjwSwVT89K4xgLtbYUz1wxLhLa_9MnSeE8XA@mail.gmail.com>
References: <1462894673-26560-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34253 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbcEMP5o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 11:57:44 -0400
In-Reply-To: <1462894673-26560-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, Alexandre Courbot <acourbot@nvidia.com>, Lejun Zhu <lejun.zhu@linux.intel.com>

On Tue, May 10, 2016 at 5:37 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi,
>
> This series has been triggered by the Surface 3 I have been given.
> The way Microsoft follows its own specs is always intriguing. As
> written in drivers/platform/x86/surfacepro3_button.c, the PNP0C40
> ACPI device which should follow the specification doesn't have any
> GPIO listed (thus the first 2 patches).
>
> Also, the actual ACPI device that has the GPIO described is declared
> as an I2C one, even if there is no such device attached to the bus.
> This particular device could use the soc_button_array driver after a
> little bit of ACPI magic (patches to follow, later), but each GPIO in
> this device is declared twice (as Int and Io), so the 3rd patch.
>
> Here is my question mentioned in $subject:
>
> Why are we using gpiod_get_index(dev, KBUILD_MODNAME, acpi_index, GPIOD_ASIS);
> in soc_button_lookup_gpio()?
>

I'll leave the question open and send a v2 with an actual support of
the Surface 3 buttons soon.
I'll remove most of the CC-ed people as it might be considered as spam
for most of you.

Cheers,
Benjamin
