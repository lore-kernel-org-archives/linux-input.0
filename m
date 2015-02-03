From: =?windows-1252?Q?S=E9bastien_Bourdeauducq?= <sb@m-labs.hk>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on Thinkpad
 Tablet 10
Date: Tue, 03 Feb 2015 16:53:14 +0800
Message-ID: <54D08C7A.6070905@m-labs.hk>
References: <54CCEE3D.9040306@m-labs.hk> <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com> <54CD9D0D.20402@m-labs.hk> <20150202100031.GP22740@lahna.fi.intel.com> <54CF7977.1090105@m-labs.hk> <20150202134805.GT22740@lahna.fi.intel.com> <54CF9883.10701@m-labs.hk> <20150202155753.GW22740@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([88.198.40.39]:41876 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbbBCI6Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 03:58:16 -0500
In-Reply-To: <20150202155753.GW22740@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On 02/02/2015 11:57 PM, Mika Westerberg wrote:
>> > Maybe the interrupt should be level sensitive and enabled only after
>> > certain parts of the device initialization have taken place.
> The device should respond to reset by asserting an interrupt. You could
> try so that you only enable the interrupt in i2c_hid_parse() right
> before i2c_hid_hwreset() is called.

No luck. There is no more interrupt flood and the device is detected and
its report descriptor retrieved, but then no events at all are received
when using the stylus.

