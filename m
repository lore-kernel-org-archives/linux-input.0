From: Kim Jaejoong <climbbb.kim@gmail.com>
Subject: Re: usb/hid: slab-out-of-bounds read in usbhid_parse
Date: Tue, 19 Sep 2017 20:47:34 +0900
Message-ID: <CAL6iAaKJBVVAP81JL3Cs7Yy5np3=FpAN18L3_NQy18wRnRZpYw@mail.gmail.com>
References: <CAAeHK+zcrxkjP2=8rhzc-nV8WGb0mM9hJ5XVjW9Xexvmb91srQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a1147cb7ce27b380559896cc5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+zcrxkjP2=8rhzc-nV8WGb0mM9hJ5XVjW9Xexvmb91srQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: linux-input@vger.kernel.org

--001a1147cb7ce27b380559896cc5
Content-Type: text/plain; charset="UTF-8"

Hi, Andrey Konovalov

Thanks for the report.

2017-09-19 2:33 GMT+09:00 Andrey Konovalov <andreyknvl@google.com>:
> Hi!
>
> I've got the following crash while fuzzing the kernel with syzkaller.
>
> On commit ebb2c2437d8008d46796902ff390653822af6cc4 (Sep 18).
>
> It seems that there's no proper check on the hdesc->bNumDescriptors
> value in usbhid_parse(). it iterates over hdesc->desc and accesses
> hdesc->desc[n] fields, which might be out-of-bounds.

The bNumDescriptors in hid descriptor means 'numeric expression
specifying the number of class descriptors'.
The value bNumberDescriptors identifies the number of additional class
specific descriptors present.
(refer to the 6.1.2 HID Descriptor in hid documents :
http://www.usb.org/developers/hidpage/HID1_11.pdf)

So, it can be out-of-bounds in hdesc->desc[n] if there is an
additional class descriptor.

Does the patch below fix this?

Thanks, jaejoong
------

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 089bad8..7b6a0b6 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -974,7 +974,7 @@ static int usbhid_parse(struct hid_device *hid)
        u32 quirks = 0;
        unsigned int rsize = 0;
        char *rdesc;
-       int ret, n;
+       int ret;

        quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
                        le16_to_cpu(dev->descriptor.idProduct));
@@ -1000,9 +1000,8 @@ static int usbhid_parse(struct hid_device *hid)
        hid->version = le16_to_cpu(hdesc->bcdHID);
        hid->country = hdesc->bCountryCode;

-       for (n = 0; n < hdesc->bNumDescriptors; n++)
-               if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
-                       rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
+       if (hdesc->desc[0].bDescriptorType == HID_DT_REPORT)
+               rsize = le16_to_cpu(hdesc->desc[0].wDescriptorLength);

        if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
                dbg_hid("weird size of report descriptor (%u)\n", rsize);


>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in usbhid_parse+0x9b1/0xa20
> Read of size 1 at addr ffff88006c5f8edf by task kworker/1:2/1261
>
> CPU: 1 PID: 1261 Comm: kworker/1:2 Not tainted
> 4.14.0-rc1-42251-gebb2c2437d80 #169
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  __dump_stack lib/dump_stack.c:16
>  dump_stack+0x292/0x395 lib/dump_stack.c:52
>  print_address_description+0x78/0x280 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351
>  kasan_report+0x22f/0x340 mm/kasan/report.c:409
>  __asan_report_load1_noabort+0x19/0x20 mm/kasan/report.c:427
>  usbhid_parse+0x9b1/0xa20 drivers/hid/usbhid/hid-core.c:1004
>  hid_add_device+0x16b/0xb30 drivers/hid/hid-core.c:2944
>  usbhid_probe+0xc28/0x1100 drivers/hid/usbhid/hid-core.c:1369
>  usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
>  really_probe drivers/base/dd.c:413
>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
>  bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
>  __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
>  bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
>  device_add+0xd0b/0x1660 drivers/base/core.c:1835
>  usb_set_configuration+0x104e/0x1870 drivers/usb/core/message.c:1932
>  generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
>  usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
>  really_probe drivers/base/dd.c:413
>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
>  bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
>  __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
>  bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
>  device_add+0xd0b/0x1660 drivers/base/core.c:1835
>  usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
>  hub_port_connect drivers/usb/core/hub.c:4903
>  hub_port_connect_change drivers/usb/core/hub.c:5009
>  port_event drivers/usb/core/hub.c:5115
>  hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
>  process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
>  worker_thread+0x221/0x1850 kernel/workqueue.c:2253
>  kthread+0x3a1/0x470 kernel/kthread.c:231
>  ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431
>
> Allocated by task 1261:
>  save_stack_trace+0x1b/0x20 arch/x86/kernel/stacktrace.c:59
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  __kmalloc+0x14e/0x310 mm/slub.c:3782
>  kmalloc ./include/linux/slab.h:498
>  usb_get_configuration+0x372/0x2a60 drivers/usb/core/config.c:848
>  usb_enumerate_device drivers/usb/core/hub.c:2290
>  usb_new_device+0xaae/0x1020 drivers/usb/core/hub.c:2426
>  hub_port_connect drivers/usb/core/hub.c:4903
>  hub_port_connect_change drivers/usb/core/hub.c:5009
>  port_event drivers/usb/core/hub.c:5115
>  hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
>  process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
>  worker_thread+0x221/0x1850 kernel/workqueue.c:2253
>  kthread+0x3a1/0x470 kernel/kthread.c:231
>  ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431
>
> Freed by task 2927:
>  save_stack_trace+0x1b/0x20 arch/x86/kernel/stacktrace.c:59
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459
>  kasan_slab_free+0x72/0xc0 mm/kasan/kasan.c:524
>  slab_free_hook mm/slub.c:1390
>  slab_free_freelist_hook mm/slub.c:1412
>  slab_free mm/slub.c:2988
>  kfree+0xf6/0x2f0 mm/slub.c:3919
>  free_rb_tree_fname+0x8a/0xe0 fs/ext4/dir.c:402
>  ext4_htree_free_dir_info fs/ext4/dir.c:424
>  ext4_release_dir+0x49/0x70 fs/ext4/dir.c:622
>  __fput+0x33e/0x800 fs/file_table.c:210
>  ____fput+0x1a/0x20 fs/file_table.c:244
>  task_work_run+0x1af/0x280 kernel/task_work.c:112
>  tracehook_notify_resume ./include/linux/tracehook.h:191
>  exit_to_usermode_loop+0x1e1/0x220 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:197
>  syscall_return_slowpath+0x414/0x480 arch/x86/entry/common.c:266
>  entry_SYSCALL_64_fastpath+0xc0/0xc2 arch/x86/entry/entry_64.S:238
>
> The buggy address belongs to the object at ffff88006c5f8ea0
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 63 bytes inside of
>  64-byte region [ffff88006c5f8ea0, ffff88006c5f8ee0)
> The buggy address belongs to the page:
> page:ffffea0001b17e00 count:1 mapcount:0 mapping:          (null) index:0x0
> flags: 0x100000000000100(slab)
> raw: 0100000000000100 0000000000000000 0000000000000000 00000001002a002a
> raw: ffffea0001a83000 0000001500000015 ffff88006c403800 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff88006c5f8d80: fb fb fb fb fb fb fb fb fc fc fc fc 00 00 00 00
>  ffff88006c5f8e00: 00 fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>>ffff88006c5f8e80: fc fc fc fc 00 00 00 00 00 00 00 07 fc fc fc fc
>                                                     ^
>  ffff88006c5f8f00: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
>  ffff88006c5f8f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--001a1147cb7ce27b380559896cc5
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-HID-usbhid-out-of-bound-in-hdesc-desc.patch"
Content-Disposition: attachment;
	filename="0001-HID-usbhid-out-of-bound-in-hdesc-desc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j7rj7f7k0

RnJvbSAwNjk5ODU4ZjM4OWUwY2NiYWJhM2VlZGZjOWE2ZGI3ZDU3MGZjNzIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiamFlam9vbmcua2ltIiA8amFlam9vbmcua2ltQGxnZS5jb20+
CkRhdGU6IFR1ZSwgMTkgU2VwIDIwMTcgMjA6Mzk6MjEgKzA5MDAKU3ViamVjdDogW1BBVENIXSBI
SUQ6IHVzYmhpZDogb3V0IG9mIGJvdW5kIGluIGhkZXNjLT5kZXNjCgotLS0KIGRyaXZlcnMvaGlk
L3VzYmhpZC9oaWQtY29yZS5jIHwgNyArKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL3VzYmhpZC9o
aWQtY29yZS5jIGIvZHJpdmVycy9oaWQvdXNiaGlkL2hpZC1jb3JlLmMKaW5kZXggMDg5YmFkOC4u
N2I2YTBiNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvdXNiaGlkL2hpZC1jb3JlLmMKKysrIGIv
ZHJpdmVycy9oaWQvdXNiaGlkL2hpZC1jb3JlLmMKQEAgLTk3NCw3ICs5NzQsNyBAQCBzdGF0aWMg
aW50IHVzYmhpZF9wYXJzZShzdHJ1Y3QgaGlkX2RldmljZSAqaGlkKQogCXUzMiBxdWlya3MgPSAw
OwogCXVuc2lnbmVkIGludCByc2l6ZSA9IDA7CiAJY2hhciAqcmRlc2M7Ci0JaW50IHJldCwgbjsK
KwlpbnQgcmV0OwogCiAJcXVpcmtzID0gdXNiaGlkX2xvb2t1cF9xdWlyayhsZTE2X3RvX2NwdShk
ZXYtPmRlc2NyaXB0b3IuaWRWZW5kb3IpLAogCQkJbGUxNl90b19jcHUoZGV2LT5kZXNjcmlwdG9y
LmlkUHJvZHVjdCkpOwpAQCAtMTAwMCw5ICsxMDAwLDggQEAgc3RhdGljIGludCB1c2JoaWRfcGFy
c2Uoc3RydWN0IGhpZF9kZXZpY2UgKmhpZCkKIAloaWQtPnZlcnNpb24gPSBsZTE2X3RvX2NwdSho
ZGVzYy0+YmNkSElEKTsKIAloaWQtPmNvdW50cnkgPSBoZGVzYy0+YkNvdW50cnlDb2RlOwogCi0J
Zm9yIChuID0gMDsgbiA8IGhkZXNjLT5iTnVtRGVzY3JpcHRvcnM7IG4rKykKLQkJaWYgKGhkZXNj
LT5kZXNjW25dLmJEZXNjcmlwdG9yVHlwZSA9PSBISURfRFRfUkVQT1JUKQotCQkJcnNpemUgPSBs
ZTE2X3RvX2NwdShoZGVzYy0+ZGVzY1tuXS53RGVzY3JpcHRvckxlbmd0aCk7CisJaWYgKGhkZXNj
LT5kZXNjWzBdLmJEZXNjcmlwdG9yVHlwZSA9PSBISURfRFRfUkVQT1JUKQorCQlyc2l6ZSA9IGxl
MTZfdG9fY3B1KGhkZXNjLT5kZXNjWzBdLndEZXNjcmlwdG9yTGVuZ3RoKTsKIAogCWlmICghcnNp
emUgfHwgcnNpemUgPiBISURfTUFYX0RFU0NSSVBUT1JfU0laRSkgewogCQlkYmdfaGlkKCJ3ZWly
ZCBzaXplIG9mIHJlcG9ydCBkZXNjcmlwdG9yICgldSlcbiIsIHJzaXplKTsKLS0gCjIuNy40Cgo=
--001a1147cb7ce27b380559896cc5--
