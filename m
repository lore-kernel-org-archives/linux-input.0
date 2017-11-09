From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Wacom: switch Dell canvas into highres mode
Date: Thu, 9 Nov 2017 12:42:55 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711091242000.32604@cbobk.fhfr.pm>
References: <20171103172947.15156-1-benjamin.tissoires@redhat.com> <DE35351F-500C-41C5-90E2-18BC2B48A803@gmail.com> <20171106080503.GB9728@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753156AbdKILm6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Nov 2017 06:42:58 -0500
In-Reply-To: <20171106080503.GB9728@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 6 Nov 2017, Benjamin Tissoires wrote:

> > >well, this is not the cleanest way of handling this mode set, but it 
> > >is the less intrusive AFAICT.
> > >
> > >I was thinking that we might want to add a new field in struct 
> > >wacom_feature, but then it wouldn't make sense to keep the set mode 
> > >specifics in _wacom_query_tablet_data().
> > >
> > >So I am open to any better suggestion, but this one works and the 
> > >impact on other HID generic tablets is null.
> > >
> > 
> > Hmm. Agreed that this isn't ideal. I'd like to take a look at the 
> > descriptor, if you wouldn't mind sharing it. The hardware should be 
> > similar to other devices of ours and it might be possible to piggyback 
> > on existing code.
> >
> 
> Sure, here it comes in the hid-replay format (and with a recording
> of a single dot from the pen):

Jason,

any word on the descriptor please, did you have time to analyze it?

Merge window for 4.15 is almost there, so in case you don't want to miss 
it, I'd need your Ack/Nack/Postopne rather quickly.

Thanks,

-- 
Jiri Kosina
SUSE Labs

