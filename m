From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: WARNING: ODEBUG bug in usbhid_disconnect (2)
Date: Thu, 5 Sep 2019 13:08:28 +0200
Message-ID: <CAAeHK+xJrv1hCbO5qOGTBu=c8STo+-obatOGZ4cHkbuhqmEvrg@mail.gmail.com>
References: <0000000000001b41900591a4f149@google.com> <CAAeHK+zdtLm6CZ9=vJDF4d52a=vebPj10gpFkuETcxMjvEwsNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000000d7f580591cc58f7"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+zdtLm6CZ9=vJDF4d52a=vebPj10gpFkuETcxMjvEwsNg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roderick.Colenbrander@sony.com
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, syzbot <syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

--0000000000000d7f580591cc58f7
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 3, 2019 at 2:17 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Tue, Sep 3, 2019 at 2:08 PM syzbot
> <syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=173983ac600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=14b53bfeb17f2b210eb7
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d36aca600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178e208e600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > ODEBUG: free active (active state 0) object type: timer_list hint:
> > hid_retry_timeout+0x0/0xd0 drivers/hid/usbhid/hid-core.c:712
> > WARNING: CPU: 1 PID: 17 at lib/debugobjects.c:481
> > debug_print_object+0x160/0x250 lib/debugobjects.c:481
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.3.0-rc5+ #28
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   panic+0x2a3/0x6da kernel/panic.c:219
> >   __warn.cold+0x20/0x4a kernel/panic.c:576
> >   report_bug+0x262/0x2a0 lib/bug.c:186
> >   fixup_bug arch/x86/kernel/traps.c:179 [inline]
> >   fixup_bug arch/x86/kernel/traps.c:174 [inline]
> >   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
> >   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
> >   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> > RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:481
> > Code: dd 80 ef da 85 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48
> > 8b 14 dd 80 ef da 85 48 c7 c7 c0 e4 da 85 e8 e5 dd 31 ff <0f> 0b 83 05 4b
> > 0f a8 05 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
> > RSP: 0018:ffff8881da24f718 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff81288cfd RDI: ffffed103b449ed5
> > RBP: 0000000000000001 R08: ffff8881da233000 R09: fffffbfff11ad79a
> > R10: fffffbfff11ad799 R11: ffffffff88d6bccf R12: ffffffff86d0dc60
> > R13: ffffffff812e7b70 R14: ffff8881c9d5a8c8 R15: ffff8881cf8943f0
> >   __debug_check_no_obj_freed lib/debugobjects.c:963 [inline]
> >   debug_check_no_obj_freed+0x2df/0x443 lib/debugobjects.c:994
> >   free_pages_prepare mm/page_alloc.c:1174 [inline]
> >   __free_pages_ok+0x222/0x1d70 mm/page_alloc.c:1420
> >   usbhid_disconnect+0xab/0xd0 drivers/hid/usbhid/hid-core.c:1414
> >   usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
> >   __device_release_driver drivers/base/dd.c:1134 [inline]
> >   device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
> >   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
> >   device_del+0x420/0xb10 drivers/base/core.c:2339
> >   usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
> >   usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
> >   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >   process_scheduled_works kernel/workqueue.c:2331 [inline]
> >   worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
> >   kthread+0x318/0x420 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> Roderick, FYI, this particular repro is triggering that issue in the
> Sony driver AFAICS.

Let's try Roderick's patch from [1] here:

#syz test: https://github.com/google/kasan.git eea39f24

[1] https://patchwork.kernel.org/patch/11131703/

--0000000000000d7f580591cc58f7
Content-Type: text/x-patch; charset="US-ASCII"; name="hid-sony.patch"
Content-Disposition: attachment; filename="hid-sony.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k06l7hox0>
X-Attachment-Id: f_k06l7hox0

RnJvbTogUm9kZXJpY2sgQ29sZW5icmFuZGVyIDxyb2Rlcmljay5jb2xlbmJyYW5kZXJAc29ueS5j
b20+CgpUaGUgc29ueSBkcml2ZXIgaXMgbm90IHByb3Blcmx5IGNsZWFuaW5nIHVwIGZyb20gcG90
ZW50aWFsIGZhaWx1cmVzIGluCnNvbnlfaW5wdXRfY29uZmlndXJlZC4gQ3VycmVudGx5IGl0IGNh
bGxzIGhpZF9od19zdG9wLCB3aGlsZSBoaWRfY29ubmVjdAppcyBzdGlsbCBydW5uaW5nLiBUaGlz
IGlzIG5vdCBhIGdvb2QgaWRlYSwgaW5zdGVhZCBoaWRfaHdfc3RvcCBzaG91bGQKYmUgbW92ZWQg
dG8gc29ueV9wcm9iZS4gU2ltaWxhciBjaGFuZ2VzIHdlcmUgcmVjZW50bHkgbWFkZSB0byBMb2dp
dGVjaApkcml2ZXJzLCB3aGljaCB3ZXJlIGFsc28gZG9pbmcgaW1wcm9wZXIgY2xlYW51cC4KClNp
Z25lZC1vZmYtYnk6IFJvZGVyaWNrIENvbGVuYnJhbmRlciA8cm9kZXJpY2suY29sZW5icmFuZGVy
QHNvbnkuY29tPgpDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwotLS0KIGRyaXZlcnMvaGlkL2hp
ZC1zb255LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtc29ueS5jIGIvZHJpdmVycy9oaWQv
aGlkLXNvbnkuYwppbmRleCAzMWYxMDIzMjE0ZDMuLjA5ZjJjNjE3YjA5ZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9oaWQvaGlkLXNvbnkuYworKysgYi9kcml2ZXJzL2hpZC9oaWQtc29ueS5jCkBAIC0y
ODA2LDcgKzI4MDYsNiBAQCBzdGF0aWMgaW50IHNvbnlfaW5wdXRfY29uZmlndXJlZChzdHJ1Y3Qg
aGlkX2RldmljZSAqaGRldiwKIAlzb255X2NhbmNlbF93b3JrX3N5bmMoc2MpOwogCXNvbnlfcmVt
b3ZlX2Rldl9saXN0KHNjKTsKIAlzb255X3JlbGVhc2VfZGV2aWNlX2lkKHNjKTsKLQloaWRfaHdf
c3RvcChoZGV2KTsKIAlyZXR1cm4gcmV0OwogfQogCkBAIC0yODY4LDYgKzI4NjcsNyBAQCBzdGF0
aWMgaW50IHNvbnlfcHJvYmUoc3RydWN0IGhpZF9kZXZpY2UgKmhkZXYsIGNvbnN0IHN0cnVjdCBo
aWRfZGV2aWNlX2lkICppZCkKIAkgKi8KIAlpZiAoIShoZGV2LT5jbGFpbWVkICYgSElEX0NMQUlN
RURfSU5QVVQpKSB7CiAJCWhpZF9lcnIoaGRldiwgImZhaWxlZCB0byBjbGFpbSBpbnB1dFxuIik7
CisJCWhpZF9od19zdG9wKGhkZXYpOwogCQlyZXR1cm4gLUVOT0RFVjsKIAl9CiAKLS0gCjIuMjEu
MAo=
--0000000000000d7f580591cc58f7--
