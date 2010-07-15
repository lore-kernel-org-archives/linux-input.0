From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: Re: usbtouchscreen - runtime PM patches testing [Was: [PATCH 1/2]
	Input: usbtouchscreen - add support for ET&T TC4UM touchscreen
	controller]
Date: Thu, 15 Jul 2010 08:39:14 +0200
Message-ID: <20100715063914.GY15039@ibawizard.net>
References: <20100603075720.GQ26052@ibawizard.net> <201006301504.51681.oneukum@suse.de> <20100714104327.GW15039@ibawizard.net> <201007141423.04634.oneukum@suse.de>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:60620 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab0GOGjR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jul 2010 02:39:17 -0400
Content-Disposition: inline
In-Reply-To: <201007141423.04634.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Oliver Neukum <oneukum@suse.de> [2010-07-14 14:23:04]:

> This is quite good already. Ideally in the /sys/bus/usb/devices/$DEVICE/power
> directory active_duration should grow slower than connected_duration.

Yes, it's behaving as you described.

-- ynezz
