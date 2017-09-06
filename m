From: Niels Skou Olsen <nolsen@jabra.com>
Subject: RE: [PATCH] HID: Add special driver for Jabra devices
Date: Wed, 6 Sep 2017 12:10:29 +0000
Message-ID: <VI1PR0701MB2991FF8324102F06016E1F3CDA970@VI1PR0701MB2991.eurprd07.prod.outlook.com>
References: <1504269832-23142-1-git-send-email-nolsen@jabra.com>
 <nycvar.YFH.7.76.1709061124360.4077@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:34133
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752936AbdIFMKc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 08:10:32 -0400
In-Reply-To: <nycvar.YFH.7.76.1709061124360.4077@jbgna.fhfr.qr>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>


On Thu, 6 Sep 2017, jikos@kernel.org wrote:

> On Fri, 1 Sep 2017, nolsen@jabra.com wrote:
>
> > From: Niels Skou Olsen <nolsen@jabra.com>
> >
> > Add a hid-jabra driver to the list of special drivers in hid-core. The
> > driver prevents vendor defined HID usages (FF00-FFFF) in Jabra devices
> > from being mapped to input events that become unintended mouse events
> > in the X11 server.
> >
> > Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
>
> Do you plan to eventually map the vendor specific devices to anything mea=
ningful?

Currently there is no need, but we might need to in future devices/firmware=
 versions.

The standard usages (Consumer, Button, etc) are handled appropriately by th=
e default mapping in hidinput_configure_usage(). But unfortunately some of =
our vendor defined usages are mapped to events that do not make sense.

As an example, here's an excerpt of the sysfs rdesc for one of our devices.=
 The vendor defined usages FF30.xxxx are mapped like this:

ff30.0020 ---> Key.Btn0
ff30.0097 ---> Key.Btn1
ff30.002f ---> Key.Btn2
ff30.0021 ---> Key.Btn3
ff30.0024 ---> Key.Btn4
ff30.fffd ---> Key.Btn5
ff30.0050 ---> Key.Btn6
ff30.00b0 ---> Absolute.Misc
ff30.00b1 ---> Absolute.?
ff30.00b2 ---> Absolute.?
ff30.00b3 ---> Absolute.?
ff30.00b4 ---> Absolute.?
ff30.00b5 ---> Absolute.?
ff30.00b6 ---> Absolute.?
ff30.00b7 ---> Absolute.?
ff30.00b8 ---> Absolute.MTMajor
ff30.00b9 ---> Absolute.MTMinor
ff30.00ba ---> Absolute.MTMajorW
ff30.00bb ---> Absolute.MTMinorW

All of these should be ignored by the input mapping.

Thanks,
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
