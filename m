From: Jiri Kosina <jikos@kernel.org>
Subject: Re: must hold the driver_input_lock in hid_debug_rdesc_show
Date: Tue, 19 Mar 2019 15:42:09 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1903191541410.19912@cbobk.fhfr.pm>
References: <CD6925E8781EFD4D8E11882D20FC406D52A6168C@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A6168C@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "He, Bo" <bo.he@intel.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Jun" <jun.zhang@intel.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Thu, 14 Mar 2019, He, Bo wrote:

> we see the below kernel panic logs when run suspend resume test with
> usb mouse and usb keyboard connected.
> 
> the scenario is the userspace call the hid_debug_rdesc_show to dump
> the input device while the device is removed. the patch
> hold the driver_input_lock to avoid the race.
> 
> [ 5381.757295] selinux: SELinux:  Could not stat
> /sys/devices/pci0000:00/0000:00:15.0/usb1/1-2/1-2:1.0/0003:03F0:0325.0320/input/input960/input960::scrolllock:
> No such file or directory.
> [ 5382.636498] BUG: unable to handle kernel paging request at 0000000783316040
> [ 5382.651950] CPU: 1 PID: 1512 Comm: getevent Tainted: G     U     O 4.19.20-quilt-2e5dc0ac-00029-gc455a447dd55 #1
> [ 5382.663797] RIP: 0010:hid_dump_device+0x9b/0x160
> [ 5382.758853] Call Trace:
> [ 5382.761581]  hid_debug_rdesc_show+0x72/0x1d0
> [ 5382.766343]  seq_read+0xe0/0x410
> [ 5382.769941]  full_proxy_read+0x5f/0x90
> [ 5382.774121]  __vfs_read+0x3a/0x170
> [ 5382.788392]  vfs_read+0xa0/0x150
> [ 5382.791984]  ksys_read+0x58/0xc0
> [ 5382.801404]  __x64_sys_read+0x1a/0x20
> [ 5382.805483]  do_syscall_64+0x55/0x110
> [ 5382.809559]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>

I rewrote the changelog to explain the situation a bit more clearly, and 
applied. Thanks,

-- 
Jiri Kosina
SUSE Labs
