From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Mon, 30 Nov 2009 10:27:37 +0200
Message-ID: <20091130082737.GA27979@gw.healthdatacare.com>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org> <87hbsd2b17.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43801 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbZK3I1g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 03:27:36 -0500
Received: by bwz27 with SMTP id 27so2292501bwz.21
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2009 00:27:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87hbsd2b17.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Nov 29, 2009 at 11:58:44PM +0100, Ferenc Wagner wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Sun, 29 Nov 2009, Ferenc Wagner wrote:
> >
> >> I thought we'd better ask our friends over at linux-pm, if they've got
> >> some interface for this task.  To summarize: an embedded application
> >> wants to go into a "locked" state, where some input devices (gpio keys
> >> in this case) are "muted", ie. they don't even generate interrupts to
> >> minimize power consumption.  This could be solved by adding a new
> >> interface to gpio-keys, but the problem seems more general, so I wonder
> >> if something like the USB selective runtime suspend is already available
> >> (or preferable to develop) for such tasks.
> >
> > See Documentation/power/runtime_pm.txt.  I don't know to what extent 
> > the input layer has implemented any runtime PM.
> 
> Hi Alan,
> 
> Looks like it wasn't a bright idea from me to mention runtime suspend
> above.  We are looking from something else: some way to forcefully put a
> device to "sleep" even thogh it's open (used), because we don't want to
> receive input from it but want to save power instead.

Hi Feri,

Also in our case, the device is not always in sleep when something needs
to be disabled. For example we might want to disable proximity "button"
when the phone application is not running.

So this is really about "muting" the gpio lines. The ultimate reason behind
this is, obviously, to save battery as much as possible. But these decisions
of muting the buttons come from the user-space.

If it suits you, I would go with the "can_disable" -field in the struct
gpio_keys_button. This way it should be possible to extend gpio-keys in
future to support multiple buttons sharing the single IRQ and it also
works for us. So If it is OK for you, I can prepare patch that does this
and send it to linux-input ml.

BTW: maybe this sharing the IRQ line between multiple buttons could be
implemented with threaded irq handler? Then it can go to sleep if, for
some reason, gpio_get_value() sleeps. Unfortunately I don't have such
hardware so I can't test it.

Thanks,
MW
