From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: adp5589-keys: fix event count mask
Date: Wed, 6 May 2015 16:36:00 -0700
Message-ID: <20150506233600.GC5580@dtor-ws>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
 <1429626090-29022-4-git-send-email-guido@vanguardiasur.com.ar>
 <5536607C.4010404@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37702 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbEFXgE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 19:36:04 -0400
Received: by igbsb11 with SMTP id sb11so9190502igb.0
        for <linux-input@vger.kernel.org>; Wed, 06 May 2015 16:36:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5536607C.4010404@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

On Tue, Apr 21, 2015 at 04:36:44PM +0200, Michael Hennerich wrote:
> On 04/21/2015 04:21 PM, Guido Mart=EDnez wrote:
> >The event mask was specified as 0xF (4 bits) when in reality is 0x1F=
 (5
> >bits) in order to be capable of representing all FIFO length values =
from
> >0 to 16.
> >
> >This caused a problem: when the keypad reported 16 pending events th=
e
> >driver took it as 0, and did nothing. This in turn caused the keypad=
 to
> >re-issue the interrupt over and over again.
> >
> >Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad Dec=
oder and I/O Expander')
> >Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Applied, thank you.

> >---
> >  drivers/input/keyboard/adp5589-keys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/k=
eyboard/adp5589-keys.c
> >index 8709a7f..0419a7a 100644
> >--- a/drivers/input/keyboard/adp5589-keys.c
> >+++ b/drivers/input/keyboard/adp5589-keys.c
> >@@ -180,7 +180,7 @@
> >  #define LOGIC2_STAT	(1 << 7)	/* ADP5589 only */
> >  #define LOGIC1_STAT	(1 << 6)
> >  #define LOCK_STAT	(1 << 5)	/* ADP5589 only */
> >-#define KEC		0xF
> >+#define KEC		0x1F
> >  /* PIN_CONFIG_D Register */
> >  #define C4_EXTEND_CFG	(1 << 6)	/* RESET2 */
>=20
>=20
> --=20
> Greetings,
> Michael
>=20
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Marti=
n,
> Margaret Seif
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
