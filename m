From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on
 Thinkpad Tablet 10
Date: Mon, 2 Feb 2015 17:57:53 +0200
Message-ID: <20150202155753.GW22740@lahna.fi.intel.com>
References: <54CCEE3D.9040306@m-labs.hk>
 <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>
 <54CD9D0D.20402@m-labs.hk>
 <20150202100031.GP22740@lahna.fi.intel.com>
 <54CF7977.1090105@m-labs.hk>
 <20150202134805.GT22740@lahna.fi.intel.com>
 <54CF9883.10701@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17779 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbbBBP56 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Feb 2015 10:57:58 -0500
Content-Disposition: inline
In-Reply-To: <54CF9883.10701@m-labs.hk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?S=E9bastien?= Bourdeauducq <sb@m-labs.hk>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Mon, Feb 02, 2015 at 11:32:19PM +0800, S=E9bastien Bourdeauducq wrot=
e:
> On 02/02/2015 09:48 PM, Mika Westerberg wrote:
> > On Mon, Feb 02, 2015 at 09:19:51PM +0800, Sebastien Bourdeauducq wr=
ote:
> >> With this computer nothing is normal. Every single component excep=
t the CPU,
> >> display and USB has major issues under Linux.
> >=20
> > We need to get one here then. Can you point me to the exact model?
>=20
> That's a Lenovo Thinkpad Tablet 10, P/N 20C3001VHH. What would be the
> plan for you to get one?

Thanks.

We've been purchasing these problematic devices from time to time and
then trying to enable what we can in the mainline kernel. I'll ask my
boss if I can order one of these as well.

> > Since it has 20k internal pull-up configured, I'm guessing somethin=
g
> > (the digitizer) drives it low like it still has something to report=
=2E Do
> > you see in the dmesg if the i2c-hid.c is able to read reports from =
the
> > device?
>=20
> When I made the interrupt falling edge sensitive, i2c-hid was able to
> read the first report as I could move the mouse cursor once using the
> stylus.
>=20
> A possible scenario is:
> 1) the digitizer is holding the interrupt line low after booting
> 2) enumerating or otherwise initializing the digitizer causes it to
> release the interrupt line
> 3) using the stylus queues several reports in the device and it asser=
ts
> the interrupt line again. However, with the interrupt configured as e=
dge
> sensitive, only the first of those reports are retrieved and subseque=
nt
> ones are lost, with the interrupt line stuck.

That seems plausible explanation.

> Maybe the interrupt should be level sensitive and enabled only after
> certain parts of the device initialization have taken place.

The device should respond to reset by asserting an interrupt. You could
try so that you only enable the interrupt in i2c_hid_parse() right
before i2c_hid_hwreset() is called.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
