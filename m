From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [BUG] object: is not initialized, yet kobject_put() is being
 called
Date: Wed, 11 Aug 2010 00:32:15 +0200
Message-ID: <20100810223215.GA1609@arch.tripp.de>
References: <20100810210941.GA7938@fritha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100810210941.GA7938@fritha.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heinz Diehl <htd@fritha.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 10, 2010 at 11:09:41PM +0200, Heinz Diehl wrote:
> Hi,
>=20
> I'm getting this in my logs with the latest -git7/8/9 kernels. Thw ap=
cups
> is not defective, it works flawlessly with 2.6.34.X.
>=20
> Aug 10 23:01:44 liesel apcupsd[7687]: apcupsd FATAL ERROR in linux-us=
b.c
> at line 609 Cannot find UPS device -- For a link to detailed USB trou=
ble
> shooting information, please see <http://www.apcupsd.com/support.html=
>.
> Aug 10 23:01:44 liesel apcupsd[7687]: apcupsd error shutdown complete=
d
> Aug 10 23:04:40 liesel kernel: ------------[ cut here ]------------
>=20
> Aug 10 23:04:40 liesel kernel: WARNING: at lib/kobject.c:595 kobject_=
put+0x2f/0x50()
> Aug 10 23:04:40 liesel kernel: Hardware name: GA-MA770-UD3 Aug 10 23:=
04:40 liesel kernel: kobject: '(null)' (ffff88022c651898): is
> not initialized, yet kobject_put() is being called. Aug 10 23:04:40 l=
iesel kernel: Modules linked in: xt_pkttype ipt_LOG
> xt_limit aes_x86_64 aes_generic af_packet it87 hwmon_vid binfmt_misc =
snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device cpufreq_conservative
> cpufreq_ondemand cpufreq_userspace cpufreq_powersave powernow_k8 freq=
_table mperf xt_NOTRACK xt_state iptable_raw nf_conntrack_netbios_ns
> nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip6_tables ipt_REJECT i=
ptable_filter ip_tables tcp_vegas uhci_hcd rt73usb rt2x00usb rt2x00lib
> r8169 led_class mii mac80211 snd_hda_codec_realtek ppdev parport_pc c=
fg80211 parport snd_hda_intel snd_hda_codec snd_pcm snd_timer snd
> soundcore sr_mod k10temp hwmon i2c_piix4 pcspkr cdrom button rfkill j=
oydev snd_page_alloc i2c_core sg xts usbhid sd_mod ohci_hcd ehci_hcd rt=
c_cmos
> rtc_core pata_atiixp rtc_lib usbcore ahci libahci hmac dm_snapshot dm=
_crypt dm_mod gf128mul sha512_generic sha256_generic twofish_x86_64
> twofish_common serpent cbc tgr192 loop ecb arc4 fuse edd ide_pci_gene=
ric amd74xx ide_core fan pata_amd sata_nv libata scsi
> Aug 10 23:04:40 liesel kernel: Pid: 1115, comm: khubd Not tainted 2.6=
=2E35-git9 #1
> Aug 10 23:04:40 liesel kernel: Call Trace:
> Aug 10 23:04:40 liesel kernel:  [<ffffffff812a620f>] ? kobject_put+0x=
2f/0x50
> Aug 10 23:04:40 liesel kernel:  [<ffffffff812a620f>] ? kobject_put+0x=
2f/0x50
> Aug 10 23:04:40 liesel kernel:  [<ffffffff810414f1>] ? warn_slowpath_=
common+0x81/0xe0
> Aug 10 23:04:40 liesel kernel:  [<ffffffff81041605>] ? warn_slowpath_=
fmt+0x45/0x50
> Aug 10 23:04:40 liesel kernel:  [<ffffffff812a620f>] ? kobject_put+0x=
2f/0x50
> Aug 10 23:04:40 liesel kernel:  [<ffffffffa00bea3e>] ? usbhid_disconn=
ect+0x1e/0x40 [usbhid]
> Aug 10 23:04:40 liesel kernel:  [<ffffffffa01a7525>] ? usb_unbind_int=
erface+0xc5/0x120 [usbcore]
> Aug 10 23:04:40 liesel kernel:  [<ffffffff8133ffc8>] ? __device_relea=
se_driver+0x78/0xf0
> Aug 10 23:04:40 liesel kernel:  [<ffffffff81340125>] ? device_release=
_driver+0x25/0x40
> Aug 10 23:04:40 liesel kernel:  [<ffffffff8133f4a2>] ? bus_remove_dev=
ice+0xa2/0xf0
> Aug 10 23:04:40 liesel kernel:  [<ffffffff8133d7da>] ? device_del+0x1=
2a/0x1d0
> Aug 10 23:04:40 liesel kernel:  [<ffffffffa01a4b8d>] ? usb_disable_de=
vice+0x8d/0x110 [usbcore]
> Aug 10 23:04:40 liesel kernel:  [<ffffffffa019f6bb>] ? usb_disconnect=
+0x7b/0x120 [usbcore]
> Aug 10 23:04:40 liesel kernel:  [<ffffffffa01a03c2>] ? hub_thread+0x3=
22/0x11d0 [usbcore]
> Aug 10 23:04:40 liesel kernel:  [<ffffffff81034a77>] ? set_next_entit=
y+0x37/0x80
> Aug 10 23:04:40 liesel kernel:  [<ffffffff8105c330>] ? autoremove_wak=
e_function+0x0/0x30
> Aug 10 23:04:40 liesel kernel:  [<ffffffffa01a00a0>] ? hub_thread+0x0=
/0x11d0 [usbcore]
> Aug 10 23:04:40 liesel kernel:  [<ffffffffa01a00a0>] ? hub_thread+0x0=
/0x11d0 [usbcore]
> Aug 10 23:04:40 liesel kernel:  [<ffffffff8105be56>] ? kthread+0x96/0=
xb0
> Aug 10 23:04:40 liesel kernel:  [<ffffffff81003b14>] ? kernel_thread_=
helper+0x4/0x10
> Aug 10 23:04:40 liesel kernel:  [<ffffffff8105bdc0>] ? kthread+0x0/0x=
b0
> Aug 10 23:04:40 liesel kernel:  [<ffffffff81003b10>] ? kernel_thread_=
helper+0x0/0x10
> Aug 10 23:04:40 liesel kernel: ---[ end trace 808e80ff1e6d651e ]---

I'm seeing something similar today:

hub 3-0:1.0: port 1 disabled by hub (EMI?), re-enabling...
usb 3-1: USB disconnect, address 2
------------[ cut here ]------------
WARNING: at lib/kobject.c:595 kobject_put+0x37/0x4b()
Hardware name: System Product Name
kobject: '(null)' (ffff88011e9cd898): is not initialized, yet kobject_p=
ut() is being called.
Pid: 310, comm: khubd Not tainted 2.6.35-06113-gf6cec0a-dirty #4
Call Trace:
 [<ffffffff8105e7f7>] warn_slowpath_common+0x80/0x98
 [<ffffffff8105e8a2>] warn_slowpath_fmt+0x46/0x48
 [<ffffffff8118fbad>] kobject_put+0x37/0x4b
 [<ffffffff812aa88d>] put_device+0x17/0x19
 [<ffffffff8132fef1>] hid_destroy_device+0x41/0x45
 [<ffffffff81335e5f>] usbhid_disconnect+0x3e/0x4b
 [<ffffffff812fbd0d>] usb_unbind_interface+0x4c/0xd3
 [<ffffffff812ad746>] __device_release_driver+0x6c/0xb5
 [<ffffffff812adc33>] device_release_driver+0x23/0x30
 [<ffffffff812ace3b>] bus_remove_device+0x89/0x99
 [<ffffffff812aaec6>] device_del+0x12d/0x17f
 [<ffffffff812facc4>] usb_disable_device+0x86/0xfd
 [<ffffffff812f446a>] usb_disconnect+0x8e/0xf6
 [<ffffffff812f62fd>] hub_thread+0x3eb/0xcb5
 [<ffffffff8140170b>] ? _raw_spin_unlock_irq+0x16/0x31
 [<ffffffff81077ea3>] ? autoremove_wake_function+0x0/0x39
 [<ffffffff812f5f12>] ? hub_thread+0x0/0xcb5
 [<ffffffff8107750e>] kthread+0x82/0x8a
 [<ffffffff8102f794>] kernel_thread_helper+0x4/0x10
 [<ffffffff8107748c>] ? kthread+0x0/0x8a
 [<ffffffff8102f790>] ? kernel_thread_helper+0x0/0x10
---[ end trace 5707e7a0642da347 ]---
------------[ cut here ]------------
WARNING: at lib/kobject.c:595 kobject_put+0x37/0x4b()
Hardware name: System Product Name
kobject: '(null)' (ffff88011e9fd898): is not initialized, yet kobject_p=
ut() is being called.
Pid: 310, comm: khubd Tainted: G        W   2.6.35-06113-gf6cec0a-dirty=
 #4
Call Trace:
 [<ffffffff8105e7f7>] warn_slowpath_common+0x80/0x98
 [<ffffffff8105e8a2>] warn_slowpath_fmt+0x46/0x48
 [<ffffffff8118fbad>] kobject_put+0x37/0x4b
 [<ffffffff812aa88d>] put_device+0x17/0x19
 [<ffffffff8132fef1>] hid_destroy_device+0x41/0x45
 [<ffffffff81335e5f>] usbhid_disconnect+0x3e/0x4b
 [<ffffffff812fbd0d>] usb_unbind_interface+0x4c/0xd3
 [<ffffffff812ad746>] __device_release_driver+0x6c/0xb5
 [<ffffffff812adc33>] device_release_driver+0x23/0x30
 [<ffffffff812ace3b>] bus_remove_device+0x89/0x99
 [<ffffffff812aaec6>] device_del+0x12d/0x17f
 [<ffffffff812facc4>] usb_disable_device+0x86/0xfd
 [<ffffffff812f446a>] usb_disconnect+0x8e/0xf6
 [<ffffffff812f62fd>] hub_thread+0x3eb/0xcb5
 [<ffffffff8140170b>] ? _raw_spin_unlock_irq+0x16/0x31
 [<ffffffff81077ea3>] ? autoremove_wake_function+0x0/0x39
 [<ffffffff812f5f12>] ? hub_thread+0x0/0xcb5
 [<ffffffff8107750e>] kthread+0x82/0x8a
 [<ffffffff8102f794>] kernel_thread_helper+0x4/0x10
 [<ffffffff8107748c>] ? kthread+0x0/0x8a
 [<ffffffff8102f790>] ? kernel_thread_helper+0x0/0x10
---[ end trace 5707e7a0642da348 ]---
usb 3-1: new full speed USB device using ohci_hcd and address 3
input: Logitech USB Receiver as /devices/pci0000:00/0000:00:12.0/usb3/3=
-1/3-1:1.0/input/input6
generic-usb 0003:046D:C52B.0006: input,hidraw0: USB HID v1.11 Keyboard =
[Logitech USB Receiver] on usb-0000:00:12.0-1/input0
input: Logitech USB Receiver as /devices/pci0000:00/0000:00:12.0/usb3/3=
-1/3-1:1.1/input/input7
generic-usb 0003:046D:C52B.0007: input,hiddev0,hidraw5: USB HID v1.11 M=
ouse [Logitech USB Receiver] on usb-0000:00:12.0-1/input1
generic-usb 0003:046D:C52B.0008: hiddev0,hidraw6: USB HID v1.11 Device =
[Logitech USB Receiver] on usb-0000:00:12.0-1/input2


--=20
=BBA man who doesn't know he is in prison can never escape.=AB
William S. Burroughs
