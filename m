From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Linux USB HID should ignore values outside Logical Minimum/Maximum
 range
Date: Fri, 28 Oct 2011 18:23:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110281817380.3541@pobox.suse.cz>
References: <op.v3q34la3dsdv5o@localhost> <1319476183.3210.12.camel@lovely> <20111024203204.GA31721@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49221 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832Ab1J1QXT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 12:23:19 -0400
In-Reply-To: <20111024203204.GA31721@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, =?ISO-8859-15?Q?Denilson_Figueiredo_de_S=E1?= <denilsonsa@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, 24 Oct 2011, Dmitry Torokhov wrote:

> While input core does not clam or validate the values reported by the=
=20
> driver it might make sense to do so in hid-input; I am not sure how=20
> often these limits programmed intorrectly. Jiri i sprobably the best=20
> person to answer this question.

I haven't met such a device myself yet.

On the other hand I feel like just dropping the report on the floor sho=
uld=20
be the proper thing to do.


Christoph, how about the (untested at my side yet) patch below? It'd be=
=20
nice if you could test with the device you are seeing the problem with =
and=20
let me know.

It's definitely not something I'll be pushing for 3.1 though; I'd first=
=20
like to verify the batch of the device records I have (or I have receiv=
ed)=20
to see whehter we can't introduce regressions this way.


=46rom: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: ignore absolute values which don't fit between lo=
gical min and max

Linux should ignore values outside logical min/max range, as they are n=
ot
meaningful. This is what at least some of other OSes do, and it also ma=
kes
sense (currently the value gets misinterpreted larger up the stack).

Reported-by: Denilson Figueiredo de S=E1 <denilsonsa@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-input.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index f333139..ca923de 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -822,6 +822,13 @@ void hidinput_hid_event(struct hid_device *hid, st=
ruct hid_field *field, struct
 		return;
 	}
=20
+	/* Ignore absolute values that are out of bounds */
+	if ((usage->type =3D=3D EV_ABS && (value < field->logical_minimum ||
+					value > field->logical_maximum))) {
+		dbg_hid("Ignoring out-of-range value %x\n", value);
+		return;
+	}
+
 	/* report the usage code as scancode if the key status has changed */
 	if (usage->type =3D=3D EV_KEY && !!test_bit(usage->code, input->key) =
!=3D value)
 		input_event(input, EV_MSC, MSC_SCAN, usage->hid);
--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
