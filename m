From: Jonas Jelten <jelten@in.tum.de>
Subject: Re: HID: wacom: regression - system freezes when resuming from S3
 suspend
Date: Fri, 10 Oct 2014 03:27:49 +0200
Message-ID: <54373615.6010102@in.tum.de>
References: <542039C1.1000605@in.tum.de> <CAN+gG=EfKHqo2++ejxJMqDxpOnav5qiVRJMRjXoDOrbWQVMnBQ@mail.gmail.com> <54221EFF.2060501@in.tum.de> <alpine.LNX.2.00.1409241032490.32397@pobox.suse.cz> <CAN+gG=HqiV1omKjhUEV22sWO8DVjiTY0t04qxmO7YtE540RsOw@mail.gmail.com> <54235FB9.5040706@in.tum.de> <alpine.LNX.2.00.1409250223240.22196@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:62422 "EHLO
	smtp1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751015AbaJJB1w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Oct 2014 21:27:52 -0400
In-Reply-To: <alpine.LNX.2.00.1409250223240.22196@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On 2014-09-25 02:24, Jiri Kosina wrote:
> On Thu, 25 Sep 2014, Jonas Jelten wrote:
> 
>> I have no idea about the reasons yet, however my kernel indeed panics 10
>> seconds after resume from S3. During the 10 seconds, the on-suspend X
>> screen is visible, but frozen (no mouse/keyboard input) and no sysrqs
>> are possible. After the 10s passed, I see old tty1 framebuffer parts
>> from the init system log, the kernel seems to have paniced as the
>> capslock led starts blinking, but I can't see any backtrace.
> 
> Is there any way you could setup serial console or at least netconsole on 
> that system?
> 
>> I could not test whether "HID: wacom: fix timeout on probe for some
>> wacoms" fixes the panic, as it does not apply for 3.17-rc6.
> 
> Just compiling for-3.18/wacom branch of
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
> 
> should be enough.
> 
> I still fail to see how this would be fixing any panic, so either there is 
> a very strange race condition somewhere, or this is a different problem 
> that still needs to be solved.
> 
> Thanks,
> 

Hi!

Now running 3.17.0, I managed to get a backtrace via netconsole:


[ 1077.286152] PM: Syncing filesystems ... done.
[ 1077.286888] PM: Preparing system for mem sleep
[ 1077.503113] Freezing user space processes ... (elapsed 0.001 seconds)
done.
[ 1077.504368] Freezing remaining freezable tasks ... (elapsed 0.000
seconds) done.
[ 1077.505359] PM: Entering mem sleep
[ 1077.705575] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 1077.705695] sd 0:0:0:0: [sda] Stopping disk
[ 1077.806294] e1000e: EEE TX LPI TIMER: 00000011
[ 1093.625038] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[ 1100.434376] usb 2-1.5: **** DPM device timeout ****
[ 1100.435410]  ffff8801fc20f9d8 0000000000000002 ffff8801fc20ffd8
ffff8801fc210000
[ 1100.436468]  0000000000014240 ffffffff81a1a440 ffff8801fc210000
ffffffffa0043022
[ 1100.437521]  ffff880100000000 ffff8801fc20f928 ffff8801fc20f998
0000000000000000
[ 1100.438521] Call Trace:
[ 1100.439512]  [<ffffffff81541b0f>] ? _raw_spin_unlock_irqrestore+0x20/0x33
[ 1100.440516]  [<ffffffffa006836b>] ? ehci_urb_enqueue+0x119/0xbf8
[ehci_hcd]
[ 1100.441522]  [<ffffffff81319d1c>] ? debug_smp_processor_id+0x17/0x19
[ 1100.442590]  [<ffffffff8109384f>] ? wake_up_nohz_cpu+0x28/0x8f
[ 1100.443601]  [<ffffffff8153e941>] schedule+0x6e/0x70
[ 1100.444611]  [<ffffffff81541077>] schedule_timeout+0x15a/0x1c2
[ 1100.445616]  [<ffffffff810bd1cf>] ? ftrace_raw_event_tick_stop+0xa8/0xa8
[ 1100.446627]  [<ffffffff8153f2cc>] wait_for_common+0x111/0x151
[ 1100.447643]  [<ffffffff81096e3f>] ? wake_up_process+0x37/0x37
[ 1100.448658]  [<ffffffff8153f33e>] wait_for_completion_timeout+0x13/0x15
[ 1100.449682]  [<ffffffffa002ed55>] usb_start_wait_urb+0x84/0xce [usbcore]
[ 1100.450708]  [<ffffffffa002ee67>] usb_control_msg+0xc8/0xff [usbcore]
[ 1100.451728]  [<ffffffffa00bee1b>] usbhid_raw_request+0x137/0x154 [usbhid]
[ 1100.452746]  [<ffffffffa0116e2a>]
wacom_set_report.constprop.17+0x53/0x73 [wacom]
[ 1100.453775]  [<ffffffffa0117495>] wacom_query_tablet_data+0x8f/0x23a
[wacom]
[ 1100.454796]  [<ffffffffa0117676>] wacom_resume+0x36/0x4f [wacom]
[ 1100.455876]  [<ffffffffa011769d>] wacom_reset_resume+0xe/0x10 [wacom]
[ 1100.456888]  [<ffffffffa00bfbc8>] hid_reset_resume+0x4c/0x58 [usbhid]
[ 1100.457902]  [<ffffffffa00317f1>]
usb_resume_interface.isra.6+0x71/0xc6 [usbcore]
[ 1100.458921]  [<ffffffffa0031aaa>] usb_resume_both+0xd6/0x106 [usbcore]
[ 1100.459937]  [<ffffffffa00251b8>] ? usb_dev_thaw+0x15/0x15 [usbcore]
[ 1100.460956]  [<ffffffffa0032100>] usb_resume+0x1b/0x64 [usbcore]
[ 1100.461973]  [<ffffffffa00251b8>] ? usb_dev_thaw+0x15/0x15 [usbcore]
[ 1100.462983]  [<ffffffffa00251cb>] usb_dev_resume+0x13/0x15 [usbcore]
[ 1100.463983]  [<ffffffff813dd62e>] dpm_run_callback+0x48/0x106
[ 1100.464976]  [<ffffffff813de058>] device_resume+0x16b/0x1a6
[ 1100.465971]  [<ffffffff813dd4e7>] ? __suspend_report_result+0x25/0x25
[ 1100.466962]  [<ffffffff813de0b0>] async_resume+0x1d/0x43
[ 1100.467946]  [<ffffffff8108ea22>] async_run_entry_fn+0x5f/0x115
[ 1100.468923]  [<ffffffff81088480>] process_one_work+0x1bf/0x35d
[ 1100.469903]  [<ffffffff81088eee>] worker_thread+0x28e/0x382
[ 1100.470872]  [<ffffffff81088c60>] ? rescuer_thread+0x226/0x226
[ 1100.471834]  [<ffffffff8108ca2c>] kthread+0xd2/0xda
[ 1100.472793]  [<ffffffff8108c95a>] ? kthread_create_on_node+0x16f/0x16f
[ 1100.473757]  [<ffffffff815423bc>] ret_from_fork+0x7c/0xb0
[ 1100.474725]  [<ffffffff8108c95a>] ? kthread_create_on_node+0x16f/0x16f
[ 1100.475697] Kernel panic - not syncing: usb 2-1.5: unrecoverable failure
[ 1100.475697]
[ 1100.477626] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G  R
3.17.0-JJ+ #71
[ 1100.478608] Hardware name: LENOVO 4296CTO/4296CTO, BIOS 8DET67WW
(1.37 ) 12/05/2012
[ 1100.479596]  0000000000000000 ffff88021e283e00 ffffffff8153c8c8
ffffffff8183ab5c
[ 1100.480673]  ffff88021e283e78 ffffffff8153954d ffffffff00000018
ffff88021e283e88
[ 1100.481686]  ffff88021e283e28 ffff88021e27ffc0 ffffffffa003b4a5
ffff8800d45ec810
[ 1100.482684] Call Trace:
[ 1100.483655]  <IRQ>  [<ffffffff8153c8c8>] dump_stack+0x4e/0x7a
[ 1100.484639]  [<ffffffff8153954d>] panic+0xcb/0x1f4
[ 1100.485622]  [<ffffffff813dd4e7>] ? __suspend_report_result+0x25/0x25
[ 1100.486597]  [<ffffffff813dd539>] dpm_watchdog_handler+0x52/0x52
[ 1100.487567]  [<ffffffff810bd225>] call_timer_fn+0x46/0x124
[ 1100.488529]  [<ffffffff813dd4e7>] ? __suspend_report_result+0x25/0x25
[ 1100.489496]  [<ffffffff810bda8b>] run_timer_softirq+0x215/0x280
[ 1100.490457]  [<ffffffff810c8b25>] ? clockevents_program_event+0x9d/0xb9
[ 1100.491423]  [<ffffffff81078bae>] __do_softirq+0xf4/0x27d
[ 1100.492389]  [<ffffffff81078ee6>] irq_exit+0x43/0x89
[ 1100.493353]  [<ffffffff815452fe>] smp_apic_timer_interrupt+0x44/0x50
[ 1100.494318]  [<ffffffff8154348d>] apic_timer_interrupt+0x6d/0x80
[ 1100.495287]  <EOI>  [<ffffffff81449730>] ? cpuidle_enter_state+0x8b/0x16b
[ 1100.496264]  [<ffffffff814498b9>] cpuidle_enter+0x17/0x19
[ 1100.497236]  [<ffffffff810a51d6>] cpu_startup_entry+0x1b6/0x2f0
[ 1100.498212]  [<ffffffff81035f4d>] start_secondary+0x1ad/0x1b2
[ 1100.499205] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation
range: 0xffffffff80000000-0xffffffff9fffffff)
[ 1100.500254] drm_kms_helper: panic occurred, switching back to text
console

This looks like the kernel is failing to bring up the wacom usb device
after the suspend.
Probably this is something for linux-kernel@?


Cheers,
Jonas
