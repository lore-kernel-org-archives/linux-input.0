From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - elantech: fix debug dump of the current packet
Date: Thu, 28 Jul 2016 12:03:33 -0700
Message-ID: <69E215A7-E962-47FB-8735-208972CBAA65@gmail.com>
References: <1469699935-23056-1-git-send-email-benjamin.tissoires@redhat.com> <1469730656.3998.63.camel@perches.com> <20160728184003.GE16852@dtor-ws> <1469731797.3998.69.camel@perches.com> <20160728185409.GG16852@dtor-ws> <1469732309.3998.71.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34726 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969AbcG1TDh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 15:03:37 -0400
In-Reply-To: <1469732309.3998.71.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On July 28, 2016 11:58:29 AM PDT, Joe Perches <joe@perches.com> wrote:
>On Thu, 2016-07-28 at 11:54 -0700, Dmitry Torokhov wrote:
>> On Thu, Jul 28, 2016 at 11:49:57AM -0700, Joe Perches wrote:
>[]
>> > So use dev_printk(KERN_DEBUG, etc...
>> #define psmouse_printk(level, psmouse, format, ...)	\
>> 	dev_printk(level,				\
>> 		=C2=A0=C2=A0=C2=A0&(psmouse)->ps2dev.serio->dev,	\
>> 		=C2=A0=C2=A0=C2=A0psmouse_fmt(format), ##__VA_ARGS__)
>>=20
>> I want to see current protocol module in th eoutput and I do not wan=
t
>to
>> write "&(psmouse)->ps2dev.serio->dev" all the time.
>
>There are only 2 uses of the macro.
>
>$ git grep psmouse_printk
>drivers/input/mouse/elantech.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psmouse_=
printk(KERN_DEBUG,
>psmouse,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0\
>drivers/input/mouse/elantech.c: psmouse_printk(KERN_DEBUG, psmouse,
>"PS/2 packet [");
>drivers/input/mouse/psmouse.h:#define psmouse_printk(level, psmouse,
>format, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\

Yes, but many more of psmouse_<severity> calls and I like consistency.


Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
