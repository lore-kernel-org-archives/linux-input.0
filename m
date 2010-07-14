From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: Re: usbtouchscreen - runtime PM patches testing [Was: [PATCH 1/2]
	Input: usbtouchscreen - add support for ET&T TC4UM touchscreen
	controller]
Date: Wed, 14 Jul 2010 12:43:27 +0200
Message-ID: <20100714104327.GW15039@ibawizard.net>
References: <20100603075720.GQ26052@ibawizard.net> <20100628164603.GC11670@core.coreip.homeip.net> <20100630071635.GJ15039@ibawizard.net> <201006301504.51681.oneukum@suse.de>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:33783 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab0GNKnc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 06:43:32 -0400
Content-Disposition: inline
In-Reply-To: <201006301504.51681.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Oliver Neukum <oneukum@suse.de> [2010-06-30 15:04:51]:

Hi,

> 1. indeed a few suspend & resume cycles

it seems to work, although I've tested it with the suspend to RAM only with 
'echo devices > /sys/power/pm_test', the complete suspend doesn't work on my
laptop. I hope it's enough. If the whole cycle is necessary I can try to test
it on 

I was testing it with 'cat /dev/input/touchscreen | od -x' and without your
patches the device dissapeared after the resume cycle. With your patches it was
still working fine after 5-6 suspend and resume cycles.

> 2. to know what happens if you switch runtime power management on with
> echo "auto" >/sys/bus/usb/devices/$DEVICE/power/level

Sorry my ignorance, but what should happen? I don't follow PM stuff that much.
I've enabled auto and the touchscreen is still working and nothing has
changed, is it ok?

-- ynezz
