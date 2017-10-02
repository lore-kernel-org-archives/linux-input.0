From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-multitouch: forward MSC_TIMESTAMP
Date: Mon, 2 Oct 2017 14:34:37 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710021434050.17517@jbgna.fhfr.qr>
References: <20170822011011.39112-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40387 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750929AbdJBMej (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Oct 2017 08:34:39 -0400
In-Reply-To: <20170822011011.39112-1-drinkcat@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, dtor@chromium.org

On Tue, 22 Aug 2017, Nicolas Boichat wrote:

> Computes and forwards the device timestamp according to the
> specification.
> 
> Many devices use a 16-bit timestamp field, with a resolution
> of 100us, therefore rolling around very frequently (every
> 6.5 seconds). To make sure there is no ambiguity, the
> timestamp reported to the input stack reset to 0 whenever
> the time between 2 received events is greater than
> MAX_TIMESTAMP_INTERVAL (1 second).
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
> 
> Inspired from Benjamin Tissoires's patch here:
> https://patchwork.kernel.org/patch/1742181/, and changing the
> logic to resynchronize the timestamps to use received time
> instead of a potentially more fragile difference between
> the 2 deltas.

Benjamin, any objections on merging this one for 4.15? I like it.

Thanks,

-- 
Jiri Kosina
SUSE Labs

