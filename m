From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Default keyboard LEDs
Date: Mon, 14 Jan 2008 10:24:28 +0000
Message-ID: <20080114102428.GA4298@implementation.uk.xensource.com>
References: <20080114005219.GA4296@implementation> <Pine.LNX.4.64.0801140238260.10906@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:57314 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbYANKdH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jan 2008 05:33:07 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801140238260.10906@fbirervta.pbzchgretzou.qr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Jan Engelhardt, le Mon 14 Jan 2008 02:40:08 +0100, a =E9crit :
> On Jan 14 2008 00:52, Samuel Thibault wrote:
> >In many cases, one prefers to have e.g. the NumLock on by default.  =
In
> >many cases, one doesn't want to have it by default, e.g. on laptops.
> >
> >Distributions actually have a very hard time trying to set this
> >correctly after the kernel boot, and that doesn't work for new conso=
les
> >that are created via the openvt(1) command anyway. This hence adds a
> >keyboard.default_leds boot parameter that permits to configure the
> >default keyboard LEDs.
>=20
> Apart from openvt being able to find the first unused tty,
> what is openvt good for? (Read: I could just as well run
> `bash </dev/tty8 >/dev/tty8 2>/dev/tty8`)

But it is a burden (you forgot '&' btw ;) ). Also, openvt properly sets
the controlling tty, can run a login shell, etc...

Anyway, be it openvt or bash, the LED issue exists :)

Samuel
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
