From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/14] HID: validate HID report id size
Date: Thu, 29 Aug 2013 11:36:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308291135260.23267@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282158220.22181@pobox.suse.cz> <alpine.LNX.2.00.1308291102380.23267@pobox.suse.cz> <CAN+gG=FuTm0Mn-gTZeOEict90SBuppjHx5Ag4MPb5h1bC+2YUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48324 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab3H2JgS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 05:36:18 -0400
In-Reply-To: <CAN+gG=FuTm0Mn-gTZeOEict90SBuppjHx5Ag4MPb5h1bC+2YUQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Kees Cook <keescook@chromium.org>

On Thu, 29 Aug 2013, Benjamin Tissoires wrote:

> >> The "Report ID" field of a HID report is used to build indexes of
> >> reports. The kernel's index of these is limited to 256 entries, so any
> >> malicious device that sets a Report ID greater than 255 will trigger
> >> memory corruption on the host:
> >>
> >> [ 1347.156239] BUG: unable to handle kernel paging request at ffff88094958a878
> >> [ 1347.156261] IP: [<ffffffff813e4da0>] hid_register_report+0x2a/0x8b
> >>
> >> CVE-2013-2888
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> Cc: stable@kernel.org
> >
> > Applied this one to hid.git#for-3.11/CVE-2013-2888
> 
> Well, I am a little bit lost here. I know the patch will not break any
> existing things, but still, I really can not understand how this can
> happen:
> 
> - Report IDs are specifically specified to be 1-byte fields. That
> means that the max they can have is 0xFF, which is 255 :-/

Hmm, with a specially crafted device, you can end up with item->size > 1 
coming out from fetch_item() for report ID, no?

-- 
Jiri Kosina
SUSE Labs
