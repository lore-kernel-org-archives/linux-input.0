From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: asus: Add touchpad max x/y and resolution info
 for the T200TA
Date: Tue, 23 Jan 2018 15:45:21 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801231545060.11852@cbobk.fhfr.pm>
References: <20180105110919.30399-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51075 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbeAWOpX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 09:45:23 -0500
In-Reply-To: <20180105110919.30399-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Fri, 5 Jan 2018, Hans de Goede wrote:

> The Asus T200TA uses the same USB device-id for its keyboard dock as the
> T100TA, but the touchpad has a different size and corresponding different
> max x/y values.
> 
> Add a separate asus_touchpad_info struct for the T200TA and select this
> based on the DMI product-name (as we are already doing for the T100HA),
> so that we report the correct info to userspace.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Unhappily applied both to for-4.16/hid-quirks-cleanup/asus. Thanks,

-- 
Jiri Kosina
SUSE Labs

