From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Wed, 9 Mar 2011 10:23:37 +0100
Message-ID: <20110309092337.GC3824@polaris.bitmath.org>
References: <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
 <1299564524.2306.18.camel@itzy>
 <20110308080414.GA2888@polaris.bitmath.org>
 <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
 <20110308091434.GA3282@polaris.bitmath.org>
 <AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
 <20110308094630.GA3396@polaris.bitmath.org>
 <1299627518.2306.47.camel@itzy>
 <20110309082455.GA3166@polaris.bitmath.org>
 <AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:56005 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756873Ab1CIJVK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 04:21:10 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

> > @@ -147,11 +163,15 @@ static int mt_input_mapping(struct hid_device=
 *hdev, struct hid_input *hi,
> > =A0{
> > =A0 =A0 =A0 =A0struct mt_device *td =3D hid_get_drvdata(hdev);
> > =A0 =A0 =A0 =A0struct mt_class *cls =3D td->mtclass;
> > + =A0 =A0 =A0 __s32 quirks =3D cls->quirks;
> > +
> > =A0 =A0 =A0 =A0switch (usage->hid & HID_USAGE_PAGE) {
> >
> > =A0 =A0 =A0 =A0case HID_UP_GENDESK:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (usage->hid) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_GD_X:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QUIRK=
_EGALAX_XYZ_FIXUP)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field=
->logical_maximum =3D 32760;
>=20
> Please do not add numerical constants in a generic code. If I want to
> override the values for another device, I'll have to rename your quir=
k
> to MT_QUIRK_EGALAX_XYZ_FIXUP_WITH_0_32760_0_32760_0_x and add mine.
> These values have to be moved in the MT_CLS.

It is a specific value used for a specific code path, no need to
over-generalize.  The quirk name could be specialized even more, i
suppose, but the point is that it makes the hid-multitouch driver do
exactly what is done in the hid-egalax driver, and it is easy to prove
that there are no side effects for other devices.

> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_TIPPRESSURE:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QUIRK=
_EGALAX_XYZ_FIXUP)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field=
->logical_minimum =3D 0;
>=20
> No really need for the test and the quirk. In addition, here you do
> not override logical_max. This shows that the quirk is not
> MT_QUIRK_EGALAX_XYZ_FIXUP but the combination of
> MT_QUIRK_EGALAX_XY_FIXUP and  MT_QUIRK_EGALAX_Z_MIN_FIXUP.
> Just drop it here.

The added code path simply reflects what is in the hid-egalax
driver. It is true that the statement _probably_ works for other
devices as well, but it cannot be proven just by looking at the
code. Also, we have no known additional case where it is needed.

I am trying to think of a better name for the quirk, but frankly, I
think it already says what it needs to say.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
