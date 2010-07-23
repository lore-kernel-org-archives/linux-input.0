From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 4/6] *	Register platform interface
Date: Fri, 23 Jul 2010 16:38:59 +0100
Message-ID: <20100723163859.1a8bfe7d@linux.intel.com>
References: <20100723134852.19151.6999.stgit@localhost.localdomain>
	<20100723135219.19151.98855.stgit@localhost.localdomain>
	<20100723160716.GA21546@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11772 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760208Ab0GWQLc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 12:11:32 -0400
In-Reply-To: <20100723160716.GA21546@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: greg@kroah.com, linux-input@vger.kernel.org

> I am confused here... Are you having a separate SPI driver create a
> platform device and then you have mrstouch to bind to this
> intermediate platform device? Are you doing that so you can introduce
> I2C interface later? If so I think I prefer how adxl34x and ad7879
> drivers are structured - they are split into core and interface parts
> but do not require extra devices/drivers (see in my 'next' brnach).

There is no SPI interface to the device. It ended up in the kernel SPI
because old versions of the device firmware listed it in the firmware
tables as SPI and rather than doing the right thing (correcting the
type) the x86 code created an SPI device for it.

At a certain level it may be SPI, but it's all hidden behind the
firmware on the SCU and nothing to do with Linux SPI at all.


Alan
