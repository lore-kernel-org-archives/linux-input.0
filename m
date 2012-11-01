From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG v3.6.2, 3.7-rc1] Unable to rmmod any hid special driver
Date: Thu, 1 Nov 2012 11:32:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211011130430.6606@pobox.suse.cz>
References: <CAN+gG=HFGMP8yU0PD6Ci-9ppVy4n3wp=SwymzAtp8KTg9Ewa=g@mail.gmail.com> <alpine.LNX.2.00.1211011114150.6606@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33247 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab2KAKcF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Nov 2012 06:32:05 -0400
In-Reply-To: <alpine.LNX.2.00.1211011114150.6606@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Ratan Nalumasu <ratan@google.com>, linux-input <linux-input@vger.kernel.org>

On Thu, 1 Nov 2012, Jiri Kosina wrote:

> > Commit 4fe9f8e203fdad1524c04beb390f3c6099781ed9 upstream
> > Commit 57a38d925e665fcd729cd9ad4a75c84e11bd95c9 linux-stable
> > 
> > This commit "HID: hidraw: don't deallocate memory when it is in use"
> > prevents users to rmmod then insmod  any hid special driver without
> > either physically unplugging the device or without rmmod-ing the hid
> > bus itself.
> > 
> > When the user does a rmmod, hidinput_disconnect is called before
> > hidraw_disconnect, thus, the hidraw device is still there, but the
> > input one not. It leads to the fact that the device is not working
> > anymore even if you call modprobe.
> > 
> > Any idea to solve that?
> 
> Guys, how about this?
> 
> 
> ---
>  drivers/hid/hidraw.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 17d15bb..fce4256 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -560,10 +560,11 @@ static void drop_ref(struct hidraw *hidraw, int exists_bit)
>  {
>  	mutex_lock(&minors_lock);
>  	if (exists_bit) {
> -		hid_hw_close(hidraw->hid);
>  		hidraw->exist = 0;
> -		if (hidraw->open)
> +		if (hidraw->open) {
> +			hid_hw_close(hidraw->hid);
>  			wake_up_interruptible(&hidraw->wait);
> +		}
>  	} else {
>  		--hidraw->open;
>  	}

So this seems to fix the problem with rmmod/modprobe, but the patch has 
apparently other problems. rmmoding special driver while reading from 
hidraw interface causes this:

 ------------[ cut here ]------------
 WARNING: at lib/list_debug.c:59 __list_del_entry+0xa4/0xd0()
 Hardware name: 7470BN2
 list_del corruption. prev->next should be ffff880036f97178, but was 6b6b6b6b6b6b6b6b
 Modules linked in: af_packet rfcomm bnep tun iptable_mangle xt_DSCP nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables xt
e nf_conntrack iptable_filter ip_tables x_tables cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq mperf dm_mod
m_intel kvm iwldvm mac80211 snd_hda_codec_conexant microcode usbhid sg iwlwifi pcspkr snd_hda_intel cfg80211 lpc_ich i2c_i801 mfd_c
imer snd_page_alloc thinkpad_acpi rfkill wmi snd ac soundcore battery tpm_tis tpm tpm_bios autofs4 uhci_hcd ehci_hcd usbcore usb_co
button edd fan processor ata_generic thermal thermal_sys [last unloaded: hid_cypress]
 Pid: 4725, comm: hexdump Not tainted 3.7.0-rc3-00008-g35fd3dc #157
 Call Trace:
  [<ffffffff812f95c4>] ? __list_del_entry+0xa4/0xd0
  [<ffffffff812f95c4>] ? __list_del_entry+0xa4/0xd0
  [<ffffffff810452fa>] warn_slowpath_common+0x7a/0xb0
  [<ffffffff810453d1>] warn_slowpath_fmt+0x41/0x50
  [<ffffffff812f95c4>] __list_del_entry+0xa4/0xd0
  [<ffffffff812f9601>] list_del+0x11/0x40
  [<ffffffff81454a23>] hidraw_release+0x33/0x50
  [<ffffffff8118cd0a>] __fput+0xca/0x2b0
  [<ffffffff8118cf49>] ____fput+0x9/0x10
  [<ffffffff8106b7a1>] task_work_run+0xb1/0xe0
  [<ffffffff8104c81e>] do_exit+0x1ee/0x4c0
  [<ffffffff810adcad>] ? trace_hardirqs_on_caller+0x12d/0x1b0
  [<ffffffff8104cb37>] do_group_exit+0x47/0xc0
  [<ffffffff8104cbc2>] sys_exit_group+0x12/0x20
  [<ffffffff8158a529>] system_call_fastpath+0x16/0x1b
 ---[ end trace 3bec13493e086171 ]---

As Ratan doesn't seem to be responsive and I don't have time to debug it 
as the moment, I'll just be reverting Ratan's patch for 3.7 completely.

-- 
Jiri Kosina
SUSE Labs
