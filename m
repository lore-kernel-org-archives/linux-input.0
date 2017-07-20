From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: asus: Add support for T100 touchpad
Date: Thu, 20 Jul 2017 16:03:45 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707201603340.4705@cbobk.fhfr.pm>
References: <20170525144921.18552-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934974AbdGTODr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Jul 2017 10:03:47 -0400
In-Reply-To: <20170525144921.18552-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Thu, 25 May 2017, Hans de Goede wrote:

> Add support for the Asus T100 touchpad in multi-touch mode (rather
> then mouse emulation mode). It turns out that the Asus T100 touchpad
> is identical to the already supported i2c-hid Asus touchpads, so
> adding support for it was easy.
> 
> The only significant difference is that the reported x-coordinates
> range on the T100 touchpad is somewhat lower then the range on the
> already supported touchpads.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-4.14/asus.

-- 
Jiri Kosina
SUSE Labs

