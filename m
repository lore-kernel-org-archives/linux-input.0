From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: input: throttle battery uevents
Date: Tue, 15 Aug 2017 10:56:48 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708151056340.30597@cbobk.fhfr.pm>
References: <20170810194756.GA15567@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751723AbdHOI4u (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Aug 2017 04:56:50 -0400
In-Reply-To: <20170810194756.GA15567@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 10 Aug 2017, Dmitry Torokhov wrote:

> The power_supply subsystem tends to emit uevent every time
> power_supply_changed() is called, so we should call this API only when
> battery strength reported by the device is actually different from the
> previous readings, otherwise we'll drown the system in uevents.
> 
> Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to for-4.14/battery. Thanks,

-- 
Jiri Kosina
SUSE Labs

