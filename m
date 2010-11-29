From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH] input/tc3589x: add support for tc3589x driver
Date: Mon, 29 Nov 2010 07:39:48 +0100
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B1804713A939C@EXDCVYMBSTM006.EQ1STM.local>
References: <1290783913-30728-1-git-send-email-sundar.iyer@stericsson.com>
 <0680EC522D0CC943BC586913CF3768C004137FE6A8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:38461 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751184Ab0K2GkP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Nov 2010 01:40:15 -0500
In-Reply-To: <0680EC522D0CC943BC586913CF3768C004137FE6A8@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "ken.lierman@windriver.com" <ken.lierman@windriver.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "alan@linux.intel.com" <alan@linux.intel.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Rabin VINCENT <rabin.vincent@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Shubhra/Dmitry,

Thanx for your comments.

>-----Original Message-----
>From: Datta, Shubhrajyoti [mailto:shubhrajyoti@ti.com]
>
>Be careful about the permissions.
>
>This need not be __devinit as the sysfs hooks may need it.
>
>Could you use tabs instead of spaces here.

>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>
>The driver looks very reasonably with the exception of enable/disable
>sysfs attribute and its handling. As I mentioned in few other threads we
>can't keep adding custom PM methods to the drivers; instead we need to
>move this functionality into PM/driver core and allow userspace
>accelerate putting devices into low power state.
>
>BTW, I think spotted a few instances of space vs tab indentation and a
>few pointless casts from (void *).

As I mentioned, this is not the final patch. This patch is for Ken to try to work
out the TC35894 keypad in this MFD plugged-in driver. I don't have access to the
TC35894 data sheet; but going through the register definitions in the patch posted
by Alan, I don't see any register changes and the same driver *should* just work out fine.

Anyways I will re-post this series updated with your and Dmitry's comments. I also need to
push out the TC35892 MFD driver updated to the MFD maintainer also.

Cheers!
