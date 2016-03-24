From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [REGRESSION] panic with Wacom One Tablet on 4.4.x kernel
Date: Thu, 24 Mar 2016 15:37:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603241534210.3656@cbobk.fhfr.pm>
References: <56E9D929.70101@redhat.com> <CAF8JNhKJLzvj=Xe8ibNCJ6-U9fJqjHFzg0uibFTBSxR4t-AmXA@mail.gmail.com> <alpine.LNX.2.00.1603241530370.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44289 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbcCXOiB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2016 10:38:01 -0400
In-Reply-To: <alpine.LNX.2.00.1603241530370.3656@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, Ping Cheng <pingc@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, 24 Mar 2016, Jiri Kosina wrote:

> > Yes, please provide a bisect report so we get a clue.
> > 
> > I do not have a "Wacom One". I have a Wacom Bamboo Pen, which goes 
> > through the same code base as "Wacom One". I tested kernel 4.4.4. I 
> > don't see the issue.
> 
> Laura, do we have any result from the bisect please?

BTW seems like wacom_get_report() got EPIPE and bailed out.

We used to retry on EPIPE before aef3156d72. Would it make sense to retest 
with that commit reverted?

Could be that the device is for some reason causing only temporary EPIPE 
that eventually gets fixed over time.

I still don't exactly see how that'd cause the null pointer dereference 
later, but retval handling wacom_get_report() might possibly need some 
loving care as well, looking quickly at the code. But that still needs to 
be investigated.

Thanks,

-- 
Jiri Kosina
SUSE Labs

