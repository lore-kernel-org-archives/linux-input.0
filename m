From: Sam Liddicott <sam@liddicott.com>
Subject: RE: multi-input quirk and skip output reports quirk
Date: Sat, 5 Apr 2008 07:01:28 +0100
Message-ID: <20080405055825.EA9F42FE066C@sam.liddicott.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sam.liddicott.com ([207.210.85.99]:57695 "EHLO
	sam.liddicott.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbYDEG2Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Apr 2008 02:28:16 -0400
content-class: 
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

I'm afraid I don't recognize that quirk name.

I'm all for setting quirks dynamically from user space during the plug event, as the delay between posting a patch and having it appear in distro of choice can be well over a year which is too long to remember and too long to be useful.

I do remember that there were two quirks set for the same brand of dual controller and I copied them both to the quad controller. I was asked to check if both quirks were actually needed, I still haven't had the required couple of hours to rebuild my kernel to do this and it became simpler to use the quad controller as a single controller.

I still feel guilty this but not guilty enough. Sorry.

Sam

-----Original Message-----
From: Jiri Kosina <jkosina@suse.cz>
Sent: 04 April 2008 15:51
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org; Sam Liddicott <sam@liddicott.com>
Subject: Re: multi-input quirk and skip output reports quirk

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


