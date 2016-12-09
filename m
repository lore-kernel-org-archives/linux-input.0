From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] i2c-hid: Disable IRQ before freeing buffers
Date: Fri, 9 Dec 2016 13:20:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612091319500.16984@cbobk.fhfr.pm>
References: <20161206204835.7665-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43893 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933164AbcLIMUo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 07:20:44 -0500
In-Reply-To: <20161206204835.7665-1-jprvita@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux@endlessm.com, =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 6 Dec 2016, João Paulo Rechi Vita wrote:

> The HID report buffers that are initially allocated on i2c_hid_probe()
> might not be big enough to hold the HID reports from a specific device,
> in which case they will be freed and new ones will be allocated in
> i2c_hid_start(), at point which the device's report size is known. But
> at this point ihid->irq is already running, and may call
> i2c_hid_get_input() which passes ihid->inbuf to i2c_master_recv(). Since
> this handler runs in a separate thread, ihid->inbuf may be freed at this
> very moment, and i2c_master_recv() will write on memory which may be
> already owned by a different part of the kernel, corrupting its data.
> 
> This problem has been observed on an Asus UX360UA laptop which has an
> I2C touchpad, and results in a complete system freeze or an unusable
> slowness with a lof of "BUG: unable to handle kernel paging request at
> <address>" warnings. Enabling SLUB debugging shows a use-after-free
> warning on memory allocated in i2c_hid_alloc_buffers() and freed in
> i2c_hid_free_buffers():
> 
> =============================================================================
> BUG kmalloc-64 (Not tainted): Poison overwritten
> -----------------------------------------------------------------------------
[ ... snip ... ]

Excellent report, applied, thanks!

-- 
Jiri Kosina
SUSE Labs

