From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-magicmouse: Add pointer and buttonpad properties
 for Magic Trackpad
Date: Tue, 21 Feb 2012 14:22:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202211422190.31150@pobox.suse.cz>
References: <1329192751-6041-1-git-send-email-chase.douglas@canonical.com> <alpine.LNX.2.00.1202211152220.31150@pobox.suse.cz> <4F437D46.6090604@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35351 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753804Ab2BUNXA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 08:23:00 -0500
In-Reply-To: <4F437D46.6090604@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

On Tue, 21 Feb 2012, Chase Douglas wrote:

> >> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> >> ---
> >>  drivers/hid/hid-magicmouse.c |    2 ++
> >>  1 files changed, 2 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> >> index 2ab7175..7cf3ffe 100644
> >> --- a/drivers/hid/hid-magicmouse.c
> >> +++ b/drivers/hid/hid-magicmouse.c
> >> @@ -418,6 +418,8 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
> >>  		__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
> >>  		__set_bit(BTN_TOOL_QUADTAP, input->keybit);
> >>  		__set_bit(BTN_TOUCH, input->keybit);
> >> +		__set_bit(INPUT_PROP_POINTER, input->propbit);
> >> +		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> >>  	}
> >>  
> >>  	if (report_touches) {
> > 
> > Applied, although a bit more verbose commit message would be welcome next 
> > time :)
> 
> Will you push this for 3.3, or keep it for 3.4?

As the old set of properties has been there since 2.6.37, I wasn't 
considering pushing this for 3.3 still. Do you feel otherwise?

Thanks,

-- 
Jiri Kosina
SUSE Labs
