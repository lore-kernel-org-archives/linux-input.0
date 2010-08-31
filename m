From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 5/6] HID: magicmouse: enable Magic Trackpad support
Date: Tue, 31 Aug 2010 00:36:47 -0400
Message-ID: <1283229407.16978.0.camel@graviton>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
	 <1283188858-4839-5-git-send-email-chase.douglas@canonical.com>
	 <1283228806.14419.63.camel@graviton>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38764 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932081Ab0HaEgv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 00:36:51 -0400
Received: by mail-qy0-f181.google.com with SMTP id 33so6476684qyk.12
        for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 21:36:50 -0700 (PDT)
In-Reply-To: <1283228806.14419.63.camel@graviton>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Tue, 2010-08-31 at 00:31 -0400, Michael Poole wrote:
> On Mon, 2010-08-30 at 13:20 -0400, Chase Douglas wrote:
> > The trackpad speaks a similar, but different, protocol from the magic
> > mouse. However, only small code tweaks here and there are needed to make
> > basic multitouch work.
> > 
> > Extra logic is required for single-touch emulation of the touchpad. The
> > changes made here take the approach that only one finger may emulate the
> > single pointer when multiple fingers have touched the screen. Once that
> > finger is raised, all touches must be raised before any further single
> > touch events can be sent.
> > 
> > Sometimes the magic trackpad sends two distinct touch reports as one big
> > report. Simply splitting the packet in two and resending them through
> > magicmouse_raw_event ensures they are handled properly.
> > 
> > I also added myself to the copyright statement.
> > 
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> 
> I have no technical concerns with the patch, just two questions.  (Once
> I get the chance to test it, I expect to add my Acked-by.)

Actually, one thing slipped my mind.  This patch does not apply cleanly
to Jiri's for-next tree, because the not-yet-upstream commit 7d876c05fa
changes the context at hid-magicmouse.c's line 290 before this patch.
Manually munging the context allows the commit to apply.  Could you
rebase this patch on a tree that contains that commit?

Michael

