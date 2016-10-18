From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 07/18] HID: wacom: generic: Support and use 'Custom
 HID' mode and usages
Date: Tue, 18 Oct 2016 23:39:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1610182335240.31629@cbobk.fhfr.pm>
References: <20161006212231.31440-1-killertofu@gmail.com> <20161007221653.26941-1-killertofu@gmail.com> <20161007221653.26941-7-killertofu@gmail.com> <alpine.LNX.2.00.1610181725150.31629@cbobk.fhfr.pm> <ad4c3179-8c01-cb04-9ad4-2af49c07ca8c@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55401 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbcJRVje (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 17:39:34 -0400
In-Reply-To: <ad4c3179-8c01-cb04-9ad4-2af49c07ca8c@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 18 Oct 2016, Jason Gerecke wrote:

> >>  	if (usage->usage_index + 1 == field->report_count) {
> >> -		if (usage->hid == wacom_wac->features.last_slot_field)
> >> +		if (equivalent_usage == wacom_wac->features.last_slot_field)
> > 
> > What tree is this based on please? In all the codebase I have, 
> > last_slot_field is a member field of wacom_wac's hid_data, not a member of 
> > struct wacom_features.
> > 
> 
> This was based on your for-4.9/wacom tree, whose tip (for me) was commit
> 1924e05 ("HID: wacom - add touch_arbitration parameter to wacom module").
> 
> It looks like my tree only has commit 601a22f ("HID: wacom: Report input
> events for each finger on generic devices") 

Pardon me? That commit is from 2014 (3.19-rc1). It really shouldn't be 
used as a basis for a development.

> but not commit 003f50a ("HID: wacom: Update last_slot_field during 
> pre_report phase"). 

That's a commit that went in for 4.9-rc1 (authored by you).

> Not sure why though.
> 
> What would you like me to do?

Dunno where the confusion is coming from really. Could you please just 
rebase the patchset on top of something up to date (such as or Linus' 
git, master branch in my tree, or whatnot), and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs

