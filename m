From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/2] HID: multitouch: enable Surface 3 Type Cover Pro
 to report multitouch data
Date: Fri, 20 Jan 2017 15:18:30 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701201518130.25515@cbobk.fhfr.pm>
References: <1484819753.20429.4.camel@gmail.com> <1484825530-30326-1-git-send-email-barracks510@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbdATOdx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 09:33:53 -0500
In-Reply-To: <1484825530-30326-1-git-send-email-barracks510@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Chen <barracks510@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, 19 Jan 2017, Dennis Chen wrote:

> Nearly identical to the previous set of patches related to Microsoft
> Surface Keyboards.
> 
> Removes Surface Pro 3 generation TypeCover support from hid-microsoft
> so proper multitouch data can be reported from the touchpad.
> 
> Signed-off-by: Dennis Chen <barracks510@gmail.com>

Both applied to hid.git#for-4.11/microsoft. Thanks,

-- 
Jiri Kosina
SUSE Labs

