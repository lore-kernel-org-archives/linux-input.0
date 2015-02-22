From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 3.19: Sony playstation controller causes kernel oops
Date: Sun, 22 Feb 2015 22:50:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502222247450.19920@pobox.suse.cz>
References: <20150222213513.GA15224@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150222213513.GA15224@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, rydberg@bitmath.org, Frank Praznik <frank.praznik@oh.rr.com>, David Herrmann <dh.herrmann@gmail.com>
List-Id: linux-input@vger.kernel.org

[ some CCs added and full dmesg kept for reference ]

On Sun, 22 Feb 2015, Pavel Machek wrote:

> Hi!
> 
> I plugged in part of PS move to the PC, to let it charge. Got: full
> dmesg in attachment. I believe I charged it in PC before, but it may
> be year ago or more.
>
> Ideas?

Ok, this is embarassing. I guess the patch below fixes it, right? (the 
spinlock got introduced in d2d782fccee, so I guess you didn't have it a 
year ago)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 31e9d25..3756a62 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2140,6 +2140,7 @@ static int __init sony_init(void)
 {
 	dbg_hid("Sony:%s\n", __func__);
 
+	spin_lock_init(&sony_dev_list_lock);
 	return hid_register_driver(&sony_driver);
 }
 

> [124225.084151] usb 2-1: USB disconnect, device number 2
> [124227.240047] usb 2-1: new full-speed USB device number 3 using uhci_hcd
> [124227.519329] usb 2-1: New USB device found, idVendor=054c, idProduct=042f
> [124227.519335] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [124227.519338] usb 2-1: Product: Navigation Controller
> [124227.519341] usb 2-1: Manufacturer: Sony
> [124227.599936] input: Sony Navigation Controller as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/0003:054C:042F.0005/input/input50
> [124227.657352] sony 0003:054C:042F.0005: input,hiddev0,hidraw3: USB HID v1.11 Joystick [Sony Navigation Controller] on usb-0000:00:1d.0-1/input0
> [124227.692076] BUG: spinlock bad magic on CPU#0, kworker/0:0/15184
> [124227.692088]  lock: sony_dev_list_lock+0x0/0x38, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [124227.692092] CPU: 0 PID: 15184 Comm: kworker/0:0 Tainted: G        W      3.19.0 #17
> [124227.692094] Hardware name:                  /DG41MJ, BIOS MJG4110H.86A.0006.2009.1223.1155 12/23/2009
> [124227.692100] Workqueue: usb_hub_wq hub_event
> [124227.692103]  ffffffff85b83800 ffff880001153468 ffffffff84949b24 0000000000000007
> [124227.692109]  0000000000000000 ffff880001153488 ffffffff84081330 ffffffff85b83800
> [124227.692114]  ffffffff84d64cc0 ffff8800011534a8 ffffffff840813b1 ffffffff85b83800
> [124227.692119] Call Trace:
> [124227.692125]  [<ffffffff84949b24>] dump_stack+0x45/0x57
> [124227.692131]  [<ffffffff84081330>] spin_dump+0x80/0xe0
> [124227.692135]  [<ffffffff840813b1>] spin_bug+0x21/0x30
> [124227.692139]  [<ffffffff8408154c>] do_raw_spin_lock+0x12c/0x190
> [124227.692142]  [<ffffffff8495218a>] _raw_spin_lock_irqsave+0x3a/0x50
> [124227.692147]  [<ffffffff846c9f76>] ? sony_probe+0x556/0xd60
> [124227.692151]  [<ffffffff846c9f76>] sony_probe+0x556/0xd60
> [124227.692156]  [<ffffffff846be02d>] ? hid_match_id+0x2d/0x50
> [124227.692160]  [<ffffffff846bea24>] hid_device_probe+0xd4/0x150
> [124227.692165]  [<ffffffff844b7320>] ? driver_probe_device+0x3d0/0x3d0
> [124227.692169]  [<ffffffff844b6fdb>] driver_probe_device+0x8b/0x3d0
> [124227.692173]  [<ffffffff844b7320>] ? driver_probe_device+0x3d0/0x3d0
> [124227.692176]  [<ffffffff844b735b>] __device_attach+0x3b/0x40
> [124227.692180]  [<ffffffff844b4f93>] bus_for_each_drv+0x63/0xa0
> [124227.692183]  [<ffffffff844b6ee0>] device_attach+0x90/0xb0
> [124227.692187]  [<ffffffff844b6300>] bus_probe_device+0xb0/0xe0
> [124227.692191]  [<ffffffff844b402d>] device_add+0x48d/0x660
> [124227.692195]  [<ffffffff846be6d1>] hid_add_device+0xc1/0x290
> [124227.692199]  [<ffffffff84081221>] ? __raw_spin_lock_init+0x31/0x60
> [124227.692203]  [<ffffffff846d4657>] usbhid_probe+0x327/0x480
> [124227.692208]  [<ffffffff845be566>] usb_probe_interface+0x1d6/0x350
> [124227.692211]  [<ffffffff844b7320>] ? driver_probe_device+0x3d0/0x3d0
> [124227.692215]  [<ffffffff844b6fdb>] driver_probe_device+0x8b/0x3d0
> [124227.692219]  [<ffffffff844b7320>] ? driver_probe_device+0x3d0/0x3d0
> [124227.692222]  [<ffffffff844b735b>] __device_attach+0x3b/0x40
> [124227.692226]  [<ffffffff844b4f93>] bus_for_each_drv+0x63/0xa0
> [124227.692229]  [<ffffffff844b6ee0>] device_attach+0x90/0xb0
> [124227.692233]  [<ffffffff844b6300>] bus_probe_device+0xb0/0xe0
> [124227.692236]  [<ffffffff844b402d>] device_add+0x48d/0x660
> [124227.692240]  [<ffffffff845bc363>] usb_set_configuration+0x563/0x960
> [124227.692245]  [<ffffffff8417cf82>] ? kernfs_add_one+0xe2/0x170
> [124227.692249]  [<ffffffff844b7320>] ? driver_probe_device+0x3d0/0x3d0
> [124227.692254]  [<ffffffff845c6fa9>] generic_probe+0x29/0x90
> [124227.692258]  [<ffffffff845be33d>] usb_probe_device+0x2d/0x80
> [124227.692262]  [<ffffffff844b6fdb>] driver_probe_device+0x8b/0x3d0
> [124227.692265]  [<ffffffff844b7320>] ? driver_probe_device+0x3d0/0x3d0
> [124227.692269]  [<ffffffff844b735b>] __device_attach+0x3b/0x40
> [124227.692272]  [<ffffffff844b4f93>] bus_for_each_drv+0x63/0xa0
> [124227.692276]  [<ffffffff844b6ee0>] device_attach+0x90/0xb0
> [124227.692279]  [<ffffffff844b6300>] bus_probe_device+0xb0/0xe0
> [124227.692283]  [<ffffffff844b402d>] device_add+0x48d/0x660
> [124227.692286]  [<ffffffff845b1770>] usb_new_device+0x2b0/0x500
> [124227.692290]  [<ffffffff845b3286>] hub_event+0x886/0x1620
> [124227.692295]  [<ffffffff8405662b>] process_one_work+0x1ab/0x430
> [124227.692299]  [<ffffffff840565c6>] ? process_one_work+0x146/0x430
> [124227.692303]  [<ffffffff84056e4b>] worker_thread+0x6b/0x480
> [124227.692307]  [<ffffffff84056de0>] ? cancel_delayed_work+0x80/0x80
> [124227.692311]  [<ffffffff8405bfb0>] kthread+0x100/0x120
> [124227.692315]  [<ffffffff8405beb0>] ? kthread_create_on_node+0x230/0x230
> [124227.692319]  [<ffffffff84952bec>] ret_from_fork+0x7c/0xb0
> [124227.692323]  [<ffffffff8405beb0>] ? kthread_create_on_node+0x230/0x230

-- 
Jiri Kosina
SUSE Labs
