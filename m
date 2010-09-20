From: Mat <jackdachef@gmail.com>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Mon, 20 Sep 2010 15:56:54 +0200
Message-ID: <AANLkTim6PBGEBz8_PVpK2YajgtejsbAgL11i+DMN-7jh@mail.gmail.com>
References: <4C96B9DB.8030403@turmel.org>
	<AANLkTi=1zh4hD-1uzpgjAsnKZBE=qi_ZAX-ug=2XMkW0@mail.gmail.com>
	<alpine.LNX.2.00.1009201440140.26813@pobox.suse.cz>
	<4C975F79.9060609@turmel.org>
	<alpine.LNX.2.00.1009201524340.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1009201524340.26813@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Guillaume Chazarain <guichaz@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Alan Ott <alan@signal11.us>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Andreas Bombe <aeb@debian.org>, Alex Riesen <raa.lkml@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 20, 2010 at 3:25 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 20 Sep 2010, Phil Turmel wrote:
>
>> >>> The USB mouse I use with my laptop is causing a BUG when inserte=
d. =A0It works at that
>> >>> point, but if removed and re-inserted, it is ignored. =A0Also, a=
fter the 2nd insert,
>> >>> other USB devices (like my thumb drive) are also ignored.
>> >>>
>> >>> [ =A0 37.450777] BUG: unable to handle kernel NULL pointer deref=
erence at (null)
>> >>> [ =A0 37.451148] IP: [<ffffffff817d0991>] hiddev_open+0xc1/0x220
>> >>> [ =A0 37.452036] PGD 1131a0067 PUD 113036067 PMD 0
>> >>> [ =A0 37.452924] Oops: 0000 [#1] PREEMPT SMP
>> >>> [ =A0 37.453336] last sysfs file: /sys/devices/platform/toshiba_=
acpi/backlight/toshiba/max_brightness
>> >>> [ =A0 37.453336] CPU 1
>> >>> [ =A0 37.453336] Modules linked in: tpm_infineon iwlagn iwlcore =
tifm_7xx1 tpm_tis toshiba_bluetooth toshiba_acpi tifm_core pcmcia sdhci=
_pci yenta_socket sdhci [last unloaded: scsi_wait_scan]
>> >>> [ =A0 37.453336]
>> >>> [ =A0 37.453336] Pid: 3117, comm: hald-probe-hidd Not tainted 2.=
6.36-rc4-00166-g151b6a5 #28 Portable PC/TECRA A9
>> >>> [ =A0 37.453336] RIP: 0010:[<ffffffff817d0991>] =A0[<ffffffff817=
d0991>] hiddev_open+0xc1/0x220
>> >
>> > Could please those of you who are able to reproduce the problem (f=
rom a
>> > quick test seems that I am not) use 'addr2line' utility to convert=
 the RIP
>> > value (ffffffff817d0991 in this case) to the line number inside of
>> > hiddev_open(), so that we can see whether it's something behind
>> > usbhid_find_interface() causing NULL pointer dereference, or wheth=
er it is
>> > intfdata being NULL and thus going to hid->hiddev faults?

[snip]

> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>

Hi Jiri,

hope that's the information you need - I rebuilt a debug-kernel so if
you need more information, just ask:


ls -l /usr/src/linux-2.6.36-rc4_hiddev/vmlinux
-rwxrwx--- 1 root root 174167283 Sep 20 15:17
/usr/src/linux-2.6.36-rc4_hiddev/vmlinux
wolf ~ # addr2line -e /usr/src/linux-2.6.36-rc4_hiddev/vmlinux -i
ffffffff815a0815
/usr/src/linux/drivers/hid/usbhid/hiddev.c:289

the relevant line is marked "=3D=3D>	if (list->hiddev->exist) {"


code-snip from hiddev.c
***********************************************************************=
*******************

/*
 * open file op
 */
static int hiddev_open(struct inode *inode, struct file *file)
{
	struct hiddev_list *list;
	struct usb_interface *intf;
	struct hid_device *hid;
	struct hiddev *hiddev;
	int res;

	intf =3D usb_find_interface(&hiddev_driver, iminor(inode));
	if (!intf)
		return -ENODEV;
	hid =3D usb_get_intfdata(intf);
	hiddev =3D hid->hiddev;

	if (!(list =3D kzalloc(sizeof(struct hiddev_list), GFP_KERNEL)))
		return -ENOMEM;
	mutex_init(&list->thread_lock);
	list->hiddev =3D hiddev;
	file->private_data =3D list;

	/*
	 * no need for locking because the USB major number
	 * is shared which usbcore guards against disconnect
	 */
=3D=3D>	if (list->hiddev->exist) {
		if (!list->hiddev->open++) {
			res =3D usbhid_open(hiddev->hid);
			if (res < 0) {
				res =3D -EIO;
				goto bail;
			}
		}
	} else {
		res =3D -ENODEV;
		goto bail;
	}

	spin_lock_irq(&list->hiddev->list_lock);
	list_add_tail(&list->node, &hiddev->list);
	spin_unlock_irq(&list->hiddev->list_lock);

	if (!list->hiddev->open++)
		if (list->hiddev->exist) {
			struct hid_device *hid =3D hiddev->hid;
			res =3D usbhid_get_power(hid);
			if (res < 0) {
				res =3D -EIO;
				goto bail;
			}
			usbhid_open(hid);
		}
	return 0;
bail:
	file->private_data =3D NULL;
	kfree(list);
	return res;
}


code-snip from hiddev.c
***********************************************************************=
*******************

below is the new error-message after inserting the transmitter:

[   80.363970] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0008
[   80.364273] hub 1-1:1.0: port 3, status 0101, change 0001, 12 Mb/s
[   80.468649] hub 1-1:1.0: debounce: port 3: total 100ms stable 100ms
status 0x101
[   80.479626] hub 1-1:1.0: port 3 not reset yet, waiting 10ms
[   80.541530] usb 1-1.3: new low speed USB device using ehci_hcd and a=
ddress 4
[   80.553453] hub 1-1:1.0: port 3 not reset yet, waiting 10ms
[   80.631103] usb 1-1.3: skipped 1 descriptor after interface
[   80.631109] usb 1-1.3: skipped 1 descriptor after interface
[   80.631682] usb 1-1.3: default language 0x0409
[   80.633716] usb 1-1.3: udev 4, busnum 1, minor =3D 3
[   80.633721] usb 1-1.3: New USB device found, idVendor=3D046d, idProd=
uct=3Dc521
[   80.633724] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[   80.633728] usb 1-1.3: Product: USB Receiver
[   80.633730] usb 1-1.3: Manufacturer: Logitech
[   80.633856] usb 1-1.3: usb_probe_device
[   80.633862] usb 1-1.3: configuration #1 chosen from 1 choice
[   80.635683] usb 1-1.3: adding 1-1.3:1.0 (config #1, interface 0)
[   80.635753] usbhid 1-1.3:1.0: usb_probe_interface
[   80.635758] usbhid 1-1.3:1.0: usb_probe_interface - got id
[   80.639327] input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.0/input/input4
[   80.639428] usb 1-1.3: link qh8-0e01/ffff8801bce8fbc0 start 4 [1/2 u=
s]
[   80.639549] generic-usb 0003:046D:C521.0004: input,hidraw2: USB HID
v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1a.0-1.3/input0
[   80.639600] usb 1-1.3: adding 1-1.3:1.1 (config #1, interface 1)
[   80.639657] usbhid 1-1.3:1.1: usb_probe_interface
[   80.639662] usbhid 1-1.3:1.1: usb_probe_interface - got id
[   80.646672] input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.1/input/input5
[   80.646716] usb 1-1.3: link qh8-0e01/ffff8801bacba1c0 start 5 [1/2 u=
s]
[   80.646784] drivers/usb/core/file.c: looking for a minor, starting a=
t 0
[   80.646948] generic-usb 0003:046D:C521.0005: input,hiddev0,hidraw3:
USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:00:1a.0-1.3/input1
[   80.647069] drivers/usb/core/inode.c: creating file '004'
[   80.667098] BUG: unable to handle kernel NULL pointer dereference at=
 (null)
[   80.667102] IP: [<ffffffff815a0815>] hiddev_open+0xa5/0x1b0
[   80.667108] PGD 0
[   80.667110] Oops: 0000 [#1] PREEMPT SMP
[   80.667112] last sysfs file:
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.0/input/inp=
ut4/capabilities/sw
[   80.667115] CPU 0
[   80.667116] Modules linked in: it87 hwmon_vid hwmon e1000e
firewire_ohci firewire_core shpchp wmi i2c_i801 tg3 libphy e1000
scsi_wait_scan sl811_hcd ohci_hcd ssb usb_storage ehci_hcd
[   80.667125]
[   80.667128] Pid: 5636, comm: hald-probe-hidd Not tainted
2.6.36-rc4_hiddev+ #1 FMP55/ipower G3710
[   80.667130] RIP: 0010:[<ffffffff815a0815>]  [<ffffffff815a0815>]
hiddev_open+0xa5/0x1b0
[   80.667135] RSP: 0018:ffff8801bffdfca8  EFLAGS: 00010296
[   80.667137] RAX: 0000000000000000 RBX: ffff8801bad5b180 RCX: 0000000=
000000000
[   80.667138] RDX: ffffffff81de0028 RSI: ffffffff81a02dbc RDI: ffff880=
1bb25c030
[   80.667140] RBP: ffff8801bb250000 R08: 0000000000000000 R09: ffff880=
1bb250000
[   80.667142] R10: ffff8801bfc02be0 R11: dead000000200200 R12: 0000000=
000000000
[   80.667143] R13: ffffffff818f24e0 R14: 00000000ffffffed R15: 0000000=
000000000
[   80.667146] FS:  00007f3d97180700(0000) GS:ffff880002000000(0000)
knlGS:0000000000000000
[   80.667148] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.667149] CR2: 0000000000000000 CR3: 00000001bb872000 CR4: 0000000=
0000006f0
[   80.667151] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[   80.667153] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[   80.667155] Process hald-probe-hidd (pid: 5636, threadinfo
ffff8801bffde000, task ffff8801bffbc810)
[   80.667156] Stack:
[   80.667157]  ffff8801bf52d2c0 ffffffff810d8af0 ffff8801bad5b180
ffffffff818e2b00
[   80.667160] <0> ffff8801bcdb04d8 ffffffff814dc885 ffff8801bcdb04d8
ffff8801bad5b180
[   80.667163] <0> ffff8801bf52d2c0 0000000000000000 ffffffff810d9350
ffffffff810d9495
[   80.667166] Call Trace:
[   80.667170]  [<ffffffff810d8af0>] ? exact_match+0x0/0x10
[   80.667178]  [<ffffffff814dc885>] ? usb_open+0xf5/0x1d0
[   80.667180]  [<ffffffff810d9350>] ? chrdev_open+0x0/0x210
[   80.667182]  [<ffffffff810d9495>] ? chrdev_open+0x145/0x210
[   80.667186]  [<ffffffff810d3b40>] ? __dentry_open.clone.16+0x100/0x3=
20
[   80.667189]  [<ffffffff810e2390>] ? do_last.clone.45+0x3f0/0x690
[   80.667192]  [<ffffffff810e2823>] ? do_filp_open+0x1f3/0x5f0
[   80.667196]  [<ffffffff8160f5ec>] ? move_addr_to_user+0x4c/0x60
[   80.667198]  [<ffffffff816100c2>] ? sys_getsockname+0xe2/0x100
[   80.667203]  [<ffffffff81042b89>] ? get_parent_ip+0x9/0x20
[   80.667207]  [<ffffffff8174b763>] ? _raw_spin_unlock+0x13/0x40
[   80.667210]  [<ffffffff810eda94>] ? alloc_fd+0xe4/0x140
[   80.667212]  [<ffffffff810d4ca6>] ? do_sys_open+0x66/0x130
[   80.667216]  [<ffffffff810026ab>] ? system_call_fastpath+0x16/0x1b
[   80.667217] Code: c0 00 00 48 c7 c2 28 00 de 81 48 c7 c6 bc 2d a0
81 e8 e0 5a ac ff 4c 89 a5 18 c0 00 00 48 89 ab c0 00 00 00 48 8b 85
18 c0 00 00 <44> 8b 00 45 85 c0 0f 84 df 00 00 00 8b 50 04 8d 4a 01 85
d2 89
[   80.667237] RIP  [<ffffffff815a0815>] hiddev_open+0xa5/0x1b0
[   80.667240]  RSP <ffff8801bffdfca8>
[   80.667241] CR2: 0000000000000000
[   80.667242] ---[ end trace 32ae772c738d6ffb ]---

Thanks

Mat
