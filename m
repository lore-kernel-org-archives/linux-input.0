From: Niels Skou Olsen <nolsen@jabra.com>
Subject: RE: [PATCH] HID: Remove Jabra speakerphone devices from ignore list
Date: Mon, 18 Sep 2017 13:21:29 +0000
Message-ID: <VI1PR0701MB299151ACD4B5747BEFBE603FDA630@VI1PR0701MB2991.eurprd07.prod.outlook.com>
References: <CAP_ceTxM-Rgz=i6Zy_iBOa1Cs5D=5Hi0BgWzQKmXoWmL_9TBWA@mail.gmail.com>
 <VI1PR0701MB2991A0071AE574E241AD37D6DA680@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTz-9vYpo1xqUnEF=LtWcGhxx5FiTo7xJwLreL5vYx7xww@mail.gmail.com>
 <VI1PR0701MB299142D55AF9734A4BC5CADADA690@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTzwOgA6e2gO2fc8vzps4mUJkxC=LzoGEACHcLKkoygXpA@mail.gmail.com>
 <20170913170238.GB13863@mail.corp.redhat.com>
 <nycvar.YFH.7.76.1709131009350.4703@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:44919
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752377AbdIRNVd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Sep 2017 09:21:33 -0400
In-Reply-To: <nycvar.YFH.7.76.1709131009350.4703@jbgna.fhfr.qr>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Cc: Vincent Palatin <vpalatin@chromium.org>, Richard Hughes <richard@hughsie.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "mnilsson@chromium.org" <mnilsson@chromium.org>

On Wed, 13 Sep 2017, jikos@kernel.org wrote:

> On Wed, 13 Sep 2017, benjamin.tissoires@redhat.com wrote:
>
> > I do not see a reason not to. Maybe Jiri will, but the fact that one
> > version works and one doesn't seem enough to allow such specific
> > blacklisting.
>
> The blacklist matching currently doesn't support that, but it'd be trivia=
l to match, and I
> actually think it generally makes sense to me. So feel free (once you guy=
s settle on
> solution that both Chromium and Jabr folk find acceptable) to send this t=
ogether with
> a hid-core patch that'd add a possibility to perform per-fw-version match=
ing.

I believe that ChromiumOS and Jabra agree on a firmware version based
blacklisting of these 2 devices.  We release new firmwares for the 2
devices and add code to ignore the HID interface on all previous versions.

We have discussed using 'bcdDevice' for this. I am afraid the bcdDevice
field won't cut it as firmware version for devices in general. In all
descriptions I have seen, the field is a vendor defined device release
number. In the USB 3.1 spec, bcdDevice is described like this:

  "Device release number in binary-coded decimal"

For Jabra devices the bcdDevice contains the firmware version, but it is
vendor specific. So I don't think it makes sense to come up with
a generic mechanism based on this.

Therefore, my proposal is to handle this in the vendor switch in
hid_ignore(). I could add a case for Jabra that checks
bcdDevice against a known good version.

To access bcdDevice we can do something like this:

u16 hid_get_bcd_device(struct hid_device *hdev)
{
    struct usb_device *usbdev =3D
        interface_to_usbdev(to_usb_interface(hdev->dev.parent));

   return le16_to_cpu(usbdev->descriptor.bcdDevice);
}

There are several vendor specific drivers that do something
along these lines. Would this be OK in hid-core.c? I have tested

Comments welcome, thanks.
Niels

**** GN GROUP NOTICE - AUTOMATICALLY INSERTED**** The information in this e=
-mail (including attachments, if any) is considered confidential and is int=
ended only for the recipient(s) listed above. Any review, use, disclosure, =
distribution or copying of this e-mail is prohibited except by or on behalf=
 of the intended recipient. If you have received this email in error, pleas=
e notify me immediately by reply e-mail, delete this e-mail, and do not dis=
close its contents to anyone. Any opinions expressed in this e-mail are tho=
se of the individual and not necessarily the GN group. Thank you. *********=
*********** DISCLAIMER END ************************
