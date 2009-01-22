From: Phil Sutter <n0-1@freewrt.org>
Subject: Driver for the S1 button of rb532
Date: Thu, 22 Jan 2009 20:12:06 +0100
Message-ID: <20090122191230.F05AF400E106@mail.nwl.cc>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:45239 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756117AbZAVTMc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2009 14:12:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>


Hi,

I've written a polled input device driver for the S1 button built into
the Routerboard 532. Sadly, the gpio-keys driver can't be used, as it
turns on the GPIO as interrupt source (which then has to stay configured
for this use), which would render the serial console unusable as it uses
the same pin in alternate function mode.

I've split up the changes into two parts to divide BSP changes from the
actual driver.

Greetings, Phil
