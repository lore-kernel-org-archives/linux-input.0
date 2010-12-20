From: Ajay Ramaswamy <linuxwacom@ramaswamy.net>
Subject: Re: [PATCH] Add support for the built-in digitizer in the Lenovo W700
Date: Mon, 20 Dec 2010 14:22:18 +0530
Message-ID: <AANLkTi=T5VDdANAK=7zP9UWWc-0hZ2=12yHdZ0v5RsMH@mail.gmail.com>
References: <AANLkTi=KjATXVpdDYi5ZgYRX1Hbgv45m7Pabejg76kg3@mail.gmail.com>
	<AANLkTikaSN=9Rja4+QSwE_5aakbQ8=UrS_ZGjtyT+cow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364d1dc92a6b990497d3a334
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65329 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab0LTIwU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Dec 2010 03:52:20 -0500
Received: by wwa36 with SMTP id 36so2703192wwa.1
        for <linux-input@vger.kernel.org>; Mon, 20 Dec 2010 00:52:19 -0800 (PST)
In-Reply-To: <AANLkTikaSN=9Rja4+QSwE_5aakbQ8=UrS_ZGjtyT+cow@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org
Cc: peter.hutterer@who-t.net, linuxwacom-devel@lists.sourceforge.net

--0016364d1dc92a6b990497d3a334
Content-Type: text/plain; charset=ISO-8859-1

Ping

Thank you for your support and encouragement, I have followed your
instructions and made a git patch for the kernel

I have not added any Acked-by line for this patch, I think you need to
do that? Please do the needful.


Thanks & best regards

Ajay

On Mon, Dec 20, 2010 at 10:10 AM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Sun, Dec 19, 2010 at 1:26 AM, Ajay Ramaswamy
> <linuxwacom@ramaswamy.net> wrote:
>> Ping
>>
>> Thanks for your support in getting this done. I have made a patch
>> against xf86-input-wacom master in git for Peter.
>
> The patch looks good to me. I thought it would take sometime for you
> to make a git patch since you mentioned that you have not programmed
> in C for 20 years.
>
> With your prompt reply, I think you can make a kernel patch just fine.
> Please make your kernel patch based on the next branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git and
> submit it to linux-input@vger.kernel.org,
>
> Thank you.
>
> Ping
>
>> Hopefully all this will result in fedora 15 having support for my laptop.
>>
>> Thanks & best regards
>>
>> Ajay
>>
>> On Sun, Dec 19, 2010 at 6:19 AM, Ping Cheng <pinglinux@gmail.com> wrote:
>>> On Thu, Dec 16, 2010 at 6:37 AM, Ajay Ramaswamy <ajayr@krithika.net> wrote:
>>>> Hello Ping Cheng
>>>>
>>>> I have been using the tablet for the last 4 months without any
>>>> problems, Today I have updated my patches against the current
>>>> development series 0.10.10, can you accept these patches now?
>>>
>>> The xf86-input-wacom looks fine. If you don't mind, please make a
>>> patch in git format with my Acked-by tag so Peter can merge it to the
>>> git repo.
>>>
>>> I'll make a git patch based on your input-wacom-thinkpad-w700.patch
>>> and submit it to linux-input on your behalf.
>>>
>>> Thank you.
>>>
>>> Ping
>>>
>>>> My request for testing has not got any response so far! Perhaps the
>>>> laptop is too exotic for it to be used widely by Linux users.
>>>>
>>>> http://forums.lenovo.com/t5/W-Series-ThinkPad-Laptops/HELP-W700-color-calibration-or-finger-print-reader-and-tablet-in/m-p/211014#M7584
>>>>
>>>> and
>>>>
>>>> http://forum.thinkpads.com/viewtopic.php?f=48&t=89292&hilit=w700+wacom+linux
>>>>
>>>> and
>>>>
>>>> http://forums.fedoraforum.org/showthread.php?t=249263&highlight=w700+wacom
>>>>
>>>>
>>>> Thanks for your consideration.
>>>>
>>>> with best regards
>>>> Ajay
>>>>
>>>> On Tue, Jul 27, 2010 at 10:49 PM, Ping Cheng <pinglinux@gmail.com> wrote:
>>>>> On Tue, Jul 27, 2010 at 5:22 AM, Ajay Ramaswamy <ajayr@krithika.net> wrote:
>>>>>> On Tuesday 27 Jul 2010 12:03:38 pm Ping Cheng wrote:
>>>>>>
>>>>>>> >> I do have one question though: did you add LENOVO_VENDOR_ID and 0x6004
>>>>>>> >> to the ignore list of hid-core.c in your kernel source?
>>>>>>> >
>>>>>>> > NO, should I do that?
>>>>>>>
>>>>>>> Oh, weird. If you didn't add it to the ignore list, it should be
>>>>>>> grabbed by HID. That is Wacom driver can not take control of it. Maybe
>>>>>>> the structure has been changed for your kernel version?
>>>>>>>
>>>>>>> > Like I said I haven't programmed in C for 20 years so
>>>>>>> > most of this is shooting in the dark.
>>>>>>> >
>>>>>>> > I have also registered in a couple of Thinkpad forums and made a request
>>>>>>> > for testing of these patches, let us see if there is any response.
>>>>>>>
>>>>>>> Good idea. I'll wait for the feedback.
>>>>>>>
>>>>>>> Thank you.
>>>>>>>
>>>>>>> Ping
>>>>>>
>>>>>>
>>>>>> [ajayr@kate by-id]$ ls -l /dev/input/by-id
>>>>>> total 0
>>>>>> lrwxrwxrwx 1 root root 9 Jul 27 17:22 usb-Chicony_Electronics_Co.__Ltd._480c-
>>>>>> event-if00 -> ../event9
>>>>>> lrwxrwxrwx 1 root root 9 Jul 27 17:22 usb-Logitech_USB_Gaming_Mouse-event-
>>>>>> mouse -> ../event5
>>>>>> lrwxrwxrwx 1 root root 9 Jul 27 17:22 usb-Logitech_USB_Gaming_Mouse-mouse ->
>>>>>> ../mouse1
>>>>>> lrwxrwxrwx 1 root root 9 Jul 27 17:22 usb-Tablet_ISD-V4-event-mouse ->
>>>>>> ../event6
>>>>>> lrwxrwxrwx 1 root root 9 Jul 27 17:22 usb-Tablet_ISD-V4-mouse -> ../mouse2
>>>>>> [ajayr@kate by-id]$
>>>>>>
>>>>>>
>>>>>> is this expected? should the tablet show both as mouse and event?
>>>>>
>>>>> Those are fine.
>>>>>
>>>>>> shall I rebuild a kernel with a patch to ignore the LENOVO 0x6004 device like this?
>>>>>
>>>>> Since the tablet works for you, I would think you don't need the
>>>>> change. However, I would also eager to know if there would be any
>>>>> difference in the behaviour of the tablet if you apply the patch.
>>>>> Please make sure you are adding the line to ignorelist instead of
>>>>> blacklist (I do not have the source to diff it).
>>>>>
>>>>> Thank you.
>>>>>
>>>>> Ping
>>>>>
>>>>
>>>
>>
>

--0016364d1dc92a6b990497d3a334
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Add-support-for-the-built-in-digitizer-in-the-Lenovo.patch"
Content-Disposition: attachment;
	filename="0001-Add-support-for-the-built-in-digitizer-in-the-Lenovo.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghx4gtgo0

RnJvbSA4NTY1ZTAzYzU5OTU5NDRkNjI4ZmQxZjgwNDFmZjAwMzEzNjAwZmE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBamF5IFJhbWFzd2FteSA8YWpheUByYW1hc3dhbXkubmV0PgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDE0OjE0OjIzICswNTMwClN1YmplY3Q6IFtQQVRDSF0gQWRk
IHN1cHBvcnQgZm9yIHRoZSBidWlsdC1pbiBkaWdpdGl6ZXIgaW4gdGhlIExlbm92byBXNzAwCgpT
dWJtaXR0ZWQtYnk6IEFqYXkgUmFtYXN3YW15IDxhamF5QHJhbWFzd2FteS5uZXQ+Ci0tLQogZHJp
dmVycy9pbnB1dC90YWJsZXQvd2Fjb20uaCAgICAgfCAgICAxICsKIGRyaXZlcnMvaW5wdXQvdGFi
bGV0L3dhY29tX3dhYy5jIHwgICAgNyArKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RhYmxl
dC93YWNvbS5oIGIvZHJpdmVycy9pbnB1dC90YWJsZXQvd2Fjb20uaAppbmRleCBkZTVhZGIxLi4y
MzMxN2JkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L3RhYmxldC93YWNvbS5oCisrKyBiL2Ry
aXZlcnMvaW5wdXQvdGFibGV0L3dhY29tLmgKQEAgLTEwMyw2ICsxMDMsNyBAQCBNT0RVTEVfREVT
Q1JJUFRJT04oRFJJVkVSX0RFU0MpOwogTU9EVUxFX0xJQ0VOU0UoRFJJVkVSX0xJQ0VOU0UpOwog
CiAjZGVmaW5lIFVTQl9WRU5ET1JfSURfV0FDT00JMHgwNTZhCisjZGVmaW5lIFVTQl9WRU5ET1Jf
SURfTEVOT1ZPCTB4MTdlZgogCiBzdHJ1Y3Qgd2Fjb20gewogCWRtYV9hZGRyX3QgZGF0YV9kbWE7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RhYmxldC93YWNvbV93YWMuYyBiL2RyaXZlcnMv
aW5wdXQvdGFibGV0L3dhY29tX3dhYy5jCmluZGV4IDBiMDUyNTQuLjAwMjRkM2UgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvaW5wdXQvdGFibGV0L3dhY29tX3dhYy5jCisrKyBiL2RyaXZlcnMvaW5wdXQv
dGFibGV0L3dhY29tX3dhYy5jCkBAIC0xNDI0LDExICsxNDI0LDE3IEBAIHN0YXRpYyBzdHJ1Y3Qg
d2Fjb21fZmVhdHVyZXMgd2Fjb21fZmVhdHVyZXNfMHhEMiA9CiAJeyAiV2Fjb20gQmFtYm9vIENy
YWZ0IiwgICBXQUNPTV9QS0dMRU5fQkJGVU4sICAgICAxNDcyMCwgIDkyMDAsIDEwMjMsIDYzLCBC
QU1CT09fUFQgfTsKIHN0YXRpYyBzdHJ1Y3Qgd2Fjb21fZmVhdHVyZXMgd2Fjb21fZmVhdHVyZXNf
MHhEMyA9CiAJeyAiV2Fjb20gQmFtYm9vIDJGRyA2eDgiLCBXQUNPTV9QS0dMRU5fQkJGVU4sICAg
ICAyMTY0OCwgMTM1MzAsIDEwMjMsIDYzLCBCQU1CT09fUFQgfTsKK3N0YXRpYyBjb25zdCBzdHJ1
Y3Qgd2Fjb21fZmVhdHVyZXMgd2Fjb21fZmVhdHVyZXNfMHg2MDA0ID0KKwl7ICJJU0QtVjQiLCAg
ICAgICAgICAgICAgIFdBQ09NX1BLR0xFTl9HUkFQSElSRSwgIDEyODAwLCA4MDAwLCAyNTUsIDAs
IFRBQkxFVFBDIH07CiAKICNkZWZpbmUgVVNCX0RFVklDRV9XQUNPTShwcm9kKQkJCQkJXAogCVVT
Ql9ERVZJQ0UoVVNCX1ZFTkRPUl9JRF9XQUNPTSwgcHJvZCksCQkJXAogCS5kcml2ZXJfaW5mbyA9
IChrZXJuZWxfdWxvbmdfdCkmd2Fjb21fZmVhdHVyZXNfIyNwcm9kCiAKKyNkZWZpbmUgVVNCX0RF
VklDRV9MRU5PVk8ocHJvZCkJCQkJCVwKKwlVU0JfREVWSUNFKFVTQl9WRU5ET1JfSURfTEVOT1ZP
LCBwcm9kKSwJCQlcCisJLmRyaXZlcl9pbmZvID0gKGtlcm5lbF91bG9uZ190KSZ3YWNvbV9mZWF0
dXJlc18jI3Byb2QKKwogY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgd2Fjb21faWRzW10gPSB7
CiAJeyBVU0JfREVWSUNFX1dBQ09NKDB4MDApIH0sCiAJeyBVU0JfREVWSUNFX1dBQ09NKDB4MTAp
IH0sCkBAIC0xNTAxLDYgKzE1MDcsNyBAQCBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCB3YWNv
bV9pZHNbXSA9IHsKIAl7IFVTQl9ERVZJQ0VfV0FDT00oMHhFMikgfSwKIAl7IFVTQl9ERVZJQ0Vf
V0FDT00oMHhFMykgfSwKIAl7IFVTQl9ERVZJQ0VfV0FDT00oMHg0NykgfSwKKwl7IFVTQl9ERVZJ
Q0VfTEVOT1ZPKDB4NjAwNCkgfSwKIAl7IH0KIH07CiBNT0RVTEVfREVWSUNFX1RBQkxFKHVzYiwg
d2Fjb21faWRzKTsKLS0gCjEuNy4zLjQKCg==
--0016364d1dc92a6b990497d3a334--
