From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [Uclinux-dist-devel] [PATCH] Input: ad7879: support auxiliary GPIOs via gpiolib
Date: Thu, 7 Jan 2010 11:16:19 -0500
Message-ID: <201001071116.19616.rgetz@blackfin.uclinux.org>
References: <1262848702-24968-1-git-send-email-vapier@gentoo.org> <20100107073114.GC2314@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:49736 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab0AGQQV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 11:16:21 -0500
In-Reply-To: <20100107073114.GC2314@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: uclinux-dist-devel@blackfin.uclinux.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu 7 Jan 2010 02:31, Dmitry Torokhov pondered:
> Hi Michael,
> 
> On Thu, Jan 07, 2010 at 02:18:22AM -0500, Mike Frysinger wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> > 
> > Drop the simple fancy sysfs hooks for the aux GPIOs and expose these via
> > the gpiolib interface so that other drivers can use them.
>
> Would not that mess up current users (if any) that may rely on the
> existing sysfs attributes?

We have talked  to the existing users of this (that we know of), and they 
agreed that doing things the "standard" way with gpiolib is the better way to 
move forward on things.

-Robin
