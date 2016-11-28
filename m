From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 0/3] Support multitouch touchpads in Surface TypeCover
Date: Mon, 28 Nov 2016 14:55:13 +0100
Message-ID: <20161128135512.GB2119@mail.corp.redhat.com>
References: <1480080443-7636-1-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1611281440150.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932666AbcK1NzR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 08:55:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1611281440150.29400@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dennis Chen <barracks510@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Nov 28 2016 or thereabouts, Jiri Kosina wrote:
> On Fri, 25 Nov 2016, Benjamin Tissoires wrote:
> 
> > this is mostly a resubmission of v1, with one patch exchanged.
> 
> Alright, I'd be much happier when a chage such as the one done in 1st 
> patch to hid-input would be done much earlier in the development process 
> so that we'd have much more time for catching potential regressions.

Yeah, apologies for that. We have been running this patch for a few
months now, though it was only a few people. When Andy and Dennis were
saying it was giving them some headaches I run it under KASAN and really
checked each and every step, without finding why it was not good for
them.

> 
> But I've reviewed it really thoroughly and it really seems to be fine(TM) 
> :) so I've now put all three patches into for-4.10/microsoft-surface-3.

Thanks a lot. If you don't feel confident enough to include it in 4.10,
I wouldn't mind if you prefer postponing it for 4.11 or a later 4.10-rc
(depending how it is easier for you).

Cheers,
Benjamin

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
