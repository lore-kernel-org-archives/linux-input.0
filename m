From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] HID: input: return ENODATA if reading battery attrs fails
Date: Mon, 13 May 2013 16:20:17 -0700
Message-ID: <20130513232017.GA25489@teo>
References: <1368457290-1734-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:47742 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab3ENAKJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 May 2013 20:10:09 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so13677631iee.41
        for <linux-input@vger.kernel.org>; Mon, 13 May 2013 17:10:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368457290-1734-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, David Woodhouse <dwmw2@infradead.org>

On Mon, May 13, 2013 at 05:01:30PM +0200, David Herrmann wrote:
[..]
> I really dislike the way power_supply core calls into the drivers during the
> "add" uevent. If a driver holds an I/O mutex (or anything else), it might
> even deadlock in a very non-obvious way. Is there a reason why we need to
> pass _all_ battery properties along "add" and "remove" uevents? Isn't it
> enough to pass them with "change" uevents? This would guarantee that the
> power_supply callbacks are only called from user-context and "change" events.

I don't think that there is a particular reason for that, but if you want
to change that, then I'd suggest to still keep uevent reporting of all the
properties on "add" and "remove" events, but don't actually call the
drivers' callback, just assume ENODATA.

This way we well preserve the behaviour of the older kernels, so that
userland will not break if, for example, it allocates needed memory on
"add" event, and then assumes that "change" will follow the pattern.

Thanks,

Anton
