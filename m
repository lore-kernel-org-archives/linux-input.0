From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [BUG v3.6.2, 3.7-rc1] Unable to rmmod any hid special driver
Date: Thu, 1 Nov 2012 11:52:46 +0100
Message-ID: <CAN+gG=HKJnbg++hCTY7sLRhTCntY3=1B87=fcAt1nZ_At3g_Yw@mail.gmail.com>
References: <CAN+gG=HFGMP8yU0PD6Ci-9ppVy4n3wp=SwymzAtp8KTg9Ewa=g@mail.gmail.com>
	<alpine.LNX.2.00.1211011114150.6606@pobox.suse.cz>
	<alpine.LNX.2.00.1211011130430.6606@pobox.suse.cz>
	<CAN+gG=EnRsc=5W-E_HETWDDKxq8weSz_SJ8_Wf3BVbz5nZwe=Q@mail.gmail.com>
	<alpine.LNX.2.00.1211011142310.6606@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44923 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238Ab2KAKws (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Nov 2012 06:52:48 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1763734lbo.19
        for <linux-input@vger.kernel.org>; Thu, 01 Nov 2012 03:52:46 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1211011142310.6606@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Ratan Nalumasu <ratan@google.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 1, 2012 at 11:43 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 1 Nov 2012, Benjamin Tissoires wrote:
>
>> >> > hidraw_disconnect, thus, the hidraw device is still there, but the
>> >> > input one not. It leads to the fact that the device is not working
>> >> > anymore even if you call modprobe.
>> >> >
>> >> > Any idea to solve that?
>> >>
>> >> Guys, how about this?
>>
>> I tested it against hid-multitouch and hid-logitech-dj and it's
>> working smoothly, thanks!
>
> Thanks for testing.
>
>> >>  drivers/hid/hidraw.c |    5 +++--
>> >>  1 files changed, 3 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
>> >> index 17d15bb..fce4256 100644
>> >> --- a/drivers/hid/hidraw.c
>> >> +++ b/drivers/hid/hidraw.c
>> >> @@ -560,10 +560,11 @@ static void drop_ref(struct hidraw *hidraw, int exists_bit)
>> >>  {
>> >>       mutex_lock(&minors_lock);
>> >>       if (exists_bit) {
>> >> -             hid_hw_close(hidraw->hid);
>> >>               hidraw->exist = 0;
>> >> -             if (hidraw->open)
>> >> +             if (hidraw->open) {
>> >> +                     hid_hw_close(hidraw->hid);
>> >>                       wake_up_interruptible(&hidraw->wait);
>> >> +             }
>> >>       } else {
>> >>               --hidraw->open;
>> >>       }
>> >
>> > So this seems to fix the problem with rmmod/modprobe, but the patch has
>> > apparently other problems. rmmoding special driver while reading from
>> > hidraw interface causes this:
>> >
>> >  ------------[ cut here ]------------
>> >  WARNING: at lib/list_debug.c:59 __list_del_entry+0xa4/0xd0()
>> >  Hardware name: 7470BN2
>> >  list_del corruption. prev->next should be ffff880036f97178, but was 6b6b6b6b6b6b6b6b
>> >  Modules linked in: af_packet rfcomm bnep tun iptable_mangle xt_DSCP nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables xt
>> > e nf_conntrack iptable_filter ip_tables x_tables cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq mperf dm_mod
>> > m_intel kvm iwldvm mac80211 snd_hda_codec_conexant microcode usbhid sg iwlwifi pcspkr snd_hda_intel cfg80211 lpc_ich i2c_i801 mfd_c
>> > imer snd_page_alloc thinkpad_acpi rfkill wmi snd ac soundcore battery tpm_tis tpm tpm_bios autofs4 uhci_hcd ehci_hcd usbcore usb_co
>> > button edd fan processor ata_generic thermal thermal_sys [last unloaded: hid_cypress]
>> >  Pid: 4725, comm: hexdump Not tainted 3.7.0-rc3-00008-g35fd3dc #157
>> >  Call Trace:
>> >   [<ffffffff812f95c4>] ? __list_del_entry+0xa4/0xd0
>> >   [<ffffffff812f95c4>] ? __list_del_entry+0xa4/0xd0
>> >   [<ffffffff810452fa>] warn_slowpath_common+0x7a/0xb0
>> >   [<ffffffff810453d1>] warn_slowpath_fmt+0x41/0x50
>> >   [<ffffffff812f95c4>] __list_del_entry+0xa4/0xd0
>> >   [<ffffffff812f9601>] list_del+0x11/0x40
>> >   [<ffffffff81454a23>] hidraw_release+0x33/0x50
>> >   [<ffffffff8118cd0a>] __fput+0xca/0x2b0
>> >   [<ffffffff8118cf49>] ____fput+0x9/0x10
>> >   [<ffffffff8106b7a1>] task_work_run+0xb1/0xe0
>> >   [<ffffffff8104c81e>] do_exit+0x1ee/0x4c0
>> >   [<ffffffff810adcad>] ? trace_hardirqs_on_caller+0x12d/0x1b0
>> >   [<ffffffff8104cb37>] do_group_exit+0x47/0xc0
>> >   [<ffffffff8104cbc2>] sys_exit_group+0x12/0x20
>> >   [<ffffffff8158a529>] system_call_fastpath+0x16/0x1b
>> >  ---[ end trace 3bec13493e086171 ]---
>> >
>>
>> This is weird, on my setup (kernel 3.6.2 + Henrik's patches + Ratan's
>> patch + your fix), I don't have this warning.
>
> My reproduction scenario was
>
> - run hexdump on hidraw device driven by a special driver (hid-cypress in
>   this case)
> - let the device produce a few events
> - rmmod hid-cypress while hexdump is still running

well, with the very same test (except I'm testing against
hid-multitouch), the warning doesn't show up on my configuration...

>
> This triggers the warning immediately. Do you have list debugging truned
> on in your .config?

I think so:

CONFIG_DEBUG_LIST=y

and here is the debug section:


CONFIG_SCHED_DEBUG=y
CONFIG_SCHEDSTATS=y
CONFIG_TIMER_STATS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
CONFIG_SPARSE_RCU_POINTER=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_LIST=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

Cheers,
Benjamin
