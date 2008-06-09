From: Alexander Karpenko <alexander@comm.utoronto.ca>
Subject: Re: [PATCH] Input: Add newer Apple keyboards to hid quirks table
Date: Mon, 09 Jun 2008 11:22:44 -0400
Message-ID: <1213024964.8396.7.camel@tesseract>
References: <20080607024631.GA24254@srcf.ucam.org>
	 <Pine.LNX.4.64.0806091342420.10085@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759023AbYFIPXH@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0806091342420.10085@jikos.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

The Macbook Pro 4,1 has no numlock key. I am not sure what
the =EF=BB=BFHID_QUIRK_APPLE_NUMLOCK_EMULATION flag does.

On a somewhat related note, the function key secondary functionality ha=
s
also changed in the new Macbook Pro/Air models; this requires the
"powerbook_fn_keys" lookup table in drivers/hid/hid-input.c to be
updated accordingly. The new key layout is detailed here:
http://support.apple.com/kb/HT1117

Regards,
Alex


On Mon, 2008-06-09 at 13:44 +0200, Jiri Kosina wrote:
> On Sat, 7 Jun 2008, Matthew Garrett wrote:
>=20
> > The keyboards in recent Apple hardware are still not properly suppo=
rted=20
> > by Linux due to them not being in the hid quirks table. This patch =
adds=20
> > the current hardware. Device IDs come from the Mactel Linux project=
=2E
>=20
> Hi Matthew,
>=20
> the patch adding these product IDs is already queued in my=20
> 'upstream-fixes' branch.
>=20
> However ...
>=20
> > +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI, HID_Q=
UIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
> > +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO, HID_QU=
IRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_=
ISO_KEYBOARD },
> > +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_JIS, HID_QU=
IRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
> > +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI, HID_=
QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
> > +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO, HID_Q=
UIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE=
_ISO_KEYBOARD },
> > +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS, HID_Q=
UIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
>=20
> Alexandre's original patch is missing the=20
> HID_QUIRK_APPLE_NUMLOCK_EMULATION quirk ... Alexandre, was this=20
> intentional?
>=20
> Thanks,
>=20
