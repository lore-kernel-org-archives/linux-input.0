From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc2] input:  dm355evm_keys driver
Date: Fri, 26 Jun 2009 12:04:31 -0700
Message-ID: <200906261204.31927.david-b@pacbell.net>
References: <200901171315.08019.david-b@pacbell.net> <200906222240.01093.david-b@pacbell.net> <20090623060604.GB14724@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:29185 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752641AbZFZTE3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Jun 2009 15:04:29 -0400
In-Reply-To: <20090623060604.GB14724@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@openedhand.com>
Cc: linux-input@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Monday 22 June 2009, Dmitry Torokhov wrote:
>=20
> > > As you have noticed the driver is in mainline already;
> >=20
> > Actually I didn't notice until just now. =A0It was moved
> > from input/keyboard to input/misc. =A0And I wasn't cc'd
> > on this at any point ... so it's no wonder I had no idea
> > what was happening!
> >=20
>=20
> Ah, sorry, it was me - all RC drivers live in input/misc,
> that's why I moved it there.

Moving it did break more than just config files ... see
the appended fixup patch.  I'll suggest that it go through
the input tree to keep things together, though if Sam wants
to take this through MFD he surely has that option.  :)

- Dave

p.s. Of course this is is a hybrid keypad-plus-remote
     driver.  :)  The only real issue here is having this
     change with no notice.

=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE
=46rom: David Brownell <dbrownell@users.sourceforge.net>

The keypad driver for the DM355 EVM got slightly broken as it merged,
since it moved from input/keyboard to input/misc and its Kconfig
symbol changed.  This patch copes with the changed Kconfig symbol.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/dm355evm_msp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -32,8 +32,7 @@
  * This driver was tested with firmware revision A4.
  */
=20
-#if defined(CONFIG_KEYBOARD_DM355EVM) \
-		|| defined(CONFIG_KEYBOARD_DM355EVM_MODULE)
+#if defined(CONFIG_INPUT_DM355EVM) || defined(CONFIG_INPUT_DM355EVM_MO=
DULE)
 #define msp_has_keyboard()	true
 #else
 #define msp_has_keyboard()	false

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
