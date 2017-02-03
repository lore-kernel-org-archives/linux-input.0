From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: fix LG Melfas touchscreen
Date: Fri, 3 Feb 2017 14:47:29 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702031446230.4763@cbobk.fhfr.pm>
References: <20170130094806.7515-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbdBCNrb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 3 Feb 2017 08:47:31 -0500
In-Reply-To: <20170130094806.7515-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 30 Jan 2017, Benjamin Tissoires wrote:

> The LG Melfas touchscreen has a bad firmware where it declares the
> Contact ID field as constant while it shouldn't. This messes up the
> autodetection and the reporting of the events by hid-multitouch given
> that hid-input ignores constant fields.
> 
> The autodetection is simply worked around by manually adding the device
> to hid_have_special_driver.
> 
> The processing of the events requires either a report fixup, either some

I've fixed the grammar here ...

> specific case handling. Given that the report fixup would require to
> basically rewrite all the report descriptor, I went for the programatic
> way of fixing that after the report descriptors are loaded.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1416181
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

... and applied to for-4.10/upstream-fixes; I don't think this patch 
itself would justify a -rc7 merge by itself, therefore either something 
else accumulates in for-4.10 branch, or this will go in during 4.11 merge 
window.

Thanks,

-- 
Jiri Kosina
SUSE Labs

