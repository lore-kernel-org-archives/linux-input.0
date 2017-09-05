From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Fix system-control buttons not
 working
Date: Tue, 5 Sep 2017 11:42:19 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709051138010.4077@jbgna.fhfr.qr>
References: <20170822063752.3235-1-hdegoede@redhat.com> <dc4a4a3d-f8be-2436-7959-2c9b34179586@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54915 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750975AbdIEJmU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 5 Sep 2017 05:42:20 -0400
In-Reply-To: <dc4a4a3d-f8be-2436-7959-2c9b34179586@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Thu, 31 Aug 2017, Hans de Goede wrote:

> > Some laptops have system-control buttons (e.g. KEY_SLEEP) on the same
> > interface as a hid-multitouch touch-pad.
> > 
> > This commit fixes these buttons not working.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> What is the status of this patch ? It would be nice to get this
> bug-fix into 4.14.

I have been on vacation for past 14 days. I'll process this patch in the 
second wave once current merge window pull request is processed, and will 
be applied still as 4.14 bugfix.

-- 
Jiri Kosina
SUSE Labs

