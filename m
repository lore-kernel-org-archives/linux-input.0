From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Logitech M705 thumb button
Date: Wed, 31 Mar 2010 14:05:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1003311401230.24576@pobox.suse.cz>
References: <hoqak4$m6t$1@dough.gmane.org>  <20100330065625.GC12764@core.coreip.homeip.net>  <319012f1003300033k254715dao7f9a807615df36df@mail.gmail.com>  <alpine.LRH.2.00.1003301418000.10181@twin.jikos.cz>
 <319012f1003300602q708563ebo90b30c8d8b15e938@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54502 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204Ab0CaMFK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Mar 2010 08:05:10 -0400
In-Reply-To: <319012f1003300602q708563ebo90b30c8d8b15e938@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Octoploid <cryptooctoploid@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, 30 Mar 2010, Octoploid wrote:

> > Could you please provide output of
> >
> > =A0 =A0 =A0 =A0cat /sys/kernel/debug/hid/<device>/rdesc
> >
> > and
> >
> > =A0 =A0 =A0 =A0cat /sys/kernel/debug/hid/<device>/events
> >
>=20
> Sure:
>=20
> There are no events logged when I press the thumb button
> while running cat /sys/kernel/debug/hid/0003:046D:C52B.0002/events.
>=20
> (The =BBunifying USB reciever=AB has three sub-devices. The first one=
 is
> for keyboards, the second for mouses and the third is not used:
> usb 3-1: new full speed USB device using ohci_hcd and address 2
> input: Logitech USB Receiver as
> /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.0/input/input2
> generic-usb 0003:046D:C52B.0001: input,hidraw0: USB HID v1.11 Keyboar=
d
> [Logitech USB Receiver] on usb-0000:00:12.0-1/input0
> input: Logitech USB Receiver as
> /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.1/input/input3
> generic-usb 0003:046D:C52B.0002: input,hiddev96,hidraw1: USB HID v1.1=
1
> Mouse [Logitech USB Receiver] on usb-0000:00:12.0-1/input1
> generic-usb 0003:046D:C52B.0003: hiddev97,hidraw2: USB HID v1.11
> Device [Logitech USB Receiver] on usb-0000:00:12.0-1/input2)
>=20
> The rdesc output for the mouse and the third device follows:

Thanks for providing the output.

The device defines 16 buttons in its report descriptor. How much does i=
t=20
actually physically have?

Is the other (non-used) interface also silent when you press the=20
non-working button? (I can see that it is claimed by HID as well).

Could you please apply the patch below and check whether there is still=
 no=20
event present when you press the button?

Thanks.



=46rom 1caea61eda5c4d446147aa0e712ba395bb6b81c3 Mon Sep 17 00:00:00 200=
1
=46rom: Jiri Kosina <jkosina@suse.cz>
Date: Thu, 18 Mar 2010 12:09:53 +0100
Subject: [PATCH] HID: output event in debugfs even if hid_get_report() =
fails

if hid_get_report() fails for whatever reason, the raw output of
the report doesn't make it into 'events' file in debugfs at all, becaus=
e
we leave hid_input_report() too soon.

We want the report to be always present for debugging reasons. Move the
code around, so that the event makes it to 'events' file all the time,
even if we are going to discard the report.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-core.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 368fbb0..c49aaa2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1096,20 +1096,11 @@ int hid_input_report(struct hid_device *hid, in=
t type, u8 *data, int size, int i
 		goto nomem;
 	}
=20
-	snprintf(buf, HID_DEBUG_BUFSIZE - 1,
-			"\nreport (size %u) (%snumbered)\n", size, report_enum->numbered ? =
"" : "un");
-	hid_debug_event(hid, buf);
-
-	report =3D hid_get_report(report_enum, data);
-	if (!report) {
-		kfree(buf);
-		return -1;
-	}
-
 	/* dump the report */
 	snprintf(buf, HID_DEBUG_BUFSIZE - 1,
-			"report %d (size %u) =3D ", report->id, size);
+			"\nreport (size %u) (%snumbered) =3D ", size, report_enum->numbered=
 ? "" : "un");
 	hid_debug_event(hid, buf);
+
 	for (i =3D 0; i < size; i++) {
 		snprintf(buf, HID_DEBUG_BUFSIZE - 1,
 				" %02x", data[i]);
@@ -1117,6 +1108,13 @@ int hid_input_report(struct hid_device *hid, int=
 type, u8 *data, int size, int i
 	}
 	hid_debug_event(hid, "\n");
=20
+	report =3D hid_get_report(report_enum, data);
+
+	if (!report) {
+		kfree(buf);
+		return -1;
+	}
+
 	kfree(buf);
=20
 nomem:
--=20
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
