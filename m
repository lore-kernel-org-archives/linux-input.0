From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/evdev: Be less aggressive about sending SIGIO
 notifies
Date: Mon, 4 Jan 2010 22:51:53 -0800
Message-ID: <20100105065153.GA28872@core.coreip.homeip.net>
References: <1262639297-21857-1-git-send-email-ajax@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:49507 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab0AEGv7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2010 01:51:59 -0500
Received: by yxe26 with SMTP id 26so15360566yxe.4
        for <linux-input@vger.kernel.org>; Mon, 04 Jan 2010 22:51:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262639297-21857-1-git-send-email-ajax@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adam Jackson <ajax@redhat.com>
Cc: linux-input@vger.kernel.org

On Mon, Jan 04, 2010 at 04:08:17PM -0500, Adam Jackson wrote:
> When using realtime signals, we'll enqueue one signal for every event.
> This is unfortunate, because (for example) keyboard presses are three
> events: key, msc scancode, and syn.  They'll be enqueued fast enough in
> kernel space that all three events will be ready to read by the time
> userspace runs, so the first invocation of the signal handler will read
> all three events, but then the second two invocations still have to run
> to do no work.
> 
> Instead, only send the SIGIO notification on syn events.  This is a
> slight abuse of SIGIO semantics, in principle it ought to fire as soon
> as any events are readable.  But it matches evdev semantics, which is
> more important since SIGIO is rather vaguely defined to begin with.

Makes sense, will apply. It might mess up evtest slightly (if a driver
author forgets using input_sync() ) but we have evbug for true hardcore
debugging :)

-- 
Dmitry
