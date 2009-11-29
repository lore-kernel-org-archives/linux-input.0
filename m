From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: Re: [PATCH] Input: usbtouchscreen - add support for ET&T TC5UH
	touchscreen controller
Date: Sun, 29 Nov 2009 12:36:59 +0100
Message-ID: <20091129113659.GB31105@ibawizard.net>
References: <1259405677-9416-1-git-send-email-ynezz@true.cz> <20091129053020.GT6936@core.coreip.homeip.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:56759 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbZK2Lg4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 06:36:56 -0500
Content-Disposition: inline
In-Reply-To: <20091129053020.GT6936@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>, linux-input@vger.kernel.org, Jiri Kosina <jikos@novell.com>

Dmitry Torokhov <dmitry.torokhov@gmail.com> [2009-11-28 21:30:21]:

> The link abouve mentions HID compliance? Does it not wok properly with
> HID driver? Do we need to blacklist it in HID?

Thinking about it again, we maybe need to blacklist it in HID, because it
can be picked up by hidraw driver.

-- ynezz
