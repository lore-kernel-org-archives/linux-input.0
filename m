From: =?windows-1252?Q?S=E9bastien_Bourdeauducq?= <sb@m-labs.hk>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on Thinkpad
 Tablet 10
Date: Mon, 02 Feb 2015 23:32:19 +0800
Message-ID: <54CF9883.10701@m-labs.hk>
References: <54CCEE3D.9040306@m-labs.hk> <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com> <54CD9D0D.20402@m-labs.hk> <20150202100031.GP22740@lahna.fi.intel.com> <54CF7977.1090105@m-labs.hk> <20150202134805.GT22740@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([88.198.40.39]:35265 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbbBBPhX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 10:37:23 -0500
In-Reply-To: <20150202134805.GT22740@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On 02/02/2015 09:48 PM, Mika Westerberg wrote:
> On Mon, Feb 02, 2015 at 09:19:51PM +0800, Sebastien Bourdeauducq wrot=
e:
>> With this computer nothing is normal. Every single component except =
the CPU,
>> display and USB has major issues under Linux.
>=20
> We need to get one here then. Can you point me to the exact model?

That's a Lenovo Thinkpad Tablet 10, P/N 20C3001VHH. What would be the
plan for you to get one?

> Since it has 20k internal pull-up configured, I'm guessing something
> (the digitizer) drives it low like it still has something to report. =
Do
> you see in the dmesg if the i2c-hid.c is able to read reports from th=
e
> device?

When I made the interrupt falling edge sensitive, i2c-hid was able to
read the first report as I could move the mouse cursor once using the
stylus.

A possible scenario is:
1) the digitizer is holding the interrupt line low after booting
2) enumerating or otherwise initializing the digitizer causes it to
release the interrupt line
3) using the stylus queues several reports in the device and it asserts
the interrupt line again. However, with the interrupt configured as edg=
e
sensitive, only the first of those reports are retrieved and subsequent
ones are lost, with the interrupt line stuck.

Maybe the interrupt should be level sensitive and enabled only after
certain parts of the device initialization have taken place.

S=E9bastien

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
