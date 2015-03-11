From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] HID: i2c-hid: Fix suspend/resume when already runtime suspended
Date: Wed, 11 Mar 2015 08:06:47 -0700
Message-ID: <CAD=FV=WUNHM2eCuP68a6B3A=ASXXE1QqcVuKe6f4TVGxWQmJ8Q@mail.gmail.com>
References: <1425930287-4615-1-git-send-email-dianders@chromium.org>
	<20150310122307.GM1563@lahna.fi.intel.com>
	<CAD=FV=WmXA6SnyMx2KC9gP+Q0eVyu+kg54QkY50hKb4LsLFxng@mail.gmail.com>
	<20150311112003.GN1563@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33183 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbCKPGs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 11:06:48 -0400
Received: by igbhl2 with SMTP id hl2so37643608igb.0
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2015 08:06:47 -0700 (PDT)
In-Reply-To: <20150311112003.GN1563@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jmaneyrol@invensense.com, borneo.antonio@gmail.com, seth.forshee@canonical.com, archana.patni@linux.intel.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Mika,

On Wed, Mar 11, 2015 at 4:20 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Mar 10, 2015 at 09:12:36AM -0700, Doug Anderson wrote:
>> Thanks for testing!  Can you do a "dump_stack()" here?  I'm curious
>> why it's deciding to runtime resume.  Maybe something changed between
>> 3.14 and ToT?
>
> Here you go:
>
> [   26.711737] i2c_hid i2c-ATML1000:00: PM: i2c-hid runtime resume
> [   26.711754] CPU: 3 PID: 123 Comm: sh Not tainted 4.0.0-rc3+ #6
> [   26.711775]  ffff88007604c600 ffff88007ba77ae8 ffffffff8183966e 0000000080000000
> [   26.711791]  ffff88017a83a020 ffff88007ba77b08 ffffffff816a0759 ffff88017a83a020
> [   26.711804]  ffff88017a83a0ce ffff88007ba77b18 ffffffff814ba3ee ffff88007ba77b38
> [   26.711807] Call Trace:
> [   26.711835]  [<ffffffff8183966e>] dump_stack+0x4f/0x7b
> [   26.711852]  [<ffffffff816a0759>] i2c_hid_runtime_resume+0x29/0x50
> [   26.711866]  [<ffffffff814ba3ee>] pm_generic_runtime_resume+0x2e/0x40
> [   26.711880]  [<ffffffff81412b15>] acpi_subsys_runtime_resume+0x1f/0x23
> [   26.711892]  [<ffffffff814bbeb6>] __rpm_callback+0x36/0x90
> [   26.711902]  [<ffffffff814bbf36>] rpm_callback+0x26/0xa0
> [   26.711914]  [<ffffffff814bd286>] rpm_resume+0x496/0x670
> [   26.711928]  [<ffffffff814bd4a0>] __pm_runtime_resume+0x40/0x60
> [   26.711940]  [<ffffffff81412500>] ? acpi_subsys_complete+0x1e/0x1e
> [   26.711951]  [<ffffffff81412515>] acpi_subsys_suspend+0x15/0x21
>
> It's the ACPI power domain that runtime resumes the device before it
> suspends it for system sleep.

OK, that explains the difference in behavior for me.  I'm on an ARM
board that has no ACPI, so there's no ACPI layer to runtime resume the
device.

At least it sounds like you confirmed that my patch doesn't break your
use case, which is good.  If folks want to wait until I can reproduce
this problem on ToT Linux before merging then I guess we can let this
patch float until I can manage to get enough other bits of the system
happy with mainline.

Thanks for your tests!  :)

-Doug
