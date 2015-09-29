From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Tue, 29 Sep 2015 09:13:47 -0400
Message-ID: <20150929091347.0f3ce951@gandalf.local.home>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<CA+icZUX3tJvRor6CbOZFBecTAUZzyWzjLzJSEdb3c12yKRAT3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:52021 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964990AbbI2NXS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 09:23:18 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave07.hostedemail.com (Postfix) with ESMTP id C90D111A361
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2015 13:13:51 +0000 (UTC)
In-Reply-To: <CA+icZUX3tJvRor6CbOZFBecTAUZzyWzjLzJSEdb3c12yKRAT3g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Tue, 29 Sep 2015 11:06:25 +0200
Sedat Dilek <sedat.dilek@gmail.com> wrote:

> > Is spin_lock_bh() not an appropriate replacement?

I agree with Jiri, your patch makes no sense. It's strange that it
would fix anything.

> > Does it change code beaviour?

Yes.

> > Is it important to re-enable IRQs here - before hid_cancel_delayed_stuff()?
> > Turning hardirqs off seems to make the bug-line go away.
> >
> >> Now if you are able to see how usbhid_close() can be called with IRQs
> >> off, that would be a completely different story. But if that's not the
> >> case, the warning is bogus, and gcc-compiled kernels are right about not
> >> issuing it.
> >>
> >
> > Again, I am new to tracing.
> > Steven encouraged me to look at the lockdep hints in dmesg - not ftrace [1].

Because lockdep will show you where interrupts were last disabled (see
below).

> >
> > "Actually, if you are looking for where interrupts were disabled last
> > before triggering the "sleeping function called from invalid context",
> > lockdep, not ftrace, would be your better bet.
> >
> > Enable lockdep with CONFIG_PROVE_LOCKING. It will give you better
> > information about where the last irq was disabled."
> >
> > Here, I have CONFIG_PROVE_LOCKING=y.
> >
> > I am doing a new kernel-build with the might_sleep() on top of
> > hid_cancel_delayed_stuff() which showed some lockdep/irqsoff hints in
> > dmesg-log.
> >
> >> But without that, I so far fail to see how this is a correct thing to do.
> >
> > Again, I dunno why two compiler behave different here.
> > Unsure if it is a compiler or linux-kernel issue or whatever.
> >
> > Still fighting...
> >
> > - Sedat -
> >
> > [1] http://marc.info/?l=linux-kernel&m=144337272915104&w=2
> 
> As promised my dmesg-log (I did not apply above patch but the attached one)...
> 
> [   24.100648] ------------[ cut here ]------------
> [   24.100723] WARNING: CPU: 3 PID: 1400 at
> kernel/locking/lockdep.c:3519 check_flags+0x6c/0x1b0()
> [   24.100833] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
> [   24.100903] Modules linked in: option cdc_ether usbnet usb_wwan
> usbserial i915 arc4 iwldvm mac80211 snd_hda_codec_hdmi
> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel
> snd_hda_codec bnep i2c_algo_bit rfcomm snd_hwdep snd_hda_core
> drm_kms_helper snd_pcm parport_pc snd_seq_midi snd_seq_midi_event
> snd_rawmidi uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core
> iwlwifi v4l2_common videodev btusb ppdev joydev btrtl btbcm kvm_intel
> cfg80211 kvm btintel bluetooth usb_storage snd_seq syscopyarea
> sysfillrect sysimgblt psmouse fb_sys_fops drm snd_timer snd_seq_device
> snd serio_raw soundcore samsung_laptop video lpc_ich wmi intel_rst
> mac_hid lp parport binfmt_misc hid_generic usbhid hid r8169 mii
> [   24.102047] CPU: 3 PID: 1400 Comm: acpid Not tainted
> 4.3.0-rc3-6-llvmlinux-amd64 #1

Question: Does this happen if you compile with gcc? If not, this could
be a compiler bug.

> [   24.102142] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
> [   24.102281]  ffffffff81c5a6ef ffff8800bc48bc18 0000000000000003
> ffff8800bc48bb88
> [   24.102394]  ffffffff8149cabd ffff8800bc48bbc8 ffffffff810907c4
> 00000009bc48bc58
> [   24.102479]  ffffffff81c4614f ffff880118b001c0 ffff8800ba929000
> 0000000000000dbf
> [   24.102542] Call Trace:
> [   24.102567]  [<ffffffff8149cabd>] dump_stack+0x7d/0xa0
> [   24.102606]  [<ffffffff810907c4>] warn_slowpath_common+0x94/0x120
> [   24.102648]  [<ffffffff81090721>] warn_slowpath_fmt+0x61/0x70
> [   24.102690]  [<ffffffff81929e09>] ? __mutex_lock_common+0x5c9/0x8a0
> [   24.102735]  [<ffffffff810f0b7c>] check_flags+0x6c/0x1b0
> [   24.102772]  [<ffffffff810f3ed4>] lock_is_held+0x44/0xc0
> [   24.102810]  [<ffffffff810cd35e>] ___might_sleep+0x3e/0x2a0
> [   24.102849]  [<ffffffff810cd2af>] __might_sleep+0x4f/0xc0
> [   24.102888]  [<ffffffffa00563d0>] usbhid_close+0x70/0xc0 [usbhid]
> [   24.102933]  [<ffffffffa00394d1>] hidinput_close+0x31/0x40 [hid]
> [   24.104797]  [<ffffffffa00394a0>] ? hidinput_open+0x40/0x40 [hid]
> [   24.107960]  [<ffffffff817440c8>] input_close_device+0x48/0x70
> [   24.111139]  [<ffffffff8174c9a6>] evdev_release+0xd6/0xf0
> [   24.114298]  [<ffffffff81274367>] __fput+0x107/0x240
> [   24.117400]  [<ffffffff812741f6>] ____fput+0x16/0x20
> [   24.120450]  [<ffffffff810b97bc>] task_work_run+0x6c/0xe0
> [   24.123473]  [<ffffffff81003b8a>] prepare_exit_to_usermode+0x13a/0x140
> [   24.126515]  [<ffffffff81003e11>] syscall_return_slowpath+0x281/0x2f0
> [   24.129545]  [<ffffffff81270a45>] ? filp_close+0x65/0x90
> [   24.132500]  [<ffffffff810f02d9>] ? trace_hardirqs_on_caller+0x19/0x290
> [   24.135463]  [<ffffffff81003017>] ? trace_hardirqs_on_thunk+0x17/0x19
> [   24.138400]  [<ffffffff8192d9e2>] int_ret_from_sys_call+0x25/0x9f
> [   24.141364] ---[ end trace 615e247c8083b603 ]---
> [   24.144296] possible reason: unannotated irqs-off.
> [   24.147183] irq event stamp: 3227
> [   24.150067] hardirqs last  enabled at (3227): [<ffffffff8192ccd2>]
> _raw_spin_unlock_irq+0x32/0x60
> [   24.152440] hardirqs last disabled at (3226): [<ffffffff8192cb24>]
> _raw_spin_lock_irq+0x24/0x70

The above two lines is what I wanted to see. The (3227) and (3226) show
the order of events. According to lockdep, hardirqs were last disabled
at _raw_spin_lock_irq, and last enabled at _raw_spin_unlock_irq.
According to lockdep, irqs should be enabled. But apparently, they are
not. Unless something disabled interrupts without lockdep knowing about
it.

-- Steve


> [   24.155429] softirqs last  enabled at (2684): [<ffffffff818b3069>]
> local_bh_enable+0x9/0x20
> [   24.157660] softirqs last disabled at (2682): [<ffffffff818b3049>]
> local_bh_disable+0x9/0x20
> [   24.160601] BUG: sleeping function called from invalid context at
> drivers/hid/usbhid/hid-core.c:1395
> [   24.163592] in_atomic(): 0, irqs_disabled(): 1, pid: 1400, name: acpid
> [   24.165978] INFO: lockdep is turned off.
> [   24.168739] irq event stamp: 3227
> [   24.171280] hardirqs last  enabled at (3227): [<ffffffff8192ccd2>]
> _raw_spin_unlock_irq+0x32/0x60
> [   24.174084] hardirqs last disabled at (3226): [<ffffffff8192cb24>]
> _raw_spin_lock_irq+0x24/0x70
> [   24.177052] softirqs last  enabled at (2684): [<ffffffff818b3069>]
> local_bh_enable+0x9/0x20
> [   24.179976] softirqs last disabled at (2682): [<ffffffff818b3049>]
> local_bh_disable+0x9/0x20
> [   24.182659] CPU: 3 PID: 1400 Comm: acpid Tainted: G        W
> 4.3.0-rc3-6-llvmlinux-amd64 #1
> [   24.184189] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
> [   24.185728]  ffff8800ba929000 0000000000000092 0000000000000000
> ffff8800bc48bc88
> [   24.187213]  ffffffff8149cabd ffff8800bc48bcb8 ffffffff810cd5aa
> ffffffffa005f80c
> [   24.189039]  ffff880118b001c0 0000000000000000 0000000000000573
> ffff8800bc48bcf8
> [   24.191538] Call Trace:
> [   24.193955]  [<ffffffff8149cabd>] dump_stack+0x7d/0xa0
> [   24.196305]  [<ffffffff810cd5aa>] ___might_sleep+0x28a/0x2a0
> [   24.198316]  [<ffffffff810cd2af>] __might_sleep+0x4f/0xc0
> [   24.199798]  [<ffffffffa00563d0>] usbhid_close+0x70/0xc0 [usbhid]
> [   24.201181]  [<ffffffffa00394d1>] hidinput_close+0x31/0x40 [hid]
> [   24.202609]  [<ffffffffa00394a0>] ? hidinput_open+0x40/0x40 [hid]
> [   24.204045]  [<ffffffff817440c8>] input_close_device+0x48/0x70
> [   24.205453]  [<ffffffff8174c9a6>] evdev_release+0xd6/0xf0
> [   24.207352]  [<ffffffff81274367>] __fput+0x107/0x240
> [   24.209681]  [<ffffffff812741f6>] ____fput+0x16/0x20
> [   24.211276]  [<ffffffff810b97bc>] task_work_run+0x6c/0xe0
> [   24.212723]  [<ffffffff81003b8a>] prepare_exit_to_usermode+0x13a/0x140
> [   24.215069]  [<ffffffff81003e11>] syscall_return_slowpath+0x281/0x2f0
> [   24.217423]  [<ffffffff81270a45>] ? filp_close+0x65/0x90
> [   24.218919]  [<ffffffff810f02d9>] ? trace_hardirqs_on_caller+0x19/0x290
> [   24.220271]  [<ffffffff81003017>] ? trace_hardirqs_on_thunk+0x17/0x19
> [   24.222020]  [<ffffffff8192d9e2>] int_ret_from_sys_call+0x25/0x9f
> 
> Do you need more informations?
> 
> - Sedat -

