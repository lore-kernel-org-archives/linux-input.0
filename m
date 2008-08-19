From: =?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?=
	<Sergey.Belyashov@gmail.com>
Subject: Re: [PATCH] Autocentering support for Logitech MOMO Racing Wheel
 (force feedback)
Date: Tue, 19 Aug 2008 21:46:27 +0400
Message-ID: <48AB06F3.10808@gmail.com>
References: <bb829a0b0808180217t2bd3ed49q4cf5734dcc756311@mail.gmail.com>  <20080818110815.ZZRA012@mailhub.coreip.homeip.net>  <bb829a0b0808180916l1d2ca72fj689edcf5b8c156e5@mail.gmail.com>  <20080818131807.ZZRA012@mailhub.coreip.homeip.net> <bb829a0b0808181130r4c45403al45fffb356f321f9@mail.gmail.com> <alpine.LNX.1.10.0808191458050.18058@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ultranet.ru ([81.25.53.82]:40195 "EHLO mail.ultranet.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900AbYHSS6e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Aug 2008 14:58:34 -0400
In-Reply-To: <alpine.LNX.1.10.0808191458050.18058@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Jiri Kosina =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Mon, 18 Aug 2008, Sergey Belyashov wrote:
>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> Logitech MOMO Recing Wheel Force Feedback autocenter setting support
>> (also may be work on G25 etc. but I cann't check):
>=20
> Hi Sergey,
>=20
> sorry for late reply, I have been on vacation.
>=20
> Could you please send the patch with proper Signed-off-by: line, as=20
> documented in Documentation/SubmittingPatches, so that I can merge it=
=20
> properly?
>=20
> Thanks!
>=20

  Current kernel has no support for autocentering for Logitech wheels.
By default autocentering enabled in wheel and constant effect does not
work properly. Using USB sniffer I found command which change
autocentering settings: 0xFE, 0x0D, 0x0R, 0x0L, 0x80, 0x00, 0x00,
where R - clockwise force, L - counter-clockwise (0x0-0xF, 0xC =3D
100%). I write patch for my current kernel (2.6.25), but I think git
version also supported, because I do not found any changes in it.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/hid/usbhid/hid-lgff.c	2008-04-17 06:49:44.000000000 +0400
+++ drivers/hid/usbhid/hid-lgff.c	2008-08-19 20:57:00.000000000 +0400
@@ -48,6 +48,12 @@ static const signed short ff_joystick[]=20
 	-1
 };
=20
+static const signed short ff_wheel[] =3D {
+	FF_CONSTANT,
+	FF_AUTOCENTER,
+	-1
+};
+
 static const struct dev_type devices[] =3D {
 	{ 0x046d, 0xc211, ff_rumble },
 	{ 0x046d, 0xc219, ff_rumble },
@@ -55,7 +61,7 @@ static const struct dev_type devices[] =3D
 	{ 0x046d, 0xc286, ff_joystick },
 	{ 0x046d, 0xc294, ff_joystick },
 	{ 0x046d, 0xc295, ff_joystick },
-	{ 0x046d, 0xca03, ff_joystick },
+	{ 0x046d, 0xca03, ff_wheel },
 };
=20
 static int hid_lgff_play(struct input_dev *dev, void *data, struct ff_=
effect *effect)
@@ -100,6 +106,23 @@ static int hid_lgff_play(struct input_de
 	return 0;
 }
=20
+static void hid_lgff_set_autocenter(struct input_dev *dev, u16 magnitu=
de)
+{
+	struct hid_device *hid =3D input_get_drvdata(dev);
+	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
+	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	__s32 *value =3D report->field[0]->value;
+	magnitude =3D (magnitude >> 12) & 0xf;
+	*value++ =3D 0xfe;
+	*value++ =3D 0x0d;
+	*value++ =3D magnitude;   /* clockwise strength */
+	*value++ =3D magnitude;   /* counter-clockwise strength */
+	*value++ =3D 0x80;
+	*value++ =3D 0x00;
+	*value =3D 0x00;
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
 int hid_lgff_init(struct hid_device* hid)
 {
 	struct hid_input *hidinput =3D list_entry(hid->inputs.next, struct hi=
d_input, list);
@@ -145,6 +168,9 @@ int hid_lgff_init(struct hid_device* hid
 	if (error)
 		return error;
=20
+	if ( test_bit(FF_AUTOCENTER, dev->ffbit) )
+		dev->ff->set_autocenter =3D hid_lgff_set_autocenter;
+
 	printk(KERN_INFO "Force feedback for Logitech force feedback devices =
by Johann Deneux <johann.deneux@it.uu.se>\n");
=20
 	return 0;

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Signed-off-by: Sergey Belyashov <Sergey.Belyashov@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
