From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 4/4] HID: multitouch: Combine all left-button events
 in a frame
Date: Wed, 22 Nov 2017 14:37:16 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711221436340.11505@cbobk.fhfr.pm>
References: <20171113163259.18150-1-hdegoede@redhat.com> <20171113163259.18150-4-hdegoede@redhat.com> <20171114080229.GE403@mail.corp.redhat.com> <nycvar.YFH.7.76.1711211310230.11505@cbobk.fhfr.pm> <e2f18cad-616a-9272-cad4-a3081d016745@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbdKVNhW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Nov 2017 08:37:22 -0500
In-Reply-To: <e2f18cad-616a-9272-cad4-a3081d016745@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Wed, 22 Nov 2017, Hans de Goede wrote:

> > Thanks. Hans, last request for you -- HID_DG_SCANTIME handling has in the
> > meantime added for forwarding the MSC_TIMESTAMP (commit 29cc309d8bf1).
> > Could you please respin your patch on top of that (basically just merge
> > your handling with the one added for MSC_TIMESTAMP) and resend? I'll then
> > queue it for 4.16. Thanks,
> 
> Ok, v5 with this fixed coming up.

Thanks a lot Hans.

> Since this fixes 2 touchpad models not working (not being usable at 
> least) it would be nice to get this series into 4.15 rc2/rc3 as a bugfix 
> IMHO.

Hmm, as this is changing common code paths, I'd prefer not to push it 
before next merge window really.

-- 
Jiri Kosina
SUSE Labs

