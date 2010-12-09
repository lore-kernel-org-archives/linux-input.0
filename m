From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2]input - wacom_w8001: Add one finger touch support
Date: Thu, 9 Dec 2010 09:39:09 -0800
Message-ID: <AANLkTinMKDjT9eTJkvvstYG_7LSs7mhcPCRrMsQAANhh@mail.gmail.com>
References: <1291857829-13804-1-git-send-email-pinglinux@gmail.com>
	<20101209064439.GB6233@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38604 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab0LIRjL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 12:39:11 -0500
Received: by wwa36 with SMTP id 36so2722893wwa.1
        for <linux-input@vger.kernel.org>; Thu, 09 Dec 2010 09:39:10 -0800 (PST)
In-Reply-To: <20101209064439.GB6233@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 8, 2010 at 10:44 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Dec 08, 2010 at 05:23:49PM -0800, Ping Cheng wrote:
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 74 ++++++++++++++++=
+++++++++++++--
>> =A01 files changed, 70 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input=
/touchscreen/wacom_w8001.c
>> index 90b92e8..68087d8 100644
>> --- a/drivers/input/touchscreen/wacom_w8001.c
>> +++ b/drivers/input/touchscreen/wacom_w8001.c
>> @@ -3,6 +3,7 @@
>> =A0 *
>> =A0 * Copyright (c) 2008 Jaya Kumar
>> =A0 * Copyright (c) 2010 Red Hat, Inc.
>> + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
>> =A0 *
>> =A0 * This file is subject to the terms and conditions of the GNU Ge=
neral Public
>> =A0 * License. See the file COPYING in the main directory of this ar=
chive for
>> @@ -86,6 +87,12 @@ struct w8001 {
>> =A0 =A0 =A0 char phys[32];
>> =A0 =A0 =A0 int type;
>> =A0 =A0 =A0 unsigned int pktlen;
>> + =A0 =A0 bool pen_in_prox;
>> + =A0 =A0 bool has_touch;
>> + =A0 =A0 int max_touch_x;
>> + =A0 =A0 int max_touch_y;
>> + =A0 =A0 int max_pen_x;
>> + =A0 =A0 int max_pen_y;
>
> This does not apply to my tree. What tree was it made against?

It was based on Henrik's mt-next branch since there are MT support in
the driver. Should I use yours for v2?

Thank you.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
