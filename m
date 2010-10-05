From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RESEND] [PATCH] Input: add appleir USB driver
Date: Tue, 5 Oct 2010 18:07:36 +0200
Message-ID: <201010051807.36551.oliver@neukum.org>
References: <1285844276.26405.26.camel@cookie.hadess.net> <201010050818.35118.oliver@neukum.org> <20101005155552.GB19730@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:40817 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab0JEQGi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 12:06:38 -0400
In-Reply-To: <20101005155552.GB19730@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>

Am Dienstag, 5. Oktober 2010, 17:55:52 schrieb Dmitry Torokhov:
> > Yes, but based on sane timing. From the time stamps user space
> > would conclude that the key had been pressed at an unknown time
> > before open and released at the time the event indicates. Possibly
> > it would compute that the key had been held for at least hours.
> > 
> 
> I do not understand. If a client never seen the "press" event and only
> saw "release" event it can't make any assumptions about timing. Press
> could be a millisecond ago or an hour ago, it just does not know. And
> such scenario can easily happen if the client is second to open the
> device.

As soon as you open a device you see key presses. If you see a release
without a press, the press must have happened before you opened.
So if you know when you opened and when a key is released, you'll
have a lower limit on how long the key must have been held down.

	Regards
		Oliver
