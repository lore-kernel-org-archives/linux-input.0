From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC][PATCH] correct some quirks for trust 15351 bluetooth
 mouse
Date: Thu, 19 Jun 2008 11:14:33 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806191111000.4593@jikos.suse.cz>
References: <1212175271.22054.19.camel@note.localnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:57951 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753737AbYFSJOf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2008 05:14:35 -0400
In-Reply-To: <1212175271.22054.19.camel@note.localnet>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Ilnseher <illth@gmx.de>
Cc: vojtech@ucw.cz, linux-input@vger.kernel.org

On Fri, 30 May 2008, Thomas Ilnseher wrote:

> I recently got a (trust 15351) bluetooth mouse.
>
> when I hooked it up to my notebook, Only the Y-Axis did work,
> not the X-Axis. with some help from peter hutterer, I could track the
> problem down an hid->usage of 0006.0020 that got mapped to abs.misc,
> which confused evdev.
>
> There is also a Consumer.HWheel reported, which is not present on the
> mouse, but is a further annoyance (it gets mapped to buttens 6/7,
> that remaps the real buttons 6/7 to 8/9, and you have to use xmodmap).
>
> I composed this patch to make the hid driver ignore these two "features"
> of the mouse.
>
> I'm not sure if this is the right way to do things.

Hi Thomas,

yes, the patch is OK, thanks. I would just prefer if you could change 
this:

> @@ -387,6 +387,8 @@
>
>         /* handle input mappings for quirky devices */
>         ret = hidinput_mapping_quirks(usage, input, &bit, &max);
> +       if (ret == 2)
> +               goto ignore;
>         if (ret)
>                 goto mapped;

and introduce some constants for return values of hidinput_mapping_quirks 
to make this more readable.

I.e. something like HIDINPUT_QUIRK_MAPPED, HIDINPUT_QUIRK_IGNORED, 
HIDINPUT_QUIRK_NONE, and return these values from 
hidinput_mapping_quirks() and all the quirk mapping functions, instead of 
values 0, 1 and 2.

Also, please send the patch with your Signed-off-by: line, so that I can 
merge it into my tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs
