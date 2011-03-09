From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Wed, 9 Mar 2011 12:40:38 +0100
Message-ID: <20110309114038.GA9143@polaris.bitmath.org>
References: <20110308080414.GA2888@polaris.bitmath.org>
 <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
 <20110308091434.GA3282@polaris.bitmath.org>
 <AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
 <20110308094630.GA3396@polaris.bitmath.org>
 <1299627518.2306.47.camel@itzy>
 <20110309082455.GA3166@polaris.bitmath.org>
 <AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
 <20110309092337.GC3824@polaris.bitmath.org>
 <AANLkTi=TJ3RPOSP3XyqOfX8Aeep3-uFcHmcia6+a2Wxy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:47440 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752084Ab1CILjS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 06:39:18 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=TJ3RPOSP3XyqOfX8Aeep3-uFcHmcia6+a2Wxy@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

> >> Please do not add numerical constants in a generic code. If I want=
 to
> >> override the values for another device, I'll have to rename your q=
uirk
> >> to MT_QUIRK_EGALAX_XYZ_FIXUP_WITH_0_32760_0_32760_0_x and add mine=
=2E
> >> These values have to be moved in the MT_CLS.
> >
> > It is a specific value used for a specific code path, no need to
> > over-generalize. =A0The quirk name could be specialized even more, =
i
> > suppose, but the point is that it makes the hid-multitouch driver d=
o
> > exactly what is done in the hid-egalax driver, and it is easy to pr=
ove
> > that there are no side effects for other devices.
>=20
> Or it's a generic code path for generic devices: if someone want to d=
o
> the same thing that have been done in hid-egalax (correct the logical
> min/max reported by the device), this could be done.

The point is that this is not generally needed, but necessitated by a
bug in the firmware. Problems like this is why we have quirks.

> Concerning the prove, I'm pretty sure we can manage to prove that bot=
h
> solutions are equivalent as the current code already relies on the
> fact that static struct are null initialized.

The comment here was about using specific code paths enabled by quirks.

> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_TIPPRESSURE:
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (quirks & MT_QU=
IRK_EGALAX_XYZ_FIXUP)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi=
eld->logical_minimum =3D 0;
> >>
> >> No really need for the test and the quirk. In addition, here you d=
o
> >> not override logical_max. This shows that the quirk is not
> >> MT_QUIRK_EGALAX_XYZ_FIXUP but the combination of
> >> MT_QUIRK_EGALAX_XY_FIXUP and =A0MT_QUIRK_EGALAX_Z_MIN_FIXUP.
> >> Just drop it here.
> >
> > The added code path simply reflects what is in the hid-egalax
> > driver. It is true that the statement _probably_ works for other
> > devices as well, but it cannot be proven just by looking at the
> > code. Also, we have no known additional case where it is needed.
>=20
> I didn't told to remove the test just by looking at the code. I'm
> taking in account all the devices that have been reported to us:
> http://lii-enac.fr/en/architecture/linux-input/multitouch-devices.htm=
l
> Among all of them, only asus, egalax (capacitive and resistive),
> mosart (the same as asus), and stantum reports pressure.
> Asus and mosart set only the logical maximum -> logical minimum is
> therefore at 0.
> Stantum does not set the min/max -> logical minimum is at 0 too.
> EGalax set the minimum at 1 -> in your patch, you explained that was =
a
> bug for the upper layers.

=46ine. Since we will always want the pressure to have zero intercept, =
I
think it is ok to always execute that line, but I still think it is
better to leave it conditional.

> > I am trying to think of a better name for the quirk, but frankly, I
> > think it already says what it needs to say.
>=20
> What about MT_QUIRK_XYZ_CORRECTIONS_FOR_SPECIAL_EGALAX_DEVICES?

Maybe at bit long, I guess you aren't really serious.

Thanks.
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
