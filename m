From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Lost events in older kernels
Date: Sat, 22 May 2010 00:42:49 -0700
Message-ID: <20100522074249.GA25143@core.coreip.homeip.net>
References: <4BF7825F.2030405@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36589 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab0EVHmz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 May 2010 03:42:55 -0400
Received: by pvg4 with SMTP id 4so119084pvg.19
        for <linux-input@vger.kernel.org>; Sat, 22 May 2010 00:42:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BF7825F.2030405@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Sat, May 22, 2010 at 03:06:07AM -0400, Rafi Rubin wrote:
> I'm playing with a project with a 2.6.29 kernel, and the userspace application
> seems to miss some events.  Is there a particular fix that improved the handling?
> 
> Also tried catting the dev to a file while testing, and the dump also is missing
> some events.
>

No "interesting" patches went into evdev for a few release now...

Hm, could it be that event queue is overflowing before userspace gets a
chance to empty it. What kind of event rate are we talking here?

-- 
Dmitry
