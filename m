From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Fix system-control buttons not
 working
Date: Wed, 6 Sep 2017 10:54:41 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061054320.4077@jbgna.fhfr.qr>
References: <20170822063752.3235-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752021AbdIFIyn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 04:54:43 -0400
In-Reply-To: <20170822063752.3235-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Tue, 22 Aug 2017, Hans de Goede wrote:

> Some laptops have system-control buttons (e.g. KEY_SLEEP) on the same
> interface as a hid-multitouch touch-pad.
> 
> This commit fixes these buttons not working.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-4.14/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

