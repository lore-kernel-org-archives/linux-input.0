From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Tue, 1 Feb 2011 14:25:51 +0100
Message-ID: <AANLkTim=RV1Cd0k08gv-DDho-Mim64bR7RRJ+c7D1RZf@mail.gmail.com>
References: <1296485689.7756.9.camel@novo.hadess.net>
	<20110131212842.GB1603@polaris.bitmath.org>
	<AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
	<1296561717.15349.5.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f87012a30479049b387839
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54419 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab1BANZx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Feb 2011 08:25:53 -0500
Received: by wwa36 with SMTP id 36so7025299wwa.1
        for <linux-input@vger.kernel.org>; Tue, 01 Feb 2011 05:25:52 -0800 (PST)
In-Reply-To: <1296561717.15349.5.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

--001485f87012a30479049b387839
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Feb 1, 2011 at 13:01, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2011-02-01 at 10:00 +0100, Benjamin Tissoires wrote:
>> Hi Bastien, Henrik,
>>
>> On Mon, Jan 31, 2011 at 22:28, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > Hi Bastien,
>> >
>> >> Built into my Lenovo A700 all-in-one is a touchscreen. lsusb says:
>> >> $ lsusb | grep -i touch
>> >> Bus 002 Device 006: ID 04e7:0022 Elo TouchSystems
>> >
>> > I take it this is a dual-touch device?
>> >
>> >> The touchscreen "works", in that tapping it will create a click event,
>> >> though that click event is always in the top left of the screen.
>> >
>> > This is quite common for HID multitouch devices without proper driver
>> > support. Sometimes using the HID_MULTI_INPUT quirk helps. Check
>> > usbhid/hid-quirks.c for examples.
>> >
>> >> Full output of lsusb -vvv attached.
>> >>
>> >> Anybody with ideas as to what I'm missing, or whether that particular
>> >> device is supported?
>> >
>> > You probably noted already that the 04e7:0020 device is listed in
>> > usbhid. Unless the device claims to be win7 compliant (implying
>> > patching up hid-multitouch), going with the evtouch X driver might get
>> > you a bit on the way. Or - god forbid - the binary blob drivers...
>>
>> To know if the device is "win7 compliant" or not, we need the full
>> output of lsusb (with the report descriptors).
>> You need to tell usbhid to release the device before calling lsusb -v.
>>
>> Please use the script at
>> http://lii-enac.fr/en/architecture/linux-input/report.py
>> and run, as root: python report.py > descriptors.txt
>>
>> This will do the job. You can then send us the descriptors.txt, and we
>> will see what we can do.
>
> Attached (with the rest of the input devices stripped).
>
>> >> Using kernel 2.6.38-rc2-git5 (from Fedora rawhide).
>>
>> If your device is "win7 compliant" you will have to recompile a new kernel.
>
> That's alright, I've done this before ;)
>

Hi Bastian,

well, apparently your device should be supported by hid-multitouch.

We will have to do this in two passes:
1) we enable it with hid-multitouch to be able to understand the protocol.
2) we tune the driver in order not making useless operations in the kernel.


First pass:
- please get the branch multitouch of jiri's tree (at
http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=shortlog;h=refs/heads/multitouch)
- then apply the attached patch (git am
0001-hid-multitouch-Introduce-Elo-TouchSystems-2515-Intel.patch)
- get your config from your current kernel (check that hid-multitouch
is enabled as a module)
- compile, install, reboot
- Now your device should still work and must be handled by hid-multitouch
if it's the case:
- mount -t debugfs none /sys/kernel/debug
- tail -f -n0 /sys/kernel/debug/hid/0003:04e7:0022:*/events | tee
logs_04e7_0022.txt

do one finger move on the screen, release
do 2 fingers move on the screen, release the first finger, then the second.

hit Ctrl-C in the terminal (lots of debug info should have been printed).

And send me the logs_04e7_0022.txt to got to the second pass.

Thanks,
Benjamin

--001485f87012a30479049b387839
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-hid-multitouch-Introduce-Elo-TouchSystems-2515-Intel.patch"
Content-Disposition: attachment;
	filename="0001-hid-multitouch-Introduce-Elo-TouchSystems-2515-Intel.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjmu15vb1

RnJvbSBlMzk4ZGI0Yjc1ZjExNjRlOGE2ODRmMGExYjE1MjE4ZWFhYmI1NjA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5qYW1pbiBUaXNzb2lyZXMgPGJlbmphbWluLnRpc3NvaXJl
c0BlbmFjLmZyPgpEYXRlOiBUdWUsIDEgRmViIDIwMTEgMTQ6MDc6MTIgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBoaWQtbXVsdGl0b3VjaDogSW50cm9kdWNlIEVsbyBUb3VjaFN5c3RlbXMgMjUxNSBJ
bnRlbGxpVG91Y2ggUGx1cwoKVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIEVsbyBUb3VjaFN5
c3RlbXMgMjUxNSBJbnRlbGxpVG91Y2ggUGx1cwp0aGF0IGNhbiBiZSBmb3VuZCBpbiBMZW5vdm8g
QTcwMCBhbGwtaW4tb25lLgoKU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gVGlzc29pcmVzIDxiZW5q
YW1pbi50aXNzb2lyZXNAZW5hYy5mcj4KLS0tCiBkcml2ZXJzL2hpZC9LY29uZmlnICAgICAgICAg
IHwgICAgMSArCiBkcml2ZXJzL2hpZC9oaWQtY29yZS5jICAgICAgIHwgICAgMSArCiBkcml2ZXJz
L2hpZC9oaWQtaWRzLmggICAgICAgIHwgICAgMSArCiBkcml2ZXJzL2hpZC9oaWQtbXVsdGl0b3Vj
aC5jIHwgICAgNSArKysrKwogNCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvS2NvbmZpZyBiL2RyaXZlcnMvaGlk
L0tjb25maWcKaW5kZXggYTBiMTE3ZC4uZDM3MzYzNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQv
S2NvbmZpZworKysgYi9kcml2ZXJzL2hpZC9LY29uZmlnCkBAIC0zMDMsNiArMzAzLDcgQEAgY29u
ZmlnIEhJRF9NVUxUSVRPVUNICiAKIAkgIFNheSBZIGhlcmUgaWYgeW91IGhhdmUgb25lIG9mIHRo
ZSBmb2xsb3dpbmcgZGV2aWNlczoKIAkgIC0gQ3lwcmVzcyBUcnVlVG91Y2ggcGFuZWxzCisJICAt
IEVsbyBUb3VjaFN5c3RlbXMgSW50ZWxsaVRvdWNoIFBsdXMgcGFuZWxzCiAJICAtIEhhbnZvbiBk
dWFsIHRvdWNoIHBhbmVscwogCSAgLSBJclRvdWNoIEluZnJhcmVkIFVTQiBwYW5lbHMKIAkgIC0g
UGl4Y2lyIGR1YWwgdG91Y2ggcGFuZWxzCmRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtY29y
ZS5jIGIvZHJpdmVycy9oaWQvaGlkLWNvcmUuYwppbmRleCBkNjc4Y2YzLi5lNzAxZTU3IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2hpZC9oaWQtY29yZS5jCisrKyBiL2RyaXZlcnMvaGlkL2hpZC1jb3Jl
LmMKQEAgLTEzMzQsNiArMTMzNCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGlkX2RldmljZV9p
ZCBoaWRfaGF2ZV9zcGVjaWFsX2RyaXZlcltdID0gewogCXsgSElEX1VTQl9ERVZJQ0UoVVNCX1ZF
TkRPUl9JRF9EV0FWLCBVU0JfREVWSUNFX0lEX0RXQVZfRUdBTEFYX01VTFRJVE9VQ0gzKSB9LAog
CXsgSElEX1VTQl9ERVZJQ0UoVVNCX1ZFTkRPUl9JRF9EV0FWLCBVU0JfREVWSUNFX0lEX0RXQVZf
RUdBTEFYX01VTFRJVE9VQ0g0KSB9LAogCXsgSElEX0JMVUVUT09USF9ERVZJQ0UoVVNCX1ZFTkRP
Ul9JRF9FTEVDT00sIFVTQl9ERVZJQ0VfSURfRUxFQ09NX0JNMDg0KSB9LAorCXsgSElEX1VTQl9E
RVZJQ0UoVVNCX1ZFTkRPUl9JRF9FTE8sIFVTQl9ERVZJQ0VfSURfRUxPX1RTMjUxNSkgfSwKIAl7
IEhJRF9VU0JfREVWSUNFKFVTQl9WRU5ET1JfSURfRU1TLCBVU0JfREVWSUNFX0lEX0VNU19UUklP
X0xJTktFUl9QTFVTX0lJKSB9LAogCXsgSElEX1VTQl9ERVZJQ0UoVVNCX1ZFTkRPUl9JRF9FWktF
WSwgVVNCX0RFVklDRV9JRF9CVENfODE5MykgfSwKIAl7IEhJRF9VU0JfREVWSUNFKFVTQl9WRU5E
T1JfSURfR0FNRVJPTiwgVVNCX0RFVklDRV9JRF9HQU1FUk9OX0RVQUxfUFNYX0FEQVBUT1IpIH0s
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtaWRzLmggYi9kcml2ZXJzL2hpZC9oaWQtaWRz
LmgKaW5kZXggYjFkZDdhZC4uNzc4MGM0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaGlkLWlk
cy5oCisrKyBiL2RyaXZlcnMvaGlkL2hpZC1pZHMuaApAQCAtMjE2LDYgKzIxNiw3IEBACiAjZGVm
aW5lIFVTQl9WRU5ET1JfSURfRFJFQU1fQ0hFRUtZCTB4MWQzNAogCiAjZGVmaW5lIFVTQl9WRU5E
T1JfSURfRUxPCQkweDA0RTcKKyNkZWZpbmUgVVNCX0RFVklDRV9JRF9FTE9fVFMyNTE1CTB4MDAy
MgogI2RlZmluZSBVU0JfREVWSUNFX0lEX0VMT19UUzI3MDAJMHgwMDIwCiAKICNkZWZpbmUgVVNC
X1ZFTkRPUl9JRF9FTVMJCTB4MjAwNgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLW11bHRp
dG91Y2guYyBiL2RyaXZlcnMvaGlkL2hpZC1tdWx0aXRvdWNoLmMKaW5kZXggNjlmODc0NC4uYTcy
MTcxMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaGlkLW11bHRpdG91Y2guYworKysgYi9kcml2
ZXJzL2hpZC9oaWQtbXVsdGl0b3VjaC5jCkBAIC00NjYsNiArNDY2LDExIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgaGlkX2RldmljZV9pZCBtdF9kZXZpY2VzW10gPSB7CiAJCUhJRF9VU0JfREVWSUNF
KFVTQl9WRU5ET1JfSURfQ1lQUkVTUywKIAkJCVVTQl9ERVZJQ0VfSURfQ1lQUkVTU19UUlVFVE9V
Q0gpIH0sCiAKKwkvKiBFbG8gVG91Y2hTeXN0ZW1zIEludGVsbGlUb3VjaCBQbHVzIHBhbmVsICov
CisJeyAuZHJpdmVyX2RhdGEgPSBNVF9DTFNfREVGQVVMVCwKKwkJSElEX1VTQl9ERVZJQ0UoVVNC
X1ZFTkRPUl9JRF9FTE8sCisJCQlVU0JfREVWSUNFX0lEX0VMT19UUzI1MTUpIH0sCisKIAkvKiBH
ZW5lcmFsVG91Y2ggcGFuZWwgKi8KIAl7IC5kcml2ZXJfZGF0YSA9IE1UX0NMU19EVUFMX0lOUkFO
R0VfQ09OVEFDVE5VTUJFUiwKIAkJSElEX1VTQl9ERVZJQ0UoVVNCX1ZFTkRPUl9JRF9HRU5FUkFM
X1RPVUNILAotLSAKMS43LjMuNAoK
--001485f87012a30479049b387839--
