From: Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
Subject: Re: [regression, bisected] Keyboard not responding after resuming
 from suspend/hibernate
Date: Sun, 28 Oct 2018 22:06:54 +0300
Message-ID: <20181028220654.7e77e5d7@ubuntu>
References: <20180831215121.1b1f66bf@korsan.localdomain>
 <20181019102031.77015d44@korsan.localdomain>
 <20181025074903.GA9323@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_//2mNov3Aidtn8fBTBd=rAGU"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025074903.GA9323@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: jason.low2@hpe.com, Waiman.Long@hpe.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, dmitry.torokhov@gmail.com, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--Sig_//2mNov3Aidtn8fBTBd=rAGU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thu, 25 Oct 2018 09:49:03 +0200 tarihinde
Pavel Machek <pavel@ucw.cz> yazd=C4=B1:

> Hi!
>=20
> Here's problem bisected down to:
>=20
> commit 9d659ae14b545c4296e812c70493bfdc999b5c1c
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Aug 23 14:40:16 2016 +0200
>=20
>     locking/mutex: Add lock handoff to avoid starvation
>=20
>     Implement lock handoff to avoid lock starvation.
>=20
> Numan, I assume revert of that patch on the 4.18 kernel still makes it
> work?
>=20

Unfortunately, I could not revert
9d659ae14b545c4296e812c70493bfdc999b5c1c on kernels from 4.18.16 to
4.10-rc1 because there were too much conflicts, which I could not solve
as an "average Joe". I tried a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
which is parent of 9d659ae14b545c4296e812c70493bfdc999b5c1c and
succeeded to compile kernel.

git checkout a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3

Then, I compiled kernel and rebooted with it. I tried a couples of
times suspending and resuming, all of the time keyboard worked as
expected.

uname -a
Linux ubuntu 4.9.0-rc2reverted+ #1 SMP Sun Oct 28 20:29:39 +03 2018
x86_64 x86_64 x86_64 GNU/Linux

awk -f ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ubuntu 4.9.0-rc2reverted+ #1 SMP Sun Oct 28 20:29:39 +03 2018
x86_64 x86_64 x86_64 GNU/Linux

GNU Make            	4.1
Binutils            	2.30
Util-linux          	2.31.1
Mount               	2.31.1
Module-init-tools   	24
E2fsprogs           	1.44.1
Pcmciautils         	018
Linux C Library     	2.27
Dynamic linker (ldd)	2.27
Linux C++ Library   	6.0.25
Procps              	3.3.12
Kbd                 	2.0.4
Console-tools       	2.0.4
Sh-utils            	8.28
Udev                	237
Wireless-tools      	30
Modules Loaded      	ahci arc4 ath ath9k ath9k_common ath9k_hw
autofs4 binfmt_misc ccm cfg80211 coretemp crc32_pclmul crct10dif_pclmul
cryptd drm drm_kms_helper fb_sys_fops fjes ghash_clmulni_intel hid
hid_generic i2c_algo_bit i915 input_leds intel_cstate intel_powerclamp
intel_rapl intel_rapl_perf ip6table_filter ip6_tables ip6t_REJECT
ip6t_rt iptable_filter ip_tables ipt_REJECT irqbypass kvm kvm_intel
libahci lpc_ich mac80211 mac_hid mei mei_me nf_conntrack
nf_conntrack_broadcast nf_conntrack_ftp nf_conntrack_ipv4
nf_conntrack_ipv6 nf_conntrack_netbios_ns nf_defrag_ipv4 nf_defrag_ipv6
nf_log_common nf_log_ipv4 nf_log_ipv6 nf_nat nf_nat_ftp nf_reject_ipv4
nf_reject_ipv6 psmouse sch_fq_codel serio_raw shpchp snd snd_hda_codec
snd_hda_codec_conexant snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_core snd_hda_intel snd_hwdep snd_pcm snd_rawmidi snd_seq
snd_seq_device snd_seq_midi snd_seq_midi_event snd_timer sony_laptop
soundcore syscopyarea sysfillrect sysimgblt usbhid video
x86_pkg_temp_thermal x_tables xt_addrtype xt_conntrack xt_hl xt_limit
xt_LOG xt_tcpudp

 dmesg | grep i8042
[    2.986695] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
 at 0x60,0x64 irq 1,12 [    2.989921] serio: i8042 KBD port at
 0x60,0x64 irq 1 [    2.989925] serio: i8042 AUX port at 0x60,0x64 irq
 12 [    3.014179] input: AT Translated Set 2 keyboard
 as /devices/platform/i8042/serio0/input/input3 [   20.297566] input:
 AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio1/input/input8

> Peter, any ideas?
>=20
> 								Pavel
>=20
> On Fri 2018-10-19 10:20:31, Numan Demird=C3=B6=C4=9Fen wrote:
> > On Fri, 31 Aug 2018 21:53:11 +0300
> > Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> wrote:
> >  =20
> > >If I put laptop to suspend or hibernate by closing lid, power
> > >manager or any other method and then I resume/wake up laptop,
> > >keyboard is not responding. My laptop is a Sony Vaio VPCEH2F1E.=20
> > >
> > >Steps to produce bug:
> > >1. Boot
> > >2. Put laptop to sleep
> > >3. Resume
> > >
> > >What I expect to happen: Keyboard responds to key press.
> > >What happens: Keyboard does not respond but mouse and trackball are
> > >working.
> > >
> > >git bisect point 9d659ae14b545c4296e812c70493bfdc999b5c1c as the
> > >first bad commit.
> > >
> > >Bad commit link:
> > >https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=
=3D9d659ae14b545c4296e812c70493bfdc999b5c1c
> > >
> > > Link to actual bug report:
> > >https://bugzilla.kernel.org/show_bug.cgi?id=3D195471
> > >
> > >awk -f ver_linux
> > >Linux korsan 4.18.5-arch1-1-ARCH #1 SMP PREEMPT Fri Aug 24 12:48:58
> > >UTC 2018 x86_64 GNU/Linux GNU C               	8.2.0
> > >GNU Make            	4.2.1
> > >Binutils            	2.31.1
> > >Util-linux          	2.32.1
> > >Mount               	2.32.1
> > >Module-init-tools   	25
> > >E2fsprogs           	1.44.4
> > >Jfsutils            	1.1.15
> > >Reiserfsprogs       	3.6.27
> > >Xfsprogs            	4.17.0
> > >Pcmciautils         	018
> > >Linux C Library     	2.28
> > >Dynamic linker (ldd)	2.28
> > >Linux C++ Library   	6.0.25
> > >Procps              	3.3.15
> > >Kbd                 	2.0.4
> > >Console-tools       	2.0.4
> > >Sh-utils            	8.29
> > >Udev                	239
> > >Wireless-tools      	30
> > >Modules Loaded      	ac agpgart ahci arc4 ath ath3k ath9k
> > >ath9k_common ath9k_hw atkbd battery bluetooth bpfilter ccm cdrom
> > >cfg80211 coretemp crc16 crc32c_generic crc32c_intel crc32_pclmul
> > >crct10dif_pclmul cryptd drm drm_kms_helper ecdh_generic ehci_hcd
> > >ehci_pci evdev ext4 fb_sys_fops fscrypto fuse ghash_clmulni_intel
> > >gpio_ich hid hid_generic i2c_algo_bit i2c_i801 i8042 i915
> > >input_leds intel_cstate intel_gtt intel_powerclamp intel_rapl
> > >intel_rapl_perf intel_uncore iptable_filter iptable_mangle
> > >iptable_nat ip_tables irqbypass iTCO_vendor_support iTCO_wdt jbd2
> > >kvm kvm_intel led_class libahci libata libcrc32c libps2 lpc_ich
> > >mac80211 mac_hid mbcache mei mei_me mousedev msr nf_conntrack
> > >nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat nf_nat_ipv4 pcc_cpufreq
> > >psmouse rfkill rtc_cmos scsi_mod sd_mod serio serio_raw snd
> > >snd_hda_codec snd_hda_codec_conexant snd_hda_codec_generic
> > >snd_hda_codec_hdmi snd_hda_core snd_hda_intel snd_hwdep snd_pcm
> > >snd_timer sony_laptop soundcore sr_mod syscopyarea sysfillrect
> > >sysimgblt usb_common usbcore usbhid x86_pkg_temp_thermal x_tables
> > >
> > >dmesg | grep i8042
> > >[    0.574078] i8042: PNP: PS/2 Controller
> > >[PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12 [    0.575936]
> > >serio: i8042 KBD port at 0x60,0x64 irq 1 [    0.576143] serio:
> > >i8042 AUX port at 0x60,0x64 irq 12 [    0.618880] input: AT
> > >Translated Set 2 keyboard
> > >as /devices/platform/i8042/serio0/input/input3 [   11.248435]
> > >input: AlpsPS/2 ALPS GlidePoint
> > >as /devices/platform/i8042/serio1/input/input5
> > >
> > >cat /proc/interrupts=20
> > >           CPU0       CPU1       CPU2       CPU3      =20
> > >  0:          8          0          0          0   IO-APIC
> > > 2-edge      timer 1:          0          0          0      10286
> > > IO-APIC   1-edge      i8042 8:          0          0
> > > 0          1   IO-APIC   8-edge      rtc0 9:          0
> > > 9479          0          0   IO-APIC   9-fasteoi   acpi 12:
> > > 0          0     370114          0   IO-APIC  12-edge      i8042
> > > 16:     197457          0          0          0   IO-APIC
> > > 16-fasteoi   ehci_hcd:usb1, ath9k 19:          0          0
> > > 0          0   IO-APIC  19-fasteoi   i801_smbus 23:
> > > 0          0      71055          0   IO-APIC  23-fasteoi
> > > ehci_hcd:usb2 24:          0      74549          0          0
> > > PCI-MSI 512000-edge      ahci[0000:00:1f.2] 25:          0
> > > 14          0          0   PCI-MSI 360448-edge      mei_me
> > > 26:          0          0     138870          0   PCI-MSI
> > > 32768-edge      i915 27:          0          0          0
> > > 330   PCI-MSI 442368-edge      snd_hda_intel:card0
> > >NMI:         24         22         25         21   Non-maskable
> > >interrupts LOC:     534734     446934     603337     440320   Local
> > >timer interrupts SPU:          0          0          0          0
> > >Spurious interrupts PMI:         24         22         25
> > >21 Performance monitoring interrupts IWI:         26         12
> > >43115         22   IRQ work interrupts RTR:          0
> > >0          0          0   APIC ICR read retries RES:      95282
> > >76970      60242      46409   Rescheduling interrupts CAL:
> > >66746      75300      70554      69119   Function call interrupts
> > >TLB:      50929      54528      51413      48017   TLB shootdowns
> > >TRM:          0          0          0          0   Thermal event
> > >interrupts THR:          0          0          0          0
> > >Threshold APIC interrupts DFR:          0          0
> > >0          0   Deferred Error APIC interrupts MCE:          0
> > >0          0          0   Machine check exceptions MCP:
> > >18         19         19         19   Machine check polls
> > >HYP:          0          0          0          0   Hypervisor
> > >callback interrupts HRE:          0          0          0
> > >0   Hyper-V reenlightenment interrupts HVS:          0          0
> > >0          0   Hyper-V stimer0 interrupts ERR:          0
> > >MIS:          0 PIN:          0          0          0          0
> > >Posted-interrupt notification event NPI:          0
> > >0          0          0   Nested posted-interrupt event PIW:
> > >0          0          0          0   Posted-interrupt wakeup event
> > >
> > >P.S: My native language is not English.
> > > =20
> >=20
> > Hi,
> >=20
> > I am forwarding this e-mail which describes a problem related to
> > suspend/hibernate at the advise of Pavel Machek.
> >  =20

--Sig_//2mNov3Aidtn8fBTBd=rAGU
Content-Type: application/pgp-signature
Content-Description: Dijital OpenPGP imzası

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEKU9fayrDgTGfA1OV4Dh9jqVujDIFAlvWCM4ACgkQ4Dh9jqVu
jDJVywf/WX7J1atGdor1e4wrSzhzda0lKysWurPxsQWt5Dmb1PJxdfDfB3MyDBcO
ulQxXklUscblCWr8LIRFSjwvKfZ7MRzs9LXBv32sveAj0lnoXJs7mpSNwLVPvTY+
dHYZo+IahbfPlv81GWMo5sRnWbJn/e7+TD7Mz/wn7PEeGi0EXHbDZ6f9Met7P2Rv
ujxd8E6wBjVboXzUC5cBlyfPLZSAbJr70Lm7skA46xhonkqgV3AMGeJpawSfAbZX
WvkzOocnF0G8vjEZjBiM4KFhf44z0T+NckzYtY7Bb8r9mXu1J5+XnGyP39qw0AXy
swvudIDZpH9vX6YYX4BWAIXpxJgnyA==
=5KTn
-----END PGP SIGNATURE-----

--Sig_//2mNov3Aidtn8fBTBd=rAGU--
