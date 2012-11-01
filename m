From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG v3.6.2, 3.7-rc1] Unable to rmmod any hid special driver
Date: Thu, 1 Nov 2012 16:49:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211011648570.6606@pobox.suse.cz>
References: <CAN+gG=HFGMP8yU0PD6Ci-9ppVy4n3wp=SwymzAtp8KTg9Ewa=g@mail.gmail.com> <alpine.LNX.2.00.1211011114150.6606@pobox.suse.cz> <alpine.LNX.2.00.1211011130430.6606@pobox.suse.cz> <CAN+gG=EnRsc=5W-E_HETWDDKxq8weSz_SJ8_Wf3BVbz5nZwe=Q@mail.gmail.com>
 <alpine.LNX.2.00.1211011142310.6606@pobox.suse.cz> <CAN+gG=HKJnbg++hCTY7sLRhTCntY3=1B87=fcAt1nZ_At3g_Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48493 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010Ab2KAPtY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Nov 2012 11:49:24 -0400
In-Reply-To: <CAN+gG=HKJnbg++hCTY7sLRhTCntY3=1B87=fcAt1nZ_At3g_Yw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Ratan Nalumasu <ratan@google.com>, linux-input <linux-input@vger.kernel.org>

On Thu, 1 Nov 2012, Benjamin Tissoires wrote:

> >> >  ------------[ cut here ]------------
> >> >  WARNING: at lib/list_debug.c:59 __list_del_entry+0xa4/0xd0()
> >> >  Hardware name: 7470BN2
> >> >  list_del corruption. prev->next should be ffff880036f97178, but was 6b6b6b6b6b6b6b6b
> >> >  Modules linked in: af_packet rfcomm bnep tun iptable_mangle xt_DSCP nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables xt
> >> > e nf_conntrack iptable_filter ip_tables x_tables cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq mperf dm_mod
> >> > m_intel kvm iwldvm mac80211 snd_hda_codec_conexant microcode usbhid sg iwlwifi pcspkr snd_hda_intel cfg80211 lpc_ich i2c_i801 mfd_c
> >> > imer snd_page_alloc thinkpad_acpi rfkill wmi snd ac soundcore battery tpm_tis tpm tpm_bios autofs4 uhci_hcd ehci_hcd usbcore usb_co
> >> > button edd fan processor ata_generic thermal thermal_sys [last unloaded: hid_cypress]
> >> >  Pid: 4725, comm: hexdump Not tainted 3.7.0-rc3-00008-g35fd3dc #157
> >> >  Call Trace:
> >> >   [<ffffffff812f95c4>] ? __list_del_entry+0xa4/0xd0
> >> >   [<ffffffff812f95c4>] ? __list_del_entry+0xa4/0xd0
> >> >   [<ffffffff810452fa>] warn_slowpath_common+0x7a/0xb0
> >> >   [<ffffffff810453d1>] warn_slowpath_fmt+0x41/0x50
> >> >   [<ffffffff812f95c4>] __list_del_entry+0xa4/0xd0
> >> >   [<ffffffff812f9601>] list_del+0x11/0x40
> >> >   [<ffffffff81454a23>] hidraw_release+0x33/0x50
> >> >   [<ffffffff8118cd0a>] __fput+0xca/0x2b0
> >> >   [<ffffffff8118cf49>] ____fput+0x9/0x10
> >> >   [<ffffffff8106b7a1>] task_work_run+0xb1/0xe0
> >> >   [<ffffffff8104c81e>] do_exit+0x1ee/0x4c0
> >> >   [<ffffffff810adcad>] ? trace_hardirqs_on_caller+0x12d/0x1b0
> >> >   [<ffffffff8104cb37>] do_group_exit+0x47/0xc0
> >> >   [<ffffffff8104cbc2>] sys_exit_group+0x12/0x20
> >> >   [<ffffffff8158a529>] system_call_fastpath+0x16/0x1b
> >> >  ---[ end trace 3bec13493e086171 ]---
> >> >
> >>
> >> This is weird, on my setup (kernel 3.6.2 + Henrik's patches + Ratan's
> >> patch + your fix), I don't have this warning.
> >
> > My reproduction scenario was
> >
> > - run hexdump on hidraw device driven by a special driver (hid-cypress in
> >   this case)
> > - let the device produce a few events
> > - rmmod hid-cypress while hexdump is still running
> 
> well, with the very same test (except I'm testing against
> hid-multitouch), the warning doesn't show up on my configuration...

Perhaps it happens when the removed hidraw is actually the last one 
existing in the system?

-- 
Jiri Kosina
SUSE Labs
