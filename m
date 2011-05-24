From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hid: assorted usage updates from hut 1.12
Date: Tue, 24 May 2011 13:57:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105241357340.28291@pobox.suse.cz>
References: <4DADDEBF.3050407@redhat.com> <1303241310-21354-1-git-send-email-jarod@redhat.com> <alpine.LNX.2.00.1105181708210.28291@pobox.suse.cz> <4DDACC93.5020105@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42717 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755284Ab1EXL6B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 07:58:01 -0400
In-Reply-To: <4DDACC93.5020105@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 23 May 2011, Jarod Wilson wrote:

> > > Outside of fixing the obviously incorrect mapping of 0xc 0x45 from
> > > KEY_RADIO to KEY_RIGHT, and making use of the new KEY_IMAGES (just added
> > > in 2.6.39-rc4) for AL Image Browser instead of KEY_MEDIA, these are
> > > purely additions, and thus should have no negative impact on any already
> > > functional HID devices. Most of the added mappings seemed to be
> > > perfectly logical to me, but there were a few that were mapped on more
> > > of an "I think this makes the most sense" basis.
> > 
> > It took me quite some time to go over the individual changes, sorry for
> > the delay. I have applied the patch.
> 
> Cool, thanks much. Any word on the follow-on TiVo Slide patch?

Hmm, it might have escaped my attention, I don't seem to have it in my 
queue. Could you please resend it?

Thanks,

-- 
Jiri Kosina
SUSE Labs
