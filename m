From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Input - elantech: fix debug dump of the current packet
Date: Thu, 28 Jul 2016 11:58:29 -0700
Message-ID: <1469732309.3998.71.camel@perches.com>
References: <1469699935-23056-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1469730656.3998.63.camel@perches.com> <20160728184003.GE16852@dtor-ws>
	 <1469731797.3998.69.camel@perches.com> <20160728185409.GG16852@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:51510 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756059AbcG1S6e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 14:58:34 -0400
In-Reply-To: <20160728185409.GG16852@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-07-28 at 11:54 -0700, Dmitry Torokhov wrote:
> On Thu, Jul 28, 2016 at 11:49:57AM -0700, Joe Perches wrote:
[]
> > So use dev_printk(KERN_DEBUG, etc...
> #define psmouse_printk(level, psmouse, format, ...)	\
> 	dev_printk(level,				\
> 		=A0=A0=A0&(psmouse)->ps2dev.serio->dev,	\
> 		=A0=A0=A0psmouse_fmt(format), ##__VA_ARGS__)
>=20
> I want to see current protocol module in th eoutput and I do not want=
 to
> write "&(psmouse)->ps2dev.serio->dev" all the time.

There are only 2 uses of the macro.

$ git grep psmouse_printk
drivers/input/mouse/elantech.c:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0psmouse_printk(KERN_DEBUG, psmouse,=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0\
drivers/input/mouse/elantech.c: psmouse_printk(KERN_DEBUG, psmouse, "PS=
/2 packet [");
drivers/input/mouse/psmouse.h:#define psmouse_printk(level, psmouse, fo=
rmat, ...)=A0=A0=A0=A0=A0=A0=A0\


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
