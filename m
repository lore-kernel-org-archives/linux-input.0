From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Tue, 17 Jun 2008 10:39:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806171038310.2513-100000@iolanthe.rowland.org>
References: <20080617100959.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60267 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757218AbYFQOjQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 10:39:16 -0400
In-Reply-To: <20080617100959.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Ville Syrj?l? <syrjala@sci.fi>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Peter Stokes <linux@dadeos.co.uk>

On Tue, 17 Jun 2008, Dmitry Torokhov wrote:

> Input core only protects open() and close(); connect() and
> disconnect() belong to respective bus's implementation the device is
> sitting on and input core has no authority over it.

What about open vs. unregister?  The input core must have some 
protection for those two.

Alan Stern

