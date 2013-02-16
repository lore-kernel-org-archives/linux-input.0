From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: new EVIOCGKEYF to get keystate and flush queues
Date: Sat, 16 Feb 2013 13:10:17 -0800
Message-ID: <20130216211017.GB22044@core.coreip.homeip.net>
References: <1357559903-1881-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:49897 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab3BPVKU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Feb 2013 16:10:20 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so1075002pbc.11
        for <linux-input@vger.kernel.org>; Sat, 16 Feb 2013 13:10:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357559903-1881-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, Ran Benita <ran234@gmail.com>

Hi David,

On Mon, Jan 07, 2013 at 12:58:23PM +0100, David Herrmann wrote:
> EVIOCGKEYF returns the current keystate similar to EVIOCGKEY but also
> flushes the outgoing evdev event queue. This allows user-space devices to
> reliably retrieve the current state without having old events still in the
> read()-queue.
> 
> Userspace libraries like XKB/xkbcommon use stacking key trackers, so they
> allow the kernel to map multiple keys to the same keycode. For instance if
> left-shift and right-shift map to the same keycode, xkbcommon allows the
> kernel to send key-down twice but also requires it to send key-up twice. A
> single input device doesn't support that, but this is very useful if you want
> multiple connected keyboards to have one shared modifier state: Pressing Shift
> on the one keyboard affects keys on the other keyboard. This is not the usual
> setup but it is supported and known to be used (for instance if you have
> external num-pads etc.).
> 
> When a program opens input devices, it can read the keystate via EVIOCGKEY
> to update its internal keyboard state. This allows to keep CTRL pressed
> while switching VTs and having both applications remember that CTRL is
> still pressed.
> However, if there are still outgoing events in the evdev queue, the
> application will update its internal keyboard state and then read the
> event again, even though it already processed it via EVIOCGKEY.
> 
> EVIOCGKEYF solves this race condition by flushing the evdev queue while
> returning the keystate. We cannot change EVIOCGKEY because we don't know
> whether userspace depends on a clean read() history and flushing the queue
> effectively drops events.
> 
> This race could be fixed in user-space by keeping an exact copy of the keystate
> array for each input device that we opened and ignoring double-events for a
> single keycode. However, if we, as mentioned, want a shared keyboard-state, it
> seems to be a waste of computing power and memory to keep another copy for each
> input device if we could just use something like EVIOCGKEYF.

I do not think we should introduce the new ioctl as I really doubt
anyone is using it and even if they do I really doubt they will have
problems if we flush the events.

But rather that flushing all events we should only flush the key events.
The relative, absolute, and other events should be kept in the queue.

Thanks.

-- 
Dmitry
