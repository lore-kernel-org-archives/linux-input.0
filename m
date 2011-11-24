From: Andreas =?iso-8859-1?Q?H=FCbner?= <andreas@k4n.de>
Subject: Re: Saitek PS1000 gamepad - HID descriptor wonky
Date: Thu, 24 Nov 2011 09:12:24 +0100
Message-ID: <20111124081205.GA22623@tapura>
References: <20111122102832.GA22152@v36691.1blu.de>
 <95ab6669b51867deb14cdd81c79dead1.squirrel@host171.canaca.com>
 <20111123084340.GA18805@tapura>
 <3b70c0a60fd5821240583b7b5c1412b0.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v36691.1blu.de ([89.202.1.191]:43997 "EHLO v36691.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab1KXIMk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Nov 2011 03:12:40 -0500
Content-Disposition: inline
In-Reply-To: <3b70c0a60fd5821240583b7b5c1412b0.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

Hi Simon,

> As you probably noticed this HID descriptor is a little 'weird'.
>
> First it defines 6 usages
> [...]
> but then only says they are 5 inputs

Indeed. Actually, the controller only has 5 axes. Two analog sticks (4 axes)
and a throttle that is linked to the trigger buttons. Pressing the left
trigger yields a negative axis value and the right trigger produces
positive values. (I assume it's for controlling the acceleration, etc.)
This axis also has a threshold in the positive and negative range each
triggering a button press.

> So the next question has to be how committed to your ($15??) game pad are
> you, and are you will to go through the pain of building/submitting
> patches? It's a great opportunity to put 'kernel dev' on your resume ;-)

Well, I'm always happy when I can hack some code, so count me in. :)
Usually, the only problem for me is to get a decent setup to start
debugging.

But I guess, I'll have to learn a bit more about HID descriptors before
I can start hacking.

> Otherwise you could look at 'drivers/hid/hid-elecom.c' as a template for
> your patch.

Will take a look at it - thanks!


Andreas
