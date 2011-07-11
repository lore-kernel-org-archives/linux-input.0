From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: fix horizontal wheel for ms comfort mouse 4500
Date: Mon, 11 Jul 2011 14:47:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107111445360.11049@pobox.suse.cz>
References: <CAEbykaXLRazgQhXuZtkhHUw8+eCPNWQ68jsRMZ2E=F6FbmjbUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35486 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab1GKMrL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 08:47:11 -0400
In-Reply-To: <CAEbykaXLRazgQhXuZtkhHUw8+eCPNWQ68jsRMZ2E=F6FbmjbUw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ari Savolainen <ari.m.savolainen@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 4 Jul 2011, Ari Savolainen wrote:

> Microsoft comfort mouse 4500 has a report descriptor that contains
> usage Consumer.HorizontalWheel three times under three different
> input reports (the report descriptor from debugfs is copied
> below).
> 
> The first of the usages gets mapping REL_WHEEL, but the other two
> get REL_DIAL and REL_MISC due this loop in function
> hidinput_configure_usage (in hid-input.c soon after label
> 'mapped'):
> 
> 	while (usage->code <= max && test_and_set_bit(usage->code, bit))
> 		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
> 
> REL_MISC gets eventually reported when the horizontal wheel is used.
> 
> The purpose of the loop is not clear and deserves, perhaps, an
> explanatory comment. Most of the code works around the loop by
> using map_xxx_clear macros anyway.
> 
> The patch below introduces another such macro (map_rel_clear) and
> changes the wheel mapping to use it.
> 
> It would have been possible to add another quirk in
> hid-microsoft.c but the proposed patch seems to be more in line to
> what is currently done in similar cases. 

Hi,

thanks a lot for debuging this.

For rational of HWHEEL mapping, please see commit 25914662b.

So what I'd like to ask you to do instead would be adding a new quirk. 
Wouldn't DUPLICATE_USAGES be enough here?

If not, please just add a really simple quirk into hid-microsoft.

Thanks,

-- 
Jiri Kosina
SUSE Labs
