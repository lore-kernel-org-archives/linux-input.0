From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH 2/2] input: add driver for S1 button of rb532
Date: Sat, 24 Jan 2009 15:20:27 +0100
Message-ID: <20090124141705.96C694CEAE@mail.nwl.cc>
References: <1232651528-19870-1-git-send-email-n0-1@freewrt.org> <1232651528-19870-2-git-send-email-n0-1@freewrt.org> <20090122191216.15285400E106@mail.nwl.cc> <Pine.LNX.4.64.0901240934040.13803@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:33665 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbZAXORJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Jan 2009 09:17:09 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0901240934040.13803@anakin>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>

Hi,

On Sat, Jan 24, 2009 at 09:34:43AM +0100, Geert Uytterhoeven wrote:
> What happens when you receive UART input while the UART is disabled? Is it
> lost?

Yes, the input is lost, as well as any output sent by the device while
UART0 is disabled. I've tested this adding a msleep() of 5s in between
the calls to set_latch_u5() and increasing the delay between polls to
10s.

I've tried to reproduce this behaviour without the changes from above
using a loop flooding the output of the serial console with increasing
numbers, with somehow strange results. Instead of missing some output,
occasionally the log shows additional characters (some non-printable).
Also (seldomly) digits are replaced by other chars (also not necesarily
printable).

So I can at least assume the two drivers interfere with each other,
which could lead to bad results when using the UART for more advanced
stuff. Although it may be possible to introduce some kind of locking for
the serial output, I doubt this can be done with the input part, as the
device is turned off while polling so data shouldn't even reach the device.

Any ideas?

Greetings, Phil
