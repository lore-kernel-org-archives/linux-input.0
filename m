From: yonghua zheng <younghua.zheng@gmail.com>
Subject: [PATCH 1/1] HID: hidraw: need to grab minors_lock in hidraw_report_event
Date: Fri, 9 Aug 2013 16:45:19 +0800
Message-ID: <CAMyfujdB0JrnNeHk3b=AqR+1nz_W=bzDJpk1=iYZBnytDk-ztw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec52d555764862004e37fcbd3
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f67.google.com ([209.85.214.67]:53888 "EHLO
	mail-bk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934320Ab3HIIpV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Aug 2013 04:45:21 -0400
Received: by mail-bk0-f67.google.com with SMTP id na10so452939bkb.6
        for <linux-input@vger.kernel.org>; Fri, 09 Aug 2013 01:45:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

--bcaec52d555764862004e37fcbd3
Content-Type: text/plain; charset=UTF-8

Hi Jiri,

We met another kernel panic issue in hidraw_report_event while using
BT remote on our Android system, the panic log below shows a unhandle
kernel paging request at virtual address 001000f0, this can happen if
hidraw_report_event access a hidraw_list node which is already removed
by list_del() in hidraw_release.

One last thing list_del() does is set entry->next = LIST_POISON1;
where LIST_POISON1 is 00100100, and this should be able to explain why
panic address is 001000f0, hidraw_report_event try to access somewhere
in struct hidraw_list:

[ 1337.530941] Unable to handle kernel paging request at virtual
address 001000f0
[ 1337.538679] pgd = a0570000
[ 1337.541877] [001000f0] *pgd=00000000
[ 1337.545884] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[ 1337.551373] Modules linked in: mbt8787 fusion(O) gal3d amp_core(O)
[ 1337.557834] CPU: 0    Tainted: G           O  (3.4.50+ #1)
[ 1337.563512] PC is at hidraw_report_event+0x38/0x98
[ 1337.568462] LR is at hidraw_report_event+0x70/0x98
[ 1337.573412] pc : [<8035286c>]    lr : [<803528a4>]    psr: a0000013
[ 1337.573416] sp : a0eede30  ip : a0eede30  fp : a0eede54
[ 1337.575086] [amp_driver] [vpp isr] MsgQ full
[ 1337.589671] r10: a0b7e4c0  r9 : a035b800  r8 : a0bb002c
[ 1337.595068] r7 : a0b7e4e4  r6 : 00000001  r5 : 0000001f  r4 : 000ffef0
[ 1337.601809] r3 : a36db808  r2 : 00000020  r1 : 0000001f  r0 : a0bb002c
[ 1337.608553] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[ 1337.615923] Control: 10c5387d  Table: 2157004a  DAC: 00000015

So the fix is to grab the minors_lock to avoid list_del in the middle
of hidraw_report_event()

>From 725ed6c402f36e34479739a8d6c68f78f2f96d31 Mon Sep 17 00:00:00 2001
From: Yonghua Zheng <younghua.zheng@gmail.com>
Date: Fri, 9 Aug 2013 15:54:59 +0800
Subject: [PATCH 1/1] HID: hidraw: need to grab minors_lock in
 hidraw_report_event

It is unsafe to call list_for_each_entry to go through each hidraw_list
node without grabing the minors_lock, because the dev->list can be
modified if other process calls hidraw_release to list_del itself from
the same &dev->list, if this happens, it can result in kernel panic
due to unable handle kernel paging request at invalid virtual address

Signed-off-by: Yonghua Zheng <younghua.zheng@gmail.com>
---
 drivers/hid/hidraw.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 6f1feb2..8b408c4 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -458,6 +458,7 @@ int hidraw_report_event(struct hid_device *hid, u8
*data, int len)
     struct hidraw_list *list;
     int ret = 0;

+    mutex_lock(&minors_lock);
     list_for_each_entry(list, &dev->list, node) {
         int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);

@@ -465,6 +466,7 @@ int hidraw_report_event(struct hid_device *hid, u8
*data, int len)
             continue;

         if (!(list->buffer[list->head].value = kmemdup(data, len,
GFP_ATOMIC))) {
+            mutex_unlock(&minors_lock);
             ret = -ENOMEM;
             break;
         }
@@ -472,6 +474,7 @@ int hidraw_report_event(struct hid_device *hid, u8
*data, int len)
         list->head = new_head;
         kill_fasync(&list->fasync, SIGIO, POLL_IN);
     }
+    mutex_unlock(&minors_lock);

     wake_up_interruptible(&dev->wait);
     return ret;
-- 
1.7.9.5

Best regards
Yonghua

--bcaec52d555764862004e37fcbd3
Content-Type: application/octet-stream;
	name="0001-HID-hidraw-need-to-grab-minors_lock-in-hidraw_report.patch"
Content-Disposition: attachment;
	filename="0001-HID-hidraw-need-to-grab-minors_lock-in-hidraw_report.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hk54gsr60

RnJvbSA3MjVlZDZjNDAyZjM2ZTM0NDc5NzM5YThkNmM2OGY3OGYyZjk2ZDMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25naHVhIFpoZW5nIDx5b3VuZ2h1YS56aGVuZ0BnbWFpbC5j
b20+CkRhdGU6IEZyaSwgOSBBdWcgMjAxMyAxNTo1NDo1OSArMDgwMApTdWJqZWN0OiBbUEFUQ0gg
MS8xXSBISUQ6IGhpZHJhdzogbmVlZCB0byBncmFiIG1pbm9yc19sb2NrIGluCiBoaWRyYXdfcmVw
b3J0X2V2ZW50CgpJdCBpcyB1bnNhZmUgdG8gY2FsbCBsaXN0X2Zvcl9lYWNoX2VudHJ5IHRvIGdv
IHRocm91Z2ggZWFjaCBoaWRyYXdfbGlzdApub2RlIHdpdGhvdXQgZ3JhYmluZyB0aGUgbWlub3Jz
X2xvY2ssIGJlY2F1c2UgdGhlIGRldi0+bGlzdCBjYW4gYmUKbW9kaWZpZWQgaWYgb3RoZXIgcHJv
Y2VzcyBjYWxscyBoaWRyYXdfcmVsZWFzZSB0byBsaXN0X2RlbCBpdHNlbGYgZnJvbQp0aGUgc2Ft
ZSAmZGV2LT5saXN0LCBpZiB0aGlzIGhhcHBlbnMsIGl0IGNhbiByZXN1bHQgaW4ga2VybmVsIHBh
bmljCmR1ZSB0byB1bmFibGUgaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCBpbnZhbGlk
IHZpcnR1YWwgYWRkcmVzcwoKU2lnbmVkLW9mZi1ieTogWW9uZ2h1YSBaaGVuZyA8eW91bmdodWEu
emhlbmdAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvaGlkL2hpZHJhdy5jIHwgICAgMyArKysKIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9o
aWRyYXcuYyBiL2RyaXZlcnMvaGlkL2hpZHJhdy5jCmluZGV4IDZmMWZlYjIuLjhiNDA4YzQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvaGlkL2hpZHJhdy5jCisrKyBiL2RyaXZlcnMvaGlkL2hpZHJhdy5j
CkBAIC00NTgsNiArNDU4LDcgQEAgaW50IGhpZHJhd19yZXBvcnRfZXZlbnQoc3RydWN0IGhpZF9k
ZXZpY2UgKmhpZCwgdTggKmRhdGEsIGludCBsZW4pCiAJc3RydWN0IGhpZHJhd19saXN0ICpsaXN0
OwogCWludCByZXQgPSAwOwogCisJbXV0ZXhfbG9jaygmbWlub3JzX2xvY2spOwogCWxpc3RfZm9y
X2VhY2hfZW50cnkobGlzdCwgJmRldi0+bGlzdCwgbm9kZSkgewogCQlpbnQgbmV3X2hlYWQgPSAo
bGlzdC0+aGVhZCArIDEpICYgKEhJRFJBV19CVUZGRVJfU0laRSAtIDEpOwogCkBAIC00NjUsNiAr
NDY2LDcgQEAgaW50IGhpZHJhd19yZXBvcnRfZXZlbnQoc3RydWN0IGhpZF9kZXZpY2UgKmhpZCwg
dTggKmRhdGEsIGludCBsZW4pCiAJCQljb250aW51ZTsKIAogCQlpZiAoIShsaXN0LT5idWZmZXJb
bGlzdC0+aGVhZF0udmFsdWUgPSBrbWVtZHVwKGRhdGEsIGxlbiwgR0ZQX0FUT01JQykpKSB7CisJ
CQltdXRleF91bmxvY2soJm1pbm9yc19sb2NrKTsKIAkJCXJldCA9IC1FTk9NRU07CiAJCQlicmVh
azsKIAkJfQpAQCAtNDcyLDYgKzQ3NCw3IEBAIGludCBoaWRyYXdfcmVwb3J0X2V2ZW50KHN0cnVj
dCBoaWRfZGV2aWNlICpoaWQsIHU4ICpkYXRhLCBpbnQgbGVuKQogCQlsaXN0LT5oZWFkID0gbmV3
X2hlYWQ7CiAJCWtpbGxfZmFzeW5jKCZsaXN0LT5mYXN5bmMsIFNJR0lPLCBQT0xMX0lOKTsKIAl9
CisJbXV0ZXhfdW5sb2NrKCZtaW5vcnNfbG9jayk7CiAKIAl3YWtlX3VwX2ludGVycnVwdGlibGUo
JmRldi0+d2FpdCk7CiAJcmV0dXJuIHJldDsKLS0gCjEuNy45LjUKCg==
--bcaec52d555764862004e37fcbd3--
