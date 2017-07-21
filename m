From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: fix "always poll" quirk
Date: Fri, 21 Jul 2017 18:15:02 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707211814230.4705@cbobk.fhfr.pm>
References: <20170713001424.GA7990@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753473AbdGUQPG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Jul 2017 12:15:06 -0400
In-Reply-To: <20170713001424.GA7990@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Olof Johansson <olof@lixom.net>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 12 Jul 2017, Dmitry Torokhov wrote:

> Even though the IO for devices with "always poll" quirk is already running,
> we still need to set HID_OPENED bit in usbhid->iofl so the interrupt
> handler does not ignore the data coming from the device.
> 
> Reported-by: Olof Johansson <olof@lixom.net>
> Tested-by: Olof Johansson <olof@lixom.net>
> Fixes: e399396a6b0 ("HID: usbhid: remove custom locking from usbhid_open...")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Ah, pitty I've missed this one for the yesterday pull request, sorry for 
that. Applied now to for-4.13/upstream-fixes and will be sending upstream 
next week.

Thanks,

-- 
Jiri Kosina
SUSE Labs

