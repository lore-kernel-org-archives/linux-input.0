From: Cedric Sodhi <manday@gmx.net>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 11:25:14 +0100
Message-ID: <20111116102514.GA3831@slate>
References: <20111116095030.GC3335@slate>
 <CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:44840 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755394Ab1KPKZi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 05:25:38 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org

Dear Benjamin,

On Wed, Nov 16, 2011 at 11:17:57AM +0100, Benjamin Tissoires wrote:
> Hi Cedric,
>=20
> If I understand correctly, your device is an eGalax one with a Wacom
> VendorID... ;-)

No. The VID is that of DWAV, as it should be. It might have been
misleading to mention Wacom here, which is - at least with regard to th=
e
issue at hand - not related. I was just lucky the guys (esp. Chris) at
linuxwacom-devel would take a look at the issue, since obviously, they
are experts on touchscreens.
>=20
> I assume that you're the first of a long list that will encounter thi=
s
> kind of problem:

You are right. I'm not the first, either, though. The eGalax is the
touchdevice of the ASUS EEE Slate, in conjunction with a Wacom for the
pen (yes, two devices: eGalax for finger and Wacom for pen).
>=20
> Now, hid (the generic hid input layer) can detect if your device is a
> multitouch one (by relying on the ContactID field in the report
> descriptor), and it will release it if it's detected.
> The counter part of this autodetection (in hid-multitouch) has not
> been judged as enough mature to be included in the kernel, and
> hid-multitouch can't handle your device automatically.
>=20
> That's why you don't see any event* unless you add the VID:PID in
> hid-multitouch.

That's what I already did, as I tried to describe by saying that I adde=
d
"MULTITOUCH5" in line with the other MULTITOUCH[1-4] of DWAV VID.

>=20
> I'm currently working on a solution to allow end-user to test more
> efficiently their device with hid-multitouch.
> If you want to be my guinea pig, it would help me.

I'd happily be your guinea pig. I suggest you browse through the thread
which I referred to, where Chris helped me solve a bulk of the problems
already and also told me how to add the VID:PID to the whitelist of
hid-multitouch.

regards,
Cedric
>=20
> Cheers,
> Benjamin
>=20
> On Wed, Nov 16, 2011 at 10:50, Cedric Sodhi <manday@gmx.net> wrote:
> > Hello everyone,
> >
> > the context for this problem is getting the eGalax USB Touchscreen,=
 ID
> > 056a:0090, to work as such, as it is discussed on the linuxwacom-de=
vel
> > list (see [1]).
> >
> > Quickly summarized:
> >
> > Adding the device as USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5, in line=
 with
> > the ..._MULTITOUCH[1-4], succeeds in thus far, as that it appears a=
s a
> > HID Touchscreen. However, as of 3.1.x, clicking, id est touching "j=
ams"
> > as in the click is never released.
> >
> > Updating to 3.2.x-torvalds' kernel should have resolved that jammin=
g,
> > but instead no clicks or releases are recognized at all.
> >
> > The real problem with debugging that, though, is that
> >
> > /sys/kernel/debug/hid/<eGalax>/events
> >
> > remains dead, in any kernel, 3.1.x-gentoo, 3.1.x-vanilla and
> > 3.2.x-torvalds alike.
> >
> > I hope that you may have an idea as for any of the problems, especi=
ally
> > why there appears no output on the ./events node (the according nod=
e for
> > my keyboard reports events just fine).
> >
> > Pasted is .config [2] for 3.2.x-torvalds and ./hid/<eGalax>/rdesc [=
3] on
> > 3.2.x-torvalds.
> >
> > [1]
> > http://sourceforge.net/mailarchive/forum.php?thread_name=3DCAGzDe_Y=
2cSMxVPm-rcNSrMsew2V5Y0vbVyhXJBFCKraq7EaZ8g@mail.gmail.com&forum_name=3D=
linuxwacom-devel
> > [2] http://paste.pocoo.org/show/508548/
> > [3] http://paste.pocoo.org/show/508550/
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-inp=
ut" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
