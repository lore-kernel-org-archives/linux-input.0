From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and
 UI_ABS_SETUP ioctl
Date: Sun, 25 Oct 2015 10:39:10 +0100
Message-ID: <CANq1E4TLDMjbfMY-rOM7M8VE_EKejk5DmbPF_BgwNtRwbJV-Aw@mail.gmail.com>
References: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
	<20151024225341.GA17120@dtor-pixel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f502ebaf3c23a0522ea9d4e
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35589 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbJYJjM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Oct 2015 05:39:12 -0400
In-Reply-To: <20151024225341.GA17120@dtor-pixel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

--e89a8f502ebaf3c23a0522ea9d4e
Content-Type: text/plain; charset=UTF-8

Hi

On Sun, Oct 25, 2015 at 12:53 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Benjamin,
>
> On Tue, Aug 25, 2015 at 11:12:59AM -0400, Benjamin Tissoires wrote:
>> +static int uinput_abs_setup(struct uinput_device *udev,
>> +                         struct uinput_setup __user *arg, size_t size)
>> +{
>> +     struct uinput_abs_setup setup = {};
>> +     struct input_dev *dev;
>> +
>> +     if (size > sizeof(setup))
>> +             return -E2BIG;
>> +     if (udev->state == UIST_CREATED)
>> +             return -EINVAL;
>> +     if (copy_from_user(&setup, arg, size))
>> +             return -EFAULT;
>> +     if (setup.code > ABS_MAX)
>> +             return -ERANGE;
>> +
>> +     dev = udev->dev;
>> +
>> +     input_alloc_absinfo(dev);
>> +     if (!dev->absinfo)
>> +             return -ENOMEM;
>> +
>> +     set_bit(setup.code, dev->absbit);
>> +     dev->absinfo[setup.code] = setup.absinfo;
>> +
>> +     /*
>> +      * We restore the state to UIST_NEW_DEVICE because the user has to call
>> +      * UI_DEV_SETUP in the last place before UI_DEV_CREATE to check the
>> +      * validity of the absbits.
>> +      */
>
> Do we have to be this strict? It seems to me that with the new IOCTLs
> you naturally want to use the new ioctl to setup the device, then adjust
> various axes and bits and then validate everything.

Indeed, we now force the order to be abs-setup first, then
device-setup as last step. Appended is a follow-up patch to cleanup
ABS handling in uinput. It is untested. Benjamin, care to give it a
spin?

Thanks
David

----
>From 2568f83bcc5c4b8aeb149be2c5fc5a743812f0fe Mon Sep 17 00:00:00 2001
From: David Herrmann <dh.herrmann@gmail.com>
Date: Sun, 25 Oct 2015 10:34:13 +0100
Subject: [PATCH] Input: uinput - rework ABS validation

Rework the uinput ABS validation to check passed absinfo data
immediately, but do ABS initialization as last step in UI_DEV_CREATE. The
behavior observed by user-space is not changed, as ABS initialization was
never checked for errors.

With this in place, the order of device-initialization and
abs-configuration is no longer fixed. User-space can initialize the
device and afterwards set absinfo just fine.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/input/misc/uinput.c | 89 +++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index baac903..1d93037 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -256,13 +256,22 @@ static void uinput_destroy_device(...)
 static int uinput_create_device(struct uinput_device *udev)
 {
  struct input_dev *dev = udev->dev;
- int error;
+ int error, nslot;

  if (udev->state != UIST_SETUP_COMPLETE) {
  printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
  return -EINVAL;
  }

+ if (test_bit(ABS_MT_SLOT, dev->absbit)) {
+ nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
+ error = input_mt_init_slots(dev, nslot, 0);
+ if (error)
+ goto fail1;
+ } else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
+ input_set_events_per_packet(dev, 60);
+ }
+
  if (udev->ff_effects_max) {
  error = input_ff_create(dev, udev->ff_effects_max);
  if (error)
@@ -308,10 +317,35 @@ static int uinput_open(...)
  return 0;
 }

+static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
+   const struct input_absinfo *abs)
+{
+ int min, max;
+
+ min = abs->minimum;
+ max = abs->maximum;
+
+ if ((min != 0 || max != 0) && max <= min) {
+ printk(KERN_DEBUG
+       "%s: invalid abs[%02x] min:%d max:%d\n",
+       UINPUT_NAME, code, min, max);
+ return -EINVAL;
+ }
+
+ if (abs->flat > max - min) {
+ printk(KERN_DEBUG
+       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
+       UINPUT_NAME, code, abs->flat, min, max);
+ return -EINVAL;
+ }
+
+ return 0;
+}
+
 static int uinput_validate_absbits(struct input_dev *dev)
 {
  unsigned int cnt;
- int nslot;
+ int error;

  if (!test_bit(EV_ABS, dev->evbit))
  return 0;
@@ -321,38 +355,12 @@ static int uinput_validate_absbits(struct input_dev *dev)
  */

  for_each_set_bit(cnt, dev->absbit, ABS_CNT) {
- int min, max;
-
- min = input_abs_get_min(dev, cnt);
- max = input_abs_get_max(dev, cnt);
-
- if ((min != 0 || max != 0) && max <= min) {
- printk(KERN_DEBUG
- "%s: invalid abs[%02x] min:%d max:%d\n",
- UINPUT_NAME, cnt,
- input_abs_get_min(dev, cnt),
- input_abs_get_max(dev, cnt));
+ if (!dev->absinfo)
  return -EINVAL;
- }
-
- if (input_abs_get_flat(dev, cnt) >
-    input_abs_get_max(dev, cnt) - input_abs_get_min(dev, cnt)) {
- printk(KERN_DEBUG
- "%s: abs_flat #%02x out of range: %d "
- "(min:%d/max:%d)\n",
- UINPUT_NAME, cnt,
- input_abs_get_flat(dev, cnt),
- input_abs_get_min(dev, cnt),
- input_abs_get_max(dev, cnt));
- return -EINVAL;
- }
- }

- if (test_bit(ABS_MT_SLOT, dev->absbit)) {
- nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
- input_mt_init_slots(dev, nslot, 0);
- } else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
- input_set_events_per_packet(dev, 60);
+ error = uinput_validate_absinfo(dev, cnt, &dev->absinfo[cnt]);
+ if (error)
+ return error;
  }

  return 0;
@@ -375,7 +383,6 @@ static int uinput_dev_setup(struct uinput_device *udev,
 {
  struct uinput_setup setup;
  struct input_dev *dev;
- int retval;

  if (udev->state == UIST_CREATED)
  return -EINVAL;
@@ -393,10 +400,6 @@ static int uinput_dev_setup(struct uinput_device *udev,
  if (!dev->name)
  return -ENOMEM;

- retval = uinput_validate_absbits(dev);
- if (retval < 0)
- return retval;
-
  udev->state = UIST_SETUP_COMPLETE;
  return 0;
 }
@@ -406,6 +409,7 @@ static int uinput_abs_setup(struct uinput_device *udev,
 {
  struct uinput_abs_setup setup = {};
  struct input_dev *dev;
+ int error;

  if (size > sizeof(setup))
  return -E2BIG;
@@ -418,19 +422,16 @@ static int uinput_abs_setup(struct uinput_device *udev,

  dev = udev->dev;

+ error = uinput_validate_absinfo(dev, setup.code, &setup.absinfo);
+ if (error)
+ return error;
+
  input_alloc_absinfo(dev);
  if (!dev->absinfo)
  return -ENOMEM;

  set_bit(setup.code, dev->absbit);
  dev->absinfo[setup.code] = setup.absinfo;
-
- /*
- * We restore the state to UIST_NEW_DEVICE because the user has to call
- * UI_DEV_SETUP in the last place before UI_DEV_CREATE to check the
- * validity of the absbits.
- */
- udev->state = UIST_NEW_DEVICE;
  return 0;
 }

-- 
2.6.1

--e89a8f502ebaf3c23a0522ea9d4e
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Input-uinput-rework-ABS-validation.patch"
Content-Disposition: attachment;
	filename="0001-Input-uinput-rework-ABS-validation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ig6bpj7f0

RnJvbSAyNTY4ZjgzYmNjNWM0YjhhZWIxNDliZTJjNWZjNWE3NDM4MTJmMGZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIZXJybWFubiA8ZGguaGVycm1hbm5AZ21haWwuY29t
PgpEYXRlOiBTdW4sIDI1IE9jdCAyMDE1IDEwOjM0OjEzICswMTAwClN1YmplY3Q6IFtQQVRDSF0g
SW5wdXQ6IHVpbnB1dCAtIHJld29yayBBQlMgdmFsaWRhdGlvbgoKUmV3b3JrIHRoZSB1aW5wdXQg
QUJTIHZhbGlkYXRpb24gdG8gY2hlY2sgcGFzc2VkIGFic2luZm8gZGF0YQppbW1lZGlhdGVseSwg
YnV0IGRvIEFCUyBpbml0aWFsaXphdGlvbiBhcyBsYXN0IHN0ZXAgaW4gVUlfREVWX0NSRUFURS4g
VGhlCmJlaGF2aW9yIG9ic2VydmVkIGJ5IHVzZXItc3BhY2UgaXMgbm90IGNoYW5nZWQsIGFzIEFC
UyBpbml0aWFsaXphdGlvbiB3YXMKbmV2ZXIgY2hlY2tlZCBmb3IgZXJyb3JzLgoKV2l0aCB0aGlz
IGluIHBsYWNlLCB0aGUgb3JkZXIgb2YgZGV2aWNlLWluaXRpYWxpemF0aW9uIGFuZAphYnMtY29u
ZmlndXJhdGlvbiBpcyBubyBsb25nZXIgZml4ZWQuIFVzZXItc3BhY2UgY2FuIGluaXRpYWxpemUg
dGhlCmRldmljZSBhbmQgYWZ0ZXJ3YXJkcyBzZXQgYWJzaW5mbyBqdXN0IGZpbmUuCgpTaWduZWQt
b2ZmLWJ5OiBEYXZpZCBIZXJybWFubiA8ZGguaGVycm1hbm5AZ21haWwuY29tPgotLS0KIGRyaXZl
cnMvaW5wdXQvbWlzYy91aW5wdXQuYyB8IDg5ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDQ0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvbWlzYy91aW5wdXQuYyBiL2Ry
aXZlcnMvaW5wdXQvbWlzYy91aW5wdXQuYwppbmRleCBiYWFjOTAzLi4xZDkzMDM3IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2lucHV0L21pc2MvdWlucHV0LmMKKysrIGIvZHJpdmVycy9pbnB1dC9taXNj
L3VpbnB1dC5jCkBAIC0yNTYsMTMgKzI1NiwyMiBAQCBzdGF0aWMgdm9pZCB1aW5wdXRfZGVzdHJv
eV9kZXZpY2UoLi4uKQogc3RhdGljIGludCB1aW5wdXRfY3JlYXRlX2RldmljZShzdHJ1Y3QgdWlu
cHV0X2RldmljZSAqdWRldikKIHsKIAlzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYgPSB1ZGV2LT5kZXY7
Ci0JaW50IGVycm9yOworCWludCBlcnJvciwgbnNsb3Q7CiAKIAlpZiAodWRldi0+c3RhdGUgIT0g
VUlTVF9TRVRVUF9DT01QTEVURSkgewogCQlwcmludGsoS0VSTl9ERUJVRyAiJXM6IHdyaXRlIGRl
dmljZSBpbmZvIGZpcnN0XG4iLCBVSU5QVVRfTkFNRSk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0K
IAorCWlmICh0ZXN0X2JpdChBQlNfTVRfU0xPVCwgZGV2LT5hYnNiaXQpKSB7CisJCW5zbG90ID0g
aW5wdXRfYWJzX2dldF9tYXgoZGV2LCBBQlNfTVRfU0xPVCkgKyAxOworCQllcnJvciA9IGlucHV0
X210X2luaXRfc2xvdHMoZGV2LCBuc2xvdCwgMCk7CisJCWlmIChlcnJvcikKKwkJCWdvdG8gZmFp
bDE7CisJfSBlbHNlIGlmICh0ZXN0X2JpdChBQlNfTVRfUE9TSVRJT05fWCwgZGV2LT5hYnNiaXQp
KSB7CisJCWlucHV0X3NldF9ldmVudHNfcGVyX3BhY2tldChkZXYsIDYwKTsKKwl9CisKIAlpZiAo
dWRldi0+ZmZfZWZmZWN0c19tYXgpIHsKIAkJZXJyb3IgPSBpbnB1dF9mZl9jcmVhdGUoZGV2LCB1
ZGV2LT5mZl9lZmZlY3RzX21heCk7CiAJCWlmIChlcnJvcikKQEAgLTMwOCwxMCArMzE3LDM1IEBA
IHN0YXRpYyBpbnQgdWlucHV0X29wZW4oLi4uKQogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50
IHVpbnB1dF92YWxpZGF0ZV9hYnNpbmZvKHN0cnVjdCBpbnB1dF9kZXYgKmRldiwgdW5zaWduZWQg
aW50IGNvZGUsCisJCQkJICAgY29uc3Qgc3RydWN0IGlucHV0X2Fic2luZm8gKmFicykKK3sKKwlp
bnQgbWluLCBtYXg7CisKKwltaW4gPSBhYnMtPm1pbmltdW07CisJbWF4ID0gYWJzLT5tYXhpbXVt
OworCisJaWYgKChtaW4gIT0gMCB8fCBtYXggIT0gMCkgJiYgbWF4IDw9IG1pbikgeworCQlwcmlu
dGsoS0VSTl9ERUJVRworCQkgICAgICAgIiVzOiBpbnZhbGlkIGFic1slMDJ4XSBtaW46JWQgbWF4
OiVkXG4iLAorCQkgICAgICAgVUlOUFVUX05BTUUsIGNvZGUsIG1pbiwgbWF4KTsKKwkJcmV0dXJu
IC1FSU5WQUw7CisJfQorCisJaWYgKGFicy0+ZmxhdCA+IG1heCAtIG1pbikgeworCQlwcmludGso
S0VSTl9ERUJVRworCQkgICAgICAgIiVzOiBhYnNfZmxhdCAjJTAyeCBvdXQgb2YgcmFuZ2U6ICVk
IChtaW46JWQvbWF4OiVkKVxuIiwKKwkJICAgICAgIFVJTlBVVF9OQU1FLCBjb2RlLCBhYnMtPmZs
YXQsIG1pbiwgbWF4KTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJcmV0dXJuIDA7Cit9CisK
IHN0YXRpYyBpbnQgdWlucHV0X3ZhbGlkYXRlX2Fic2JpdHMoc3RydWN0IGlucHV0X2RldiAqZGV2
KQogewogCXVuc2lnbmVkIGludCBjbnQ7Ci0JaW50IG5zbG90OworCWludCBlcnJvcjsKIAogCWlm
ICghdGVzdF9iaXQoRVZfQUJTLCBkZXYtPmV2Yml0KSkKIAkJcmV0dXJuIDA7CkBAIC0zMjEsMzgg
KzM1NSwxMiBAQCBzdGF0aWMgaW50IHVpbnB1dF92YWxpZGF0ZV9hYnNiaXRzKHN0cnVjdCBpbnB1
dF9kZXYgKmRldikKIAkgKi8KIAogCWZvcl9lYWNoX3NldF9iaXQoY250LCBkZXYtPmFic2JpdCwg
QUJTX0NOVCkgewotCQlpbnQgbWluLCBtYXg7Ci0KLQkJbWluID0gaW5wdXRfYWJzX2dldF9taW4o
ZGV2LCBjbnQpOwotCQltYXggPSBpbnB1dF9hYnNfZ2V0X21heChkZXYsIGNudCk7Ci0KLQkJaWYg
KChtaW4gIT0gMCB8fCBtYXggIT0gMCkgJiYgbWF4IDw9IG1pbikgewotCQkJcHJpbnRrKEtFUk5f
REVCVUcKLQkJCQkiJXM6IGludmFsaWQgYWJzWyUwMnhdIG1pbjolZCBtYXg6JWRcbiIsCi0JCQkJ
VUlOUFVUX05BTUUsIGNudCwKLQkJCQlpbnB1dF9hYnNfZ2V0X21pbihkZXYsIGNudCksCi0JCQkJ
aW5wdXRfYWJzX2dldF9tYXgoZGV2LCBjbnQpKTsKKwkJaWYgKCFkZXYtPmFic2luZm8pCiAJCQly
ZXR1cm4gLUVJTlZBTDsKLQkJfQotCi0JCWlmIChpbnB1dF9hYnNfZ2V0X2ZsYXQoZGV2LCBjbnQp
ID4KLQkJICAgIGlucHV0X2Fic19nZXRfbWF4KGRldiwgY250KSAtIGlucHV0X2Fic19nZXRfbWlu
KGRldiwgY250KSkgewotCQkJcHJpbnRrKEtFUk5fREVCVUcKLQkJCQkiJXM6IGFic19mbGF0ICMl
MDJ4IG91dCBvZiByYW5nZTogJWQgIgotCQkJCSIobWluOiVkL21heDolZClcbiIsCi0JCQkJVUlO
UFVUX05BTUUsIGNudCwKLQkJCQlpbnB1dF9hYnNfZ2V0X2ZsYXQoZGV2LCBjbnQpLAotCQkJCWlu
cHV0X2Fic19nZXRfbWluKGRldiwgY250KSwKLQkJCQlpbnB1dF9hYnNfZ2V0X21heChkZXYsIGNu
dCkpOwotCQkJcmV0dXJuIC1FSU5WQUw7Ci0JCX0KLQl9CiAKLQlpZiAodGVzdF9iaXQoQUJTX01U
X1NMT1QsIGRldi0+YWJzYml0KSkgewotCQluc2xvdCA9IGlucHV0X2Fic19nZXRfbWF4KGRldiwg
QUJTX01UX1NMT1QpICsgMTsKLQkJaW5wdXRfbXRfaW5pdF9zbG90cyhkZXYsIG5zbG90LCAwKTsK
LQl9IGVsc2UgaWYgKHRlc3RfYml0KEFCU19NVF9QT1NJVElPTl9YLCBkZXYtPmFic2JpdCkpIHsK
LQkJaW5wdXRfc2V0X2V2ZW50c19wZXJfcGFja2V0KGRldiwgNjApOworCQllcnJvciA9IHVpbnB1
dF92YWxpZGF0ZV9hYnNpbmZvKGRldiwgY250LCAmZGV2LT5hYnNpbmZvW2NudF0pOworCQlpZiAo
ZXJyb3IpCisJCQlyZXR1cm4gZXJyb3I7CiAJfQogCiAJcmV0dXJuIDA7CkBAIC0zNzUsNyArMzgz
LDYgQEAgc3RhdGljIGludCB1aW5wdXRfZGV2X3NldHVwKHN0cnVjdCB1aW5wdXRfZGV2aWNlICp1
ZGV2LAogewogCXN0cnVjdCB1aW5wdXRfc2V0dXAgc2V0dXA7CiAJc3RydWN0IGlucHV0X2RldiAq
ZGV2OwotCWludCByZXR2YWw7CiAKIAlpZiAodWRldi0+c3RhdGUgPT0gVUlTVF9DUkVBVEVEKQog
CQlyZXR1cm4gLUVJTlZBTDsKQEAgLTM5MywxMCArNDAwLDYgQEAgc3RhdGljIGludCB1aW5wdXRf
ZGV2X3NldHVwKHN0cnVjdCB1aW5wdXRfZGV2aWNlICp1ZGV2LAogCWlmICghZGV2LT5uYW1lKQog
CQlyZXR1cm4gLUVOT01FTTsKIAotCXJldHZhbCA9IHVpbnB1dF92YWxpZGF0ZV9hYnNiaXRzKGRl
dik7Ci0JaWYgKHJldHZhbCA8IDApCi0JCXJldHVybiByZXR2YWw7Ci0KIAl1ZGV2LT5zdGF0ZSA9
IFVJU1RfU0VUVVBfQ09NUExFVEU7CiAJcmV0dXJuIDA7CiB9CkBAIC00MDYsNiArNDA5LDcgQEAg
c3RhdGljIGludCB1aW5wdXRfYWJzX3NldHVwKHN0cnVjdCB1aW5wdXRfZGV2aWNlICp1ZGV2LAog
ewogCXN0cnVjdCB1aW5wdXRfYWJzX3NldHVwIHNldHVwID0ge307CiAJc3RydWN0IGlucHV0X2Rl
diAqZGV2OworCWludCBlcnJvcjsKIAogCWlmIChzaXplID4gc2l6ZW9mKHNldHVwKSkKIAkJcmV0
dXJuIC1FMkJJRzsKQEAgLTQxOCwxOSArNDIyLDE2IEBAIHN0YXRpYyBpbnQgdWlucHV0X2Fic19z
ZXR1cChzdHJ1Y3QgdWlucHV0X2RldmljZSAqdWRldiwKIAogCWRldiA9IHVkZXYtPmRldjsKIAor
CWVycm9yID0gdWlucHV0X3ZhbGlkYXRlX2Fic2luZm8oZGV2LCBzZXR1cC5jb2RlLCAmc2V0dXAu
YWJzaW5mbyk7CisJaWYgKGVycm9yKQorCQlyZXR1cm4gZXJyb3I7CisKIAlpbnB1dF9hbGxvY19h
YnNpbmZvKGRldik7CiAJaWYgKCFkZXYtPmFic2luZm8pCiAJCXJldHVybiAtRU5PTUVNOwogCiAJ
c2V0X2JpdChzZXR1cC5jb2RlLCBkZXYtPmFic2JpdCk7CiAJZGV2LT5hYnNpbmZvW3NldHVwLmNv
ZGVdID0gc2V0dXAuYWJzaW5mbzsKLQotCS8qCi0JICogV2UgcmVzdG9yZSB0aGUgc3RhdGUgdG8g
VUlTVF9ORVdfREVWSUNFIGJlY2F1c2UgdGhlIHVzZXIgaGFzIHRvIGNhbGwKLQkgKiBVSV9ERVZf
U0VUVVAgaW4gdGhlIGxhc3QgcGxhY2UgYmVmb3JlIFVJX0RFVl9DUkVBVEUgdG8gY2hlY2sgdGhl
Ci0JICogdmFsaWRpdHkgb2YgdGhlIGFic2JpdHMuCi0JICovCi0JdWRldi0+c3RhdGUgPSBVSVNU
X05FV19ERVZJQ0U7CiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuNi4xCgo=
--e89a8f502ebaf3c23a0522ea9d4e--
