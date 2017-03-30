From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: asus: Add missing Fn key maps on ASUS E200H
Date: Thu, 30 Mar 2017 11:19:21 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1703301117560.31814@cbobk.fhfr.pm>
References: <20170327084104.18105-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932774AbdC3JTZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Mar 2017 05:19:25 -0400
In-Reply-To: <20170327084104.18105-1-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matjaz Hegedic <matjaz.hegedic@gmail.com>

On Mon, 27 Mar 2017, Takashi Iwai wrote:

> The mapping of a few Fn combo keys seems missing since they are vendor
> specific usage page (0xff31).  Add the mapping manually for sleep
> (Fn-F1), rfkill (Fn-F2), brightness down (Fn-F5), brightness up
> (Fn-F6), display toggle (Fn-F7), and touchpad toggle (Fn-F9).
> For the display toggle and the touchpad toggle, KEY_SCREENLOCK and
> KEY_F21 are assigned as convention.
> 
> The monitor switch (Fn-F8), and audio volume down / up /mute (Fn-F10,
> F11, F12) work as is without the extra mapping, thus left as is.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

I think is has already been covered by Matjaz's (adding to CC) patches in 
hid.git#for-4.12/asus. Could you please check whether it covers everything 
your patch did?

Thanks,

-- 
Jiri Kosina
SUSE Labs

