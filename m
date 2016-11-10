From: Jiri Kosina <jikos@kernel.org>
Subject: RE: [PATCH v3] HID:i2c-hid: add a simple quirk to fix device
 defects
Date: Thu, 10 Nov 2016 10:15:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611101014150.29400@cbobk.fhfr.pm>
References: <1478749633-28185-1-git-send-email-hn.chen@weidahitech.com> <alpine.LNX.2.00.1611100940020.29400@cbobk.fhfr.pm> <22498D53301C4D4A8FFA8F02C7C3C7C06DDE7669@mail02.WHT.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754394AbcKJJPG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 04:15:06 -0500
In-Reply-To: <22498D53301C4D4A8FFA8F02C7C3C7C06DDE7669@mail02.WHT.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, 10 Nov 2016, Hn Chen wrote:

> Hi Jiri,
> 
> We had a proprietary driver for WDT8756 in /input/touchscreen.
> Just thought the product_id might be useful in the future.
> Should I remove it out ?

Yeah, please bring it in only if it's actually used in code. I will remove 
it while applying the patch, no need for you to resubmit just because of 
this.

-- 
Jiri Kosina
SUSE Labs

