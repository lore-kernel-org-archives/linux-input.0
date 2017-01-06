From: "Robert R. Howell" <rhowell@uwyo.edu>
Subject: PROBLEM: Baytrail tablet touchscreen fails after pinctrl commit
 [3ae02c14d964499da76b5ef4d8912710902e64f8]
Date: Fri, 6 Jan 2017 02:30:20 -0700
Message-ID: <6306d18a-d5d3-3e89-5f41-2a45d3de1398@uwyo.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:18656
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935647AbdAFJaG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 6 Jan 2017 04:30:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, "Robert R. Howell" <rhowell@uwyo.edu>

[1.]  Baytrail tablet touchscreen fails after pinctrl commit 
[3ae02c14d964499da76b5ef4d8912710902e64f8]

[2.]  Beginning with kernel 4.10-rc1 (and continuing with 4.10-rc2) the 
touchscreen on two Baytrail devices, an ASUS T100TA and a Toshiba Encore 
8, no longer works.  They did work properly up though at least 4.9.0. As 
indicated in the DMESG output appended below, the ATML1000 touchscreen 
controller fails to reset and initialize properly on boot. The reset 
command issued through i2c_hid appears to time out after its 5 second 
wait for completion.  (There are similar problems with an i2c 
orientation sensor.)  Using git bisect I've found that the problem 
begins with commit [3ae02c14d964499da76b5ef4d8912710902e64f8]
pinctrl: intel: set default handler to be handle_bad_irq()

I've appended the git bisect log output at the end.  Reverting that 
single commit (tested with 4.10-rc2) fixes the problem.

[3.] Keywords:  pintctrl  intel  i2c_hid  baytrail

[4.] Kernel version (from /proc/version):

[5.] DMESG (with i2c_hid.debug=1) reports:

> [    5.405974] usb usb2: SerialNumber: 0000:00:14.0
> [    5.406347] hub 2-0:1.0: USB hub found
> [    5.406368] hub 2-0:1.0: 1 port detected
> [    5.415338] i2c_hid i2c-ATML1000:00: Fetching the HID descriptor
> [    5.415344] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=00 00
> [    5.416698] i2c_hid i2c-ATML1000:00: HID Descriptor: 1e 00 00 01 b5 00 1e 00 d3 00 14 00 e7 00 14 00 fb 00 fd 00 eb 03 0d 8c 34 10 00 00 00 00
> [    5.417892] i2c_hid i2c-ATML1000:00: entering i2c_hid_parse
> [    5.417897] i2c_hid i2c-ATML1000:00: i2c_hid_hwreset
> [    5.417900] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> [    5.417904] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 08
> [    5.418070] i2c_hid i2c-ATML1000:00: resetting...
> [    5.418074] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 01
> [    5.418226] i2c_hid i2c-ATML1000:00: __i2c_hid_command: waiting...
> [    5.420833] i915: unknown parameter 'force_backlight_pmic' ignored
> [    5.426475] [drm] Memory usable by graphics device = 2048M
> [    5.426482] checking generic (80000000 410000) vs hw (80000000 10000000)
.....

> [    6.470102] PM: Image not found (code -22)
> [    6.470105] PM: Hibernation image not present or could not be loaded.
> [    6.553411] EXT4-fs (mmcblk2p6): mounted filesystem with ordered data mode. Opts: (null)
> [   10.901482] i2c_hid i2c-ATML1000:00: __i2c_hid_command: finished.
> [   10.901487] i2c_hid i2c-ATML1000:00: failed to reset device.
> [   10.901609] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> [   10.901613] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 01 08
> [   11.932593] i2c_hid i2c-ATML1000:00: i2c_hid_hwreset
> [   11.932607] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> [   11.932619] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 08
> [   11.933743] i2c_hid i2c-ATML1000:00: resetting...
> [   11.933760] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 01
> [   11.934074] i2c_hid i2c-ATML1000:00: __i2c_hid_command: waiting...
> [   17.071667] i2c_hid i2c-ATML1000:00: __i2c_hid_command: finished.
> [   17.071681] i2c_hid i2c-ATML1000:00: failed to reset device.
> [   17.071702] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> [   17.071714] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 01 08
> [   18.102817] i2c_hid i2c-ATML1000:00: i2c_hid_hwreset
> [   18.102830] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> [   18.102842] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 08
> [   18.103733] i2c_hid i2c-ATML1000:00: resetting...
> [   18.103747] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 01
> [   18.104250] i2c_hid i2c-ATML1000:00: __i2c_hid_command: waiting...
> [   23.239624] i2c_hid i2c-ATML1000:00: __i2c_hid_command: finished.
> [   23.239638] i2c_hid i2c-ATML1000:00: failed to reset device.
> [   23.239659] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> [   23.239671] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 01 08
> [   24.264558] i2c_hid i2c-ATML1000:00: i2c_hid_hwreset
> [   24.264572] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> [   24.264584] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 08
> [   24.265552] i2c_hid i2c-ATML1000:00: resetting...
> [   24.265567] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 01
> [   24.266208] i2c_hid i2c-ATML1000:00: __i2c_hid_command: waiting...
> [   29.404892] i2c_hid i2c-ATML1000:00: __i2c_hid_command: finished.
> [   29.404906] i2c_hid i2c-ATML1000:00: failed to reset device.
> [   29.404927] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> [   29.404939] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 01 08
> [   30.430662] i2c_hid i2c-ATML1000:00: can't add hid device: -61
> [   30.449313] i2c_hid: probe of i2c-ATML1000:00 failed with error -61
> [   30.527802] systemd-journald[107]: Received SIGTERM from PID 1 (systemd).
> [   30.580851] systemd: 15 output lines suppressed due to ratelimiting


[6.] Script:  none needed -- problem occurs on boot

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
	I wasn't sure if this should be run on the machine used to build the 
new kernel, or on the target machine.  Here are both:

-------From the build machine:-----------------------------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux vanguard.uwyo.edu 4.8.0-rrh-g750-1 #1 SMP PREEMPT Tue Oct 4 
08:03:16 MDT 2016 x86_64 x86_64 x86_64 GNU/Linux

GNU C                   4.8
GNU Make                4.0
Binutils                13.2
Util-linux              2.25.1
Mount                   2.25.1
Linux C Library         2.19
Dynamic linker (ldd)    2.19
readlink: missing operand
Try 'readlink --help' for more information.
Procps                  3.3.9
Kbd                     2.0.2
Console-tools           2.0.2
Sh-utils                8.23
Udev                    210
Modules Loaded          ablk_helper ac aesni_intel aes_x86_64 af_packet 
alx asus_nb_wmi asus_wmi battery bluetooth bnep btbcm btintel btrtl 
btusb button cdrom cfg80211 coretemp crc32c_intel crc32_pclmul cryptd 
dm_mod drm drm_kms_helper efivarfs fat fb_sys_fops fuse gf128mul 
glue_helper i2c_algo_bit i2c_i801 i2c_smbus i915 intel_powerclamp 
ip6table_filter ip6table_mangle ip6table_raw ip6_tables ip6t_REJECT 
iptable_filter iptable_raw ip_tables ipt_REJECT irqbypass 
iTCO_vendor_support iTCO_wdt joydev kvm kvm_intel lpc_ich lrw mdio media 
mei mei_me mxm_wmi nf_conntrack nf_conntrack_broadcast nf_conntrack_ipv4 
nf_conntrack_ipv6 nf_conntrack_netbios_ns nf_defrag_ipv4 nf_defrag_ipv6 
nf_reject_ipv4 nf_reject_ipv6 nls_iso8859_1 pcspkr rfkill rtc_cmos 
serio_raw sg shpchp snd snd_hda_codec snd_hda_codec_generic 
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_core snd_hda_intel 
snd_hwdep snd_pcm snd_seq snd_seq_device snd_timer soundcore sr_mod 
syscopyarea sysfillrect sysimgblt thermal tpm tpm_tis tpm_tis_core uhid 
usblp usb_storage uvcvideo vfat video videobuf2_core videobuf2_memops 
videobuf2_v4l2 videobuf2_vmalloc videodev wl wmi x86_pkg_temp_thermal 
xhci_hcd xhci_pci x_tables xt_conntrack xt_CT xt_limit xt_tcpudp

---------------From the target (Baytrail tablet) machine-------------

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux elsie 4.9.0-rc2-rrh-bisect-a11+ #1 SMP PREEMPT Thu Jan 5 23:13:17 
MST 2017 x86_64 x86_64 x86_64 GNU/Linux

GNU C               	4.8
GNU Make            	4.0
Binutils            	42.2
Util-linux          	2.28
Mount               	2.28
Linux C Library     	2.22
Dynamic linker (ldd)	2.22
Procps              	3.3.9
Kbd                 	2.0.3
Console-tools       	2.0.3
Sh-utils            	8.25
Udev                	228
Modules Loaded      	8250_dw ablk_helper ac ac97_bus acpi_pad 
aesni_intel aes_x86_64 af_packet ak8975 asus_nb_wmi asus_wmi battery 
brcmfmac brcmutil button cfg80211 coretemp crc32c_intel crc32_pclmul 
cryptd dm_mod dm_multipath drm drm_kms_helper efivarfs fb_sys_fops fuse 
gf128mul glue_helper gpio_keys i2c_algo_bit i2c_hid i2c_mux i915 
industrialio industrialio_triggered_buffer intel_powerclamp inv_mpu6050 
inv_mpu6050_i2c ip6table_filter ip6table_mangle ip6table_raw ip6_tables 
ip6t_REJECT iptable_filter iptable_raw ip_tables ipt_REJECT irqbypass 
iTCO_vendor_support iTCO_wdt joydev kfifo_buf kvm kvm_intel lpc_ich lrw 
mmc_block mmc_core nf_conntrack nf_conntrack_broadcast nf_conntrack_ipv4 
nf_conntrack_ipv6 nf_conntrack_netbios_ns nf_defrag_ipv4 nf_defrag_ipv6 
nf_reject_ipv4 nf_reject_ipv6 pcspkr rfkill rtc_cmos sdhci sdhci_acpi sg 
snd snd_pcm snd_soc_core snd_soc_rl6231 snd_soc_rt5640 snd_soc_sst_acpi 
snd_soc_sst_baytrail_pcm snd_soc_sst_byt_rt5640_mach snd_soc_sst_dsp 
snd_soc_sst_firmware snd_soc_sst_ipc snd_soc_sst_match snd_timer 
soc_button_array soundcore syscopyarea sysfillrect sysimgblt thermal tpm 
tpm_tis tpm_tis_core usb_storage video wmi xhci_hcd xhci_pci x_tables 
xt_conntrack xt_CT xt_limit xt_tcpudp


[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 55
model name	: Intel(R) Atom(TM) CPU  Z3740  @ 1.33GHz
stepping	: 3
microcode	: 0x31e
cpu MHz		: 533.151
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx 
est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt 
tsc_deadline_timer aes rdrand lahf_lm 3dnowprefetch epb tpr_shadow vnmi 
flexpriority ept vpid tsc_adjust smep erms dtherm ida arat
bugs		:
bogomips	: 2666.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 55
model name	: Intel(R) Atom(TM) CPU  Z3740  @ 1.33GHz
stepping	: 3
microcode	: 0x31e
cpu MHz		: 533.151
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx 
est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt 
tsc_deadline_timer aes rdrand lahf_lm 3dnowprefetch epb tpr_shadow vnmi 
flexpriority ept vpid tsc_adjust smep erms dtherm ida arat
bugs		:
bogomips	: 2677.60
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 55
model name	: Intel(R) Atom(TM) CPU  Z3740  @ 1.33GHz
stepping	: 3
microcode	: 0x31e
cpu MHz		: 540.148
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx 
est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt 
tsc_deadline_timer aes rdrand lahf_lm 3dnowprefetch epb tpr_shadow vnmi 
flexpriority ept vpid tsc_adjust smep erms dtherm ida arat
bugs		:
bogomips	: 2677.76
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 55
model name	: Intel(R) Atom(TM) CPU  Z3740  @ 1.33GHz
stepping	: 3
microcode	: 0x31e
cpu MHz		: 533.151
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx 
est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt 
tsc_deadline_timer aes rdrand lahf_lm 3dnowprefetch epb tpr_shadow vnmi 
flexpriority ept vpid tsc_adjust smep erms dtherm ida arat
bugs		:
bogomips	: 2677.84
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):

af_packet 36864 8 - Live 0x0000000000000000
xt_limit 16384 0 - Live 0x0000000000000000
ip6t_REJECT 16384 3 - Live 0x0000000000000000
nf_reject_ipv6 16384 1 ip6t_REJECT, Live 0x0000000000000000
xt_tcpudp 16384 1 - Live 0x0000000000000000
nf_conntrack_ipv6 16384 2 - Live 0x0000000000000000
nf_defrag_ipv6 32768 1 nf_conntrack_ipv6, Live 0x0000000000000000
ip6table_raw 16384 1 - Live 0x0000000000000000
ipt_REJECT 16384 3 - Live 0x0000000000000000
nf_reject_ipv4 16384 1 ipt_REJECT, Live 0x0000000000000000
iptable_raw 16384 1 - Live 0x0000000000000000
xt_CT 16384 4 - Live 0x0000000000000000
iptable_filter 16384 1 - Live 0x0000000000000000
ip6table_mangle 16384 0 - Live 0x0000000000000000
nf_conntrack_netbios_ns 16384 0 - Live 0x0000000000000000
nf_conntrack_broadcast 16384 1 nf_conntrack_netbios_ns, Live 
0x0000000000000000
nf_conntrack_ipv4 16384 2 - Live 0x0000000000000000
nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0x0000000000000000
ip_tables 24576 2 iptable_raw,iptable_filter, Live 0x0000000000000000
xt_conntrack 16384 4 - Live 0x0000000000000000
nf_conntrack 98304 6 
nf_conntrack_ipv6,xt_CT,nf_conntrack_netbios_ns,nf_conntrack_broadcast,nf_conntrack_ipv4,xt_conntrack, 
Live 0x0000000000000000
ip6table_filter 16384 1 - Live 0x0000000000000000
ip6_tables 24576 3 ip6table_raw,ip6table_mangle,ip6table_filter, Live 
0x0000000000000000
x_tables 32768 13 
xt_limit,ip6t_REJECT,xt_tcpudp,ip6table_raw,ipt_REJECT,iptable_raw,xt_CT,iptable_filter,ip6table_mangle,ip_tables,xt_conntrack,ip6table_filter,ip6_tables, 
Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
kvm_intel 176128 0 - Live 0x0000000000000000
kvm 491520 1 kvm_intel, Live 0x0000000000000000
brcmfmac 212992 0 - Live 0x0000000000000000
brcmutil 16384 1 brcmfmac, Live 0x0000000000000000
snd_soc_sst_baytrail_pcm 24576 2 - Live 0x0000000000000000
cfg80211 458752 1 brcmfmac, Live 0x0000000000000000
fuse 81920 4 - Live 0x0000000000000000
snd_soc_sst_byt_rt5640_mach 16384 2 - Live 0x0000000000000000
snd_soc_sst_dsp 24576 1 snd_soc_sst_baytrail_pcm, Live 0x0000000000000000
snd_soc_sst_ipc 16384 1 snd_soc_sst_baytrail_pcm, Live 0x0000000000000000
snd_soc_rt5640 110592 2 snd_soc_sst_byt_rt5640_mach, Live 0x0000000000000000
snd_soc_sst_firmware 24576 1 snd_soc_sst_baytrail_pcm, Live 
0x0000000000000000
snd_soc_rl6231 16384 1 snd_soc_rt5640, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
snd_soc_core 163840 3 
snd_soc_sst_baytrail_pcm,snd_soc_sst_byt_rt5640_mach,snd_soc_rt5640, 
Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
crc32c_intel 24576 0 - Live 0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
iTCO_wdt 16384 0 - Live 0x0000000000000000
iTCO_vendor_support 16384 1 iTCO_wdt, Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
asus_nb_wmi 28672 0 - Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_pcm 102400 3 snd_soc_sst_baytrail_pcm,snd_soc_rt5640,snd_soc_core, 
Live 0x0000000000000000
asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
gpio_keys 16384 0 - Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 20480 2 aesni_intel,ablk_helper, Live 0x0000000000000000
rfkill 24576 6 cfg80211,asus_wmi, Live 0x0000000000000000
ak8975 20480 0 - Live 0x0000000000000000
pcspkr 16384 0 - Live 0x0000000000000000
snd_timer 32768 1 snd_pcm, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
inv_mpu6050_i2c 16384 0 - Live 0x0000000000000000
snd 69632 7 snd_soc_core,snd_pcm,snd_timer, Live 0x0000000000000000
inv_mpu6050 20480 2 inv_mpu6050_i2c, Live 0x0000000000000000
thermal 20480 0 - Live 0x0000000000000000
industrialio_triggered_buffer 16384 2 ak8975,inv_mpu6050, Live 
0x0000000000000000
kfifo_buf 16384 1 industrialio_triggered_buffer, Live 0x0000000000000000
industrialio 57344 4 
ak8975,inv_mpu6050,industrialio_triggered_buffer,kfifo_buf, Live 
0x0000000000000000
wmi 16384 1 asus_wmi, Live 0x0000000000000000
i2c_mux 16384 1 inv_mpu6050_i2c, Live 0x0000000000000000
rtc_cmos 20480 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
battery 16384 0 - Live 0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
soc_button_array 16384 0 - Live 0x0000000000000000
acpi_pad 16384 0 - Live 0x0000000000000000
tpm_tis_core 20480 1 tpm_tis, Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
tpm 40960 2 tpm_tis,tpm_tis_core, Live 0x0000000000000000
snd_soc_sst_match 16384 1 snd_soc_sst_acpi, Live 0x0000000000000000
mmc_block 36864 5 - Live 0x0000000000000000
i915 1077248 2 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
drm_kms_helper 131072 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
xhci_hcd 167936 1 xhci_pci, Live 0x0000000000000000
drm 303104 4 i915,drm_kms_helper, Live 0x0000000000000000
video 40960 2 asus_wmi,i915, Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
button 16384 1 i915, Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 40960 1 sdhci_acpi, Live 0x0000000000000000
mmc_core 122880 4 brcmfmac,mmc_block,sdhci_acpi,sdhci, Live 
0x0000000000000000
sg 36864 0 - Live 0x0000000000000000
dm_multipath 24576 0 - Live 0x0000000000000000
dm_mod 102400 1 dm_multipath, Live 0x0000000000000000
efivarfs 16384 1 - Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
---------/proc/ioports-----------------
0000-0000 : PCI Bus 0000:00
   0000-0000 : dma1
   0000-0000 : pic1
   0000-0000 : timer0
   0000-0000 : timer1
   0000-0000 : keyboard
   0000-0000 : keyboard
0000-0000 : PCI Bus 0000:00
   0000-0000 : rtc0
0000-0000 : PCI Bus 0000:00
   0000-0000 : dma page reg
   0000-0000 : pic2
   0000-0000 : dma2
   0000-0000 : fpu
   0000-0000 : pnp 00:02
   0000-0000 : serial
   0000-0000 : pnp 00:01
     0000-0000 : iTCO_wdt.2.auto
       0000-0000 : iTCO_wdt
     0000-0000 : iTCO_wdt.2.auto
       0000-0000 : iTCO_wdt
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
   0000-0000 : 0000:00:02.0
   0000-0000 : pnp 00:01

---------/proc/iomem-----------------
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : System ROM
00000000-00000000 : System RAM
   00000000-00000000 : Kernel code
   00000000-00000000 : Kernel data
   00000000-00000000 : Kernel bss
00000000-00000000 : reserved
   00000000-00000000 : 80860F28:00
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : ACPI Tables
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
00000000-00000000 : reserved
   00000000-00000000 : PCI Bus 0000:00
     00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : MSFT0101:00
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : 0000:00:02.0
   00000000-00000000 : 0000:00:02.0
   00000000-00000000 : 0000:00:1a.0
   00000000-00000000 : 0000:00:1a.0
   00000000-00000000 : 0000:00:14.0
     00000000-00000000 : xhci-hcd
00000000-00000000 : 80860F28:00
00000000-00000000 : INT33BB:00
   00000000-00000000 : INT33BB:00
00000000-00000000 : 80860F14:01
   00000000-00000000 : 80860F14:01
00000000-00000000 : INTL9C60:01
   00000000-00000000 : INTL9C60:01
00000000-00000000 : 80860F41:00
   00000000-00000000 : 80860F41:00
00000000-00000000 : 80860F41:01
   00000000-00000000 : 80860F41:01
00000000-00000000 : 80860F41:02
   00000000-00000000 : 80860F41:02
00000000-00000000 : 80860F41:03
   00000000-00000000 : 80860F41:03
00000000-00000000 : 80860F41:04
   00000000-00000000 : 80860F41:04
00000000-00000000 : 80860F41:05
   00000000-00000000 : 80860F41:05
00000000-00000000 : 80860F41:06
   00000000-00000000 : 80860F41:06
00000000-00000000 : INTL9C60:00
   00000000-00000000 : INTL9C60:00
00000000-00000000 : 80860F0A:00
   00000000-00000000 : serial
00000000-00000000 : 80860F14:00
   00000000-00000000 : 80860F14:00
00000000-00000000 : 80860F28:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : INT33BD:00
00000000-00000000 : reserved
00000000-00000000 : IOAPIC 0
00000000-00000000 : HPET 0
   00000000-00000000 : PNP0103:00
00000000-00000000 : reserved
00000000-00000000 : iTCO_wdt.2.auto
   00000000-00000000 : iTCO_wdt
00000000-00000000 : INT33FC:00
   00000000-00000000 : INT33FC:00
00000000-00000000 : INT33FC:01
   00000000-00000000 : INT33FC:01
00000000-00000000 : INT33FC:02
   00000000-00000000 : INT33FC:02
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : Local APIC
00000000-00000000 : INT0800:00
   00000000-00000000 : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx 
Series SoC Transaction Register (rev 09)
	Subsystem: ASUSTeK Computer Inc. Device 14ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Kernel driver in use: iosf_mbi_pci

00:02.0 VGA compatible controller: Intel Corporation Atom Processor 
Z36xxx/Z37xxx Series Graphics & Display (rev 09) (prog-if 00 [VGA 
controller])
	Subsystem: ASUSTeK Computer Inc. Device 14ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 308
	Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at 80000000 (32-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 1000 [size=8]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0200c  Data: 41c3
	Capabilities: [b0] Vendor Specific Information: Len=07 <?>
	Kernel driver in use: i915
	Kernel modules: i915

00:14.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx, 
Celeron N2000 Series USB xHCI (rev 09) (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Device 14ed
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 306
	Region 0: Memory at 90800000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0c00c  Data: 41a3
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:1a.0 Encryption controller: Intel Corporation Atom Processor 
Z36xxx/Z37xxx Series Trusted Execution Engine (rev 09)
	Subsystem: ASUSTeK Computer Inc. Device 14ed
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 90700000 (32-bit, non-prefetchable) [size=1M]
	Region 1: Memory at 90600000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000

00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx 
Series Power Control Unit (rev 09)
	Subsystem: ASUSTeK Computer Inc. Device 14ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich


[7.6.] SCSI information (from /proc/scsi/scsi)

No output from cat /proc/proc/scsi

[8.] Other information that might be relevant to the problem
        Output of git bisect log
> git bisect start
> # good: [69973b830859bc6529a7a0468ba0d80ee5117826] Linux 4.9
> git bisect good 69973b830859bc6529a7a0468ba0d80ee5117826
> # bad: [7ce7d89f48834cefece7804d38fc5d85382edf77] Linux 4.10-rc1
> git bisect bad 7ce7d89f48834cefece7804d38fc5d85382edf77
> # bad: [72cca7baf4fba777b8ab770b902cf2e08941773f] Merge tag 'staging-4.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad 72cca7baf4fba777b8ab770b902cf2e08941773f
> # bad: [b8d2798f32785398fcd1c48ea80c0c6c5ab88537] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect bad b8d2798f32785398fcd1c48ea80c0c6c5ab88537
> # good: [ea3349a03519dcd4f32d949cd80ab995623dc5ac] mlx4: xdp: Reserve headroom for receiving packet when XDP prog is active
> git bisect good ea3349a03519dcd4f32d949cd80ab995623dc5ac
> # good: [e34bac726d27056081d0250c0e173e4b155aa340] Merge branch 'akpm' (patches from Andrew)
> git bisect good e34bac726d27056081d0250c0e173e4b155aa340
> # bad: [96955c9682051e70f06103f0d96e26d2f35f4910] Merge tag 'regmap-v4.10' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
> git bisect bad 96955c9682051e70f06103f0d96e26d2f35f4910
> # good: [2fc9254d0c473e26a668d8efc75dd71146a07852] Merge branch 'silvio' into docs-next
> git bisect good 2fc9254d0c473e26a668d8efc75dd71146a07852
> # bad: [c9d26f1aab007a7083f509b4be263bc904ddb0d3] pinctrl: sx150x: rename 'reg_advance' to 'reg_advanced'
> git bisect bad c9d26f1aab007a7083f509b4be263bc904ddb0d3
> # good: [fdcf83552ab1051f3a0b71a7d5c2e242f97b4157] pinctrl: st: st_pinconf_dbg_show wrong format string
> git bisect good fdcf83552ab1051f3a0b71a7d5c2e242f97b4157
> # good: [d278dae88428d61623590269e5d782264f2ac2f8] Merge tag 'sh-pfc-for-v4.10-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into devel
> git bisect good d278dae88428d61623590269e5d782264f2ac2f8
> # good: [1663682cf090b94bd8531a0b9be812e10477143f] pinctrl: sx150x: use correct registers for reg_sense (sx1502 and sx1508)
> git bisect good 1663682cf090b94bd8531a0b9be812e10477143f
> # bad: [342030c7a29a97bb95151e787a6a347cd031b304] devicetree: bindings: pinctrl: Add binding for ti,da850-pupd
> git bisect bad 342030c7a29a97bb95151e787a6a347cd031b304
> # good: [4f5ac8cf0a1121144432fd0175fac9ec31f58cd0] pinctrl: sx150x: add support for sx1501, sx1504, sx1505 and sx1507
> git bisect good 4f5ac8cf0a1121144432fd0175fac9ec31f58cd0
> # bad: [0ea66f76ba17a4b229caaadd77de694111b21769] Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
> git bisect bad 0ea66f76ba17a4b229caaadd77de694111b21769


