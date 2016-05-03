From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: How to properly extend uinput API
Date: Tue, 3 May 2016 11:08:43 +0200
Message-ID: <CAM4jgCoT1mNdKWBMVBogy=2BbQdYz=kwOo3_SEn3_yzMuvi_8w@mail.gmail.com>
References: <51caa374-1fdc-bcc0-3aac-20292a77571b@m-reimer.de>
	<20160502183542.GC37394@dtor-ws>
	<74df5cb0-9bbb-835a-82ca-aa8527f4d024@m-reimer.de>
	<20160502225147.GD37394@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36504 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713AbcECJIo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2016 05:08:44 -0400
Received: by mail-ig0-f196.google.com with SMTP id c3so1480763igl.3
        for <linux-input@vger.kernel.org>; Tue, 03 May 2016 02:08:43 -0700 (PDT)
In-Reply-To: <20160502225147.GD37394@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Manuel Reimer <mail+linux-input@m-reimer.de>, linux-input <linux-input@vger.kernel.org>

2016-05-03 0:51 GMT+02:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Mon, May 02, 2016 at 11:57:21PM +0200, Manuel Reimer wrote:
>> This doesn't need all the callback stuff and
>> probably even is more robust (current API tends to create
>> non-killable processes if the uinput daemon exits before the last
>> application, using the device, exits).
>
> Hmm, it should not, can you post some traces to show where it gets
> stuck so we can fix it?

I have been using ff uinput recently, the bugs were easy to reproduce.
I encountered two different bugs.

Having ff_effects_max set to 0 but with EV_FF bit set (and maybe some
FF_* bits too) crashes uinput when starting fftest (easy to fix but
annoying during development).

Destroying a uinput device when there are still uploaded effects
crashes uinput (e.g. destroying the uinput device while fftest is
running). This one is more problematic since you may need to destroy
the device at any time (unplugged device or empty battery).

Here are my logs for the second bug (on a 4.4 fedora kernel, I can try
the latest mainline if you prefer):

NMI watchdog: Watchdog detected hard LOCKUP on cpu 3
Modules linked in:
 rfcomm cmac fuse xt_CHECKSUM ccm ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun nf_conntrack_netbios_ns
nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_filter ebtable_nat
ebtable_broute bridge ebtables ip6table_raw ip6table_security
ip6table_mangle ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6
nf_nat_ipv6 ip6table_filter ip6_tables iptable_raw iptable_security
iptable_mangle iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_nat nf_conntrack bnep bbswitch(OE) intel_rapl iosf_mbi
x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass arc4
crct10dif_pclmul crc32_pclmul iTCO_wdt iwldvm crc32c_intel
iTCO_vendor_support mac80211 snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic iwlwifi snd_hda_intel snd_hda_codec uvcvideo
 snd_hda_core btusb videobuf2_vmalloc snd_hwdep cfg80211 btrtl
videobuf2_memops videobuf2_v4l2 btbcm snd_seq joydev btintel
videobuf2_core vfat v4l2_common fat videodev bluetooth i2c_i801
snd_seq_device media snd_pcm snd_timer rtsx_pci_ms snd memstick
lpc_ich rfkill mei_me soundcore mei shpchp tpm_infineon tpm_tis tpm
nfsd binfmt_misc auth_rpcgss nfs_acl lockd grace sunrpc uinput i915
rtsx_pci_sdmmc mmc_core mxm_wmi serio_raw i2c_algo_bit drm_kms_helper
8021q garp stp llc mrp drm r8169 rtsx_pci mii wmi video fjes
CPU: 3 PID: 11654 Comm: input-scripts Tainted: P           OE
4.4.6-300.fc23.x86_64 #1
Hardware name: CLEVO CO.                        W350ET/W350ET, BIOS
1.02.21PM v3 07/01/2013
 0000000000000086 00000000f29b3249 ffff88022f385b90 ffffffff813b542e
 0000000000000000 0000000000000000 ffff88022f385ba8 ffffffff8115ac1d
 ffff8802236ac800 ffff88022f385be0 ffffffff811a308c 0000000000000001
Call Trace:
 <NMI>  [<ffffffff813b542e>] dump_stack+0x63/0x85
 [<ffffffff8115ac1d>] watchdog_overflow_callback+0xbd/0xd0
 [<ffffffff811a308c>] __perf_event_overflow+0x8c/0x1d0
 [<ffffffff811a3c64>] perf_event_overflow+0x14/0x20
 [<ffffffff81035fb1>] intel_pmu_handle_irq+0x1e1/0x460
 [<ffffffff8102c738>] perf_event_nmi_handler+0x28/0x50
 [<ffffffff8101b0a9>] nmi_handle+0x69/0x120
 [<ffffffff8101b61d>] default_do_nmi+0xad/0xf0
 [<ffffffff8101b742>] do_nmi+0xe2/0x130
 [<ffffffff817a2a31>] end_repeat_nmi+0x1a/0x1e
 [<ffffffff810ed07a>] ? queued_spin_lock_slowpath+0x10a/0x170
 [<ffffffff810ed07a>] ? queued_spin_lock_slowpath+0x10a/0x170
 [<ffffffff810ed07a>] ? queued_spin_lock_slowpath+0x10a/0x170
 <<EOE>>  [<ffffffff817a0307>] _raw_spin_lock_irqsave+0x37/0x40
 [<ffffffff810e633d>] complete+0x1d/0x50
 [<ffffffffa00ba08c>] uinput_request_done+0x3c/0x40 [uinput]
 [<ffffffffa00ba587>] uinput_request_submit.part.7+0x47/0xb0 [uinput]
 [<ffffffffa00bb62b>] uinput_dev_erase_effect+0x5b/0x76 [uinput]
 [<ffffffff815d91ad>] erase_effect+0xad/0xf0
 [<ffffffff815d929d>] flush_effects+0x4d/0x90
 [<ffffffff815d4cc0>] input_flush_device+0x40/0x60
 [<ffffffff815daf1c>] evdev_cleanup+0xac/0xc0
 [<ffffffff815daf5b>] evdev_disconnect+0x2b/0x60
 [<ffffffff815d74ac>] __input_unregister_device+0xac/0x150
 [<ffffffff815d75f7>] input_unregister_device+0x47/0x70
 [<ffffffffa00bac45>] uinput_destroy_device+0xb5/0xc0 [uinput]
 [<ffffffffa00bb2de>] uinput_ioctl_handler.isra.9+0x65e/0x740 [uinput]
 [<ffffffff811231ab>] ? do_futex+0x12b/0xad0
 [<ffffffffa00bb3f8>] uinput_ioctl+0x18/0x20 [uinput]
 [<ffffffff81241248>] do_vfs_ioctl+0x298/0x480
 [<ffffffff81337553>] ? security_file_ioctl+0x43/0x60
 [<ffffffff812414a9>] SyS_ioctl+0x79/0x90
 [<ffffffff817a04ee>] entry_SYSCALL_64_fastpath+0x12/0x71
INFO: rcu_sched detected stalls on CPUs/tasks:
        3-...: (1 GPs behind) idle=7cb/140000000000000/0
softirq=236332/236332 fqs=15113
        (detected by 1, t=60003 jiffies, g=264264, c=264263, q=0)
Task dump for CPU 3:
input-scripts   R  running task        0 11654  11278 0x0000000c
 ffff880122a57b50 ffffffff810ec510 ffff880122a58000 ffff880224417428
 ffff8800aa198000 0000000000000000 ffff880224417408 ffff880224417400
 0000000124417408 0000000000000000 ffff880224417660 0000000000000286
Call Trace:
 [<ffffffff810ec510>] ? mutex_optimistic_spin+0x170/0x1a0
 [<ffffffff817a0307>] ? _raw_spin_lock_irqsave+0x37/0x40
 [<ffffffff810e633d>] ? complete+0x1d/0x50
 [<ffffffffa00ba08c>] ? uinput_request_done+0x3c/0x40 [uinput]
 [<ffffffffa00ba587>] ? uinput_request_submit.part.7+0x47/0xb0 [uinput]
 [<ffffffffa00bb62b>] ? uinput_dev_erase_effect+0x5b/0x76 [uinput]
 [<ffffffff815d91ad>] ? erase_effect+0xad/0xf0
 [<ffffffff815d929d>] ? flush_effects+0x4d/0x90
 [<ffffffff815d4cc0>] ? input_flush_device+0x40/0x60
 [<ffffffff815daf1c>] ? evdev_cleanup+0xac/0xc0
 [<ffffffff815daf5b>] ? evdev_disconnect+0x2b/0x60
 [<ffffffff815d74ac>] ? __input_unregister_device+0xac/0x150
 [<ffffffff815d75f7>] ? input_unregister_device+0x47/0x70
 [<ffffffffa00bac45>] ? uinput_destroy_device+0xb5/0xc0 [uinput]
 [<ffffffffa00bb2de>] ? uinput_ioctl_handler.isra.9+0x65e/0x740 [uinput]
 [<ffffffff811231ab>] ? do_futex+0x12b/0xad0
 [<ffffffffa00bb3f8>] ? uinput_ioctl+0x18/0x20 [uinput]
 [<ffffffff81241248>] ? do_vfs_ioctl+0x298/0x480
 [<ffffffff81337553>] ? security_file_ioctl+0x43/0x60
 [<ffffffff812414a9>] ? SyS_ioctl+0x79/0x90
 [<ffffffff817a04ee>] ? entry_SYSCALL_64_fastpath+0x12/0x71
