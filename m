From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFT] Input: speed up suspend/shutdown for PS/2 mice
 and keyboards
Date: Mon, 21 Dec 2009 15:29:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912211528550.2643-100000@iolanthe.rowland.org>
References: <20091221070951.GA4170@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33411 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753309AbZLUU3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 15:29:23 -0500
In-Reply-To: <20091221070951.GA4170@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>

On Sun, 20 Dec 2009, Dmitry Torokhov wrote:

> Hi,
> 
> I am asking everyone to give this patch a try. It is reported to speed
> up suspend process, however there is a risk that there are boxes out
> there that do require full reset and I would prefer to know that sooner
> than later.

It works okay on my machine (Intel ICH4).

Alan Stern

