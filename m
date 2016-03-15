From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: fix OOB write in
 i2c_hid_set_or_send_report()
Date: Tue, 15 Mar 2016 14:34:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603151430200.3656@cbobk.fhfr.pm>
References: <20160314222104.GA20569@dtor-ws> <20160315075946.GN22340@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37561 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbcCONeK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 09:34:10 -0400
In-Reply-To: <20160315075946.GN22340@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Duggan <aduggan@synaptics.com>, Alexander Potapenko <glider@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 Mar 2016, Benjamin Tissoires wrote:

> > BUG: KASAN: slab-out-of-bounds in memcpy+0x34/0x54 at addr ffffffc07135ea80
> > Write of size 4101 by task syz-executor/8747
> > CPU: 2 PID: 8747 Comm: syz-executor Tainted: G    BU         3.18.0 #37
> > Hardware name: Google Tegra210 Smaug Rev 1,3+ (DT)
> > Call trace:
> > [<ffffffc00020ebcc>] dump_backtrace+0x0/0x258 arch/arm64/kernel/traps.c:83
> > [<ffffffc00020ee40>] show_stack+0x1c/0x2c arch/arm64/kernel/traps.c:172
> > [<     inline     >] __dump_stack lib/dump_stack.c:15
> > [<ffffffc001958114>] dump_stack+0x90/0x140 lib/dump_stack.c:50
> > [<     inline     >] print_error_description mm/kasan/report.c:97
> > [<     inline     >] kasan_report_error mm/kasan/report.c:278
> > [<ffffffc0004597dc>] kasan_report+0x268/0x530 mm/kasan/report.c:305
> > [<ffffffc0004592e8>] __asan_storeN+0x20/0x150 mm/kasan/kasan.c:718
> > [<ffffffc0004594e0>] memcpy+0x30/0x54 mm/kasan/kasan.c:299
> > [<ffffffc001306354>] __i2c_hid_command+0x2b0/0x7b4 drivers/hid/i2c-hid/i2c-hid.c:178
> > [<     inline     >] i2c_hid_set_or_send_report drivers/hid/i2c-hid/i2c-hid.c:321
> > [<ffffffc0013079a0>] i2c_hid_output_raw_report.isra.2+0x3d4/0x4b8 drivers/hid/i2c-hid/i2c-hid.c:589
> > [<ffffffc001307ad8>] i2c_hid_output_report+0x54/0x68 drivers/hid/i2c-hid/i2c-hid.c:602
> > [<     inline     >] hid_hw_output_report include/linux/hid.h:1039
> > [<ffffffc0012cc7a0>] hidraw_send_report+0x400/0x414 drivers/hid/hidraw.c:154
> > [<ffffffc0012cc7f4>] hidraw_write+0x40/0x64 drivers/hid/hidraw.c:177
> > [<ffffffc0004681dc>] vfs_write+0x1d4/0x3cc fs/read_write.c:534
> > [<     inline     >] SYSC_pwrite64 fs/read_write.c:627
> > [<ffffffc000468984>] SyS_pwrite64+0xec/0x144 fs/read_write.c:614
> > Object at ffffffc07135ea80, in cache kmalloc-512
> > Object allocated with size 268 bytes.
> > 
> > Let's check data length against the buffer size before attempting to copy
> > data over.
> > 
> > Reported-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > ---
> > 
> > This should probably go to stable as well, leaving it to Jiri/Benjamin
> > to decide.
> 
> Works for me:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> I also think this should go to stable. Jiri, can you add the tag when
> committing?

Makes sense, thanks to both of you.

Added the Cc: stable and applied.

-- 
Jiri Kosina
SUSE Labs

