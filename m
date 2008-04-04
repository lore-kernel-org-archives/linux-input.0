From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: multi-input quirk and skip output reports quirk
Date: Fri, 4 Apr 2008 16:51:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804041650290.26562@twin.jikos.cz>
References: <47F21BA7.8030306@gmail.com> <Pine.LNX.4.64.0804011610450.5541@jikos.suse.cz>
 <47F2437C.6060203@gmail.com> <Pine.LNX.4.64.0804041629030.26562@twin.jikos.cz>
 <47F63DC4.5030707@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:39452 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756796AbYDDOvM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Apr 2008 10:51:12 -0400
In-Reply-To: <47F63DC4.5030707@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org, Sam Liddicott <sam@liddicott.com>

On Fri, 4 Apr 2008, Anssi Hannula wrote:

> >>>> I've encountered another multi-input device that needs the skip output
> >>>> reports quirk (as it contains force feedback output reports), 0925:8866.
> >>>> However, maybe we should use another approach, dropping
> >>>> HID_QUIRK_SKIP_OUTPUT_REPORTS. Why not just *not* register the input
> >>>> device for that report in case the report didn't contain anything that
> >>>> was mapped by hidinput_configure_usage(), in hidinput_connect()?
> >>> as long as we still have the possibility to see the coming data in debug 
> >>> mode, I don't have objection to that.
> >> Okay.
> >>> Are you going to make that patch?
> >> Not right now, maybe in a few weeks.
> > I will meanwhile queue the patch below, ok? After the hidinput_connect() 
> > is refactored to ignore devices for which the mappings haven't been 
> > established, we could then remove all the devices for which we have 
> > HID_QUIRK_SKIP_OUTPUT_REPORTS altogether.
> Ok.
> > BTW, do you happen to have any idea whether the Quad joypad needs this 
> > quirk too?
> No, but I guess it is quite probable.

I have added Sam (who reported the need of the quirk for Quad joypad) to 
CC.

Sam?

Thanks,

-- 
Jiri Kosina
SUSE Labs

