From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RESEND] [PATCH] Input: add appleir USB driver
Date: Tue, 5 Oct 2010 08:18:35 +0200
Message-ID: <201010050818.35118.oliver@neukum.org>
References: <1285844276.26405.26.camel@cookie.hadess.net> <201010050802.14271.oliver@neukum.org> <20101005060822.GD15355@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:34263 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab0JEGRg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 02:17:36 -0400
In-Reply-To: <20101005060822.GD15355@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>

Am Dienstag, 5. Oktober 2010, 08:08:22 schrieb Dmitry Torokhov:
> > But what about the next opener? He'll get a completely spurious
> > key release event, as the next key is pressed.
> 
> How does the opening of a device handle relate to a device state?

It doesn't.

> Userspace should expect to see releases without presses (in case they
> weren't the first client that opened the device).

Yes, but based on sane timing. From the time stamps user space
would conclude that the key had been pressed at an unknown time
before open and released at the time the event indicates. Possibly
it would compute that the key had been held for at least hours.

	Regards
		Oliver
