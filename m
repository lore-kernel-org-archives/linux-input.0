From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Fix suspend/resume when already runtime
 suspended
Date: Wed, 11 Mar 2015 13:20:03 +0200
Message-ID: <20150311112003.GN1563@lahna.fi.intel.com>
References: <1425930287-4615-1-git-send-email-dianders@chromium.org>
 <20150310122307.GM1563@lahna.fi.intel.com>
 <CAD=FV=WmXA6SnyMx2KC9gP+Q0eVyu+kg54QkY50hKb4LsLFxng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56858 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbbCKLUI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 07:20:08 -0400
Content-Disposition: inline
In-Reply-To: <CAD=FV=WmXA6SnyMx2KC9gP+Q0eVyu+kg54QkY50hKb4LsLFxng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jmaneyrol@invensense.com, borneo.antonio@gmail.com, seth.forshee@canonical.com, archana.patni@linux.intel.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Mar 10, 2015 at 09:12:36AM -0700, Doug Anderson wrote:
> Thanks for testing!  Can you do a "dump_stack()" here?  I'm curious
> why it's deciding to runtime resume.  Maybe something changed between
> 3.14 and ToT?

Here you go:

[   26.711737] i2c_hid i2c-ATML1000:00: PM: i2c-hid runtime resume
[   26.711754] CPU: 3 PID: 123 Comm: sh Not tainted 4.0.0-rc3+ #6
[   26.711775]  ffff88007604c600 ffff88007ba77ae8 ffffffff8183966e 0000000080000000
[   26.711791]  ffff88017a83a020 ffff88007ba77b08 ffffffff816a0759 ffff88017a83a020
[   26.711804]  ffff88017a83a0ce ffff88007ba77b18 ffffffff814ba3ee ffff88007ba77b38
[   26.711807] Call Trace:
[   26.711835]  [<ffffffff8183966e>] dump_stack+0x4f/0x7b
[   26.711852]  [<ffffffff816a0759>] i2c_hid_runtime_resume+0x29/0x50
[   26.711866]  [<ffffffff814ba3ee>] pm_generic_runtime_resume+0x2e/0x40
[   26.711880]  [<ffffffff81412b15>] acpi_subsys_runtime_resume+0x1f/0x23
[   26.711892]  [<ffffffff814bbeb6>] __rpm_callback+0x36/0x90
[   26.711902]  [<ffffffff814bbf36>] rpm_callback+0x26/0xa0
[   26.711914]  [<ffffffff814bd286>] rpm_resume+0x496/0x670
[   26.711928]  [<ffffffff814bd4a0>] __pm_runtime_resume+0x40/0x60
[   26.711940]  [<ffffffff81412500>] ? acpi_subsys_complete+0x1e/0x1e
[   26.711951]  [<ffffffff81412515>] acpi_subsys_suspend+0x15/0x21

It's the ACPI power domain that runtime resumes the device before it
suspends it for system sleep.

[   26.711964]  [<ffffffff814be5ec>] dpm_run_callback+0x4c/0x150
[   26.711978]  [<ffffffff814bf17e>] __device_suspend+0xee/0x320
[   26.711991]  [<ffffffff814c0d88>] dpm_suspend+0x68/0x300
[   26.712004]  [<ffffffff814c14ff>] dpm_suspend_start+0x5f/0x70
[   26.712019]  [<ffffffff810936df>] suspend_devices_and_enter+0xbf/0x7d0
[   26.712035]  [<ffffffff8109e16f>] ? vprintk_default+0x1f/0x30
[   26.712047]  [<ffffffff810941a9>] pm_suspend+0x3b9/0x4e0
[   26.712059]  [<ffffffff81092850>] state_store+0x80/0x100
[   26.712074]  [<ffffffff8139f4df>] kobj_attr_store+0xf/0x20
[   26.712087]  [<ffffffff811f223a>] sysfs_kf_write+0x3a/0x50
[   26.712098]  [<ffffffff811f1717>] kernfs_fop_write+0x127/0x180
[   26.712112]  [<ffffffff81183207>] vfs_write+0xb7/0x200
[   26.712124]  [<ffffffff81183e66>] SyS_write+0x46/0xc0
[   26.712140]  [<ffffffff81844099>] ia32_do_call+0x13/0x13
