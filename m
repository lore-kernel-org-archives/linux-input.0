From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on
 Thinkpad Tablet 10
Date: Tue, 3 Feb 2015 13:25:14 +0200
Message-ID: <20150203112514.GC18758@lahna.fi.intel.com>
References: <54CCEE3D.9040306@m-labs.hk>
 <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>
 <54CD9D0D.20402@m-labs.hk>
 <20150202100031.GP22740@lahna.fi.intel.com>
 <54CF7977.1090105@m-labs.hk>
 <20150202134805.GT22740@lahna.fi.intel.com>
 <54CF9883.10701@m-labs.hk>
 <20150202155753.GW22740@lahna.fi.intel.com>
 <54D08C7A.6070905@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4622 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725AbbBCLZS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Feb 2015 06:25:18 -0500
Content-Disposition: inline
In-Reply-To: <54D08C7A.6070905@m-labs.hk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?S=E9bastien?= Bourdeauducq <sb@m-labs.hk>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Tue, Feb 03, 2015 at 04:53:14PM +0800, S=E9bastien Bourdeauducq wrot=
e:
> On 02/02/2015 11:57 PM, Mika Westerberg wrote:
> >> > Maybe the interrupt should be level sensitive and enabled only a=
fter
> >> > certain parts of the device initialization have taken place.
> > The device should respond to reset by asserting an interrupt. You c=
ould
> > try so that you only enable the interrupt in i2c_hid_parse() right
> > before i2c_hid_hwreset() is called.
>=20
> No luck. There is no more interrupt flood and the device is detected =
and
> its report descriptor retrieved, but then no events at all are receiv=
ed
> when using the stylus.

If you now check the GPIO status in /sys/kernel/debug/gpio, does it sho=
w
'high'?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
