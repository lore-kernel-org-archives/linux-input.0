From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Tue, 8 Feb 2011 15:47:35 +0100
Message-ID: <AANLkTinfLunV5viac9vrvGfOwd-Z17ryJdfro9gtp+yB@mail.gmail.com>
References: <1296485689.7756.9.camel@novo.hadess.net>
	<20110131212842.GB1603@polaris.bitmath.org>
	<AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
	<1296561717.15349.5.camel@novo.hadess.net>
	<AANLkTim=RV1Cd0k08gv-DDho-Mim64bR7RRJ+c7D1RZf@mail.gmail.com>
	<1296650569.2123.2.camel@novo.hadess.net>
	<AANLkTinOK+=J64NRWZjit3S7hAdGVXxRE9HYkxTxrxON@mail.gmail.com>
	<AANLkTi=MGNLfLHQpVEyJGtE-j-D0dj-RWXAihW1xMKDe@mail.gmail.com>
	<1296922260.4223.4.camel@novo.hadess.net>
	<AANLkTi=yTh4YSPSQBnPFPyen9vfyfYGiT6GJVEKwGHjh@mail.gmail.com>
	<1297098262.29885.14.camel@novo.hadess.net>
	<AANLkTikxyJWxGH2P4WXMHqCbyOuKJaGgMBjxAWRsAREw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016367fa53eedafad049bc66d74
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60683 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1BHOri (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Feb 2011 09:47:38 -0500
Received: by wyb28 with SMTP id 28so5778941wyb.19
        for <linux-input@vger.kernel.org>; Tue, 08 Feb 2011 06:47:37 -0800 (PST)
In-Reply-To: <AANLkTikxyJWxGH2P4WXMHqCbyOuKJaGgMBjxAWRsAREw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

--0016367fa53eedafad049bc66d74
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

Can you give a try to the attached patch (it goes on top of the previous pa=
tch).
It would be great if you could play a little with mtdiag (or any other
multitouch application) and tell me if there is any problem.

Thanks,
Benjamin

On Mon, Feb 7, 2011 at 18:11, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Mon, Feb 7, 2011 at 18:04, Bastien Nocera <hadess@hadess.net> wrote:
>> On Mon, 2011-02-07 at 17:51 +0100, Benjamin Tissoires wrote:
>>> Hi Bastien,
>>>
>>> On Sat, Feb 5, 2011 at 17:10, Bastien Nocera <hadess@hadess.net> wrote:
>>> > On Wed, 2011-02-02 at 14:20 +0100, Benjamin Tissoires wrote:
>>> >> With the patch this time.... ;)
>>> >>
>>> >> On Wed, Feb 2, 2011 at 14:18, Benjamin Tissoires
>>> >> <benjamin.tissoires@gmail.com> wrote:
>>> >> > On Wed, Feb 2, 2011 at 13:42, Bastien Nocera <hadess@hadess.net> w=
rote:
>>> >> >> On Tue, 2011-02-01 at 14:25 +0100, Benjamin Tissoires wrote:
>>> >> >> <snip>
>>> >> >>> First pass:
>>> >> >>> - please get the branch multitouch of jiri's tree (at
>>> >> >>> http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dsh=
ortlog;h=3Drefs/heads/multitouch)
>>> >> >>> - then apply the attached patch (git am
>>> >> >>> 0001-hid-multitouch-Introduce-Elo-TouchSystems-2515-Intel.patch)
>>> >> >>> - get your config from your current kernel (check that hid-multi=
touch
>>> >> >>> is enabled as a module)
>>> >> >>> - compile, install, reboot
>>> >> >>
>>> >> >> That's where I hit a problem. It seems that the kernel on which t=
hat
>>> >> >> branch is based has broken cgroups support (it panics on startup)=
.
>>> >> >>
>>> >> >> Would your patch, or a patchset be available to apply to the clos=
e to
>>> >> >> Linus tree Fedora rawhide kernel?
>>> >> >
>>> >> > Hi Bastien,
>>> >> >
>>> >> > Sorry for that. Attached a new version that bumps a Linus' 2.6.38-=
rc2
>>> >> > or 2.6.38-rc3 to Jiri's tree and applies the patch above.
>>> >> >
>>> >> > If it's still not working, I'll send you the files directly ;)
>>> >
>>> > The instructions didn't quite work (the PCI ID seems to be in
>>> > upper-case, and the tail command wasn't producing any output). I used
>>> > good ol' 'cat' instead. Attached is what it produced.
>>>
>>> oops... When you say "the PCI ID seems to be in upper-case", you means
>>> the path of the events file, or you had to modify the patch?
>>
>> The sysfs path needed upper-case, yes. I did not change the patch.
>
> ok, so my patch is clean.... yes!
>
>>
>>> >
>>> > The cursor actually follows the touch, but it seems I need to press
>>> > quite hard to make it work.
>>>
>>> Is this the same with a Windows system? I don't think we made any
>>> assumption on the pressure.
>>
>> I have no idea. I booted Windows once on this machine, when I actually
>> got it. I can certainly check there though.
>>
>>> > Touch with 2 fingers doesn't do anything
>>> > different from single finger.
>>>
>>> This is quite normal: Linux is not ready for multitouch right now ;)
>>> Only the kernel is ready. People are working on x.org' XInput 2.1 to
>>> enable multitouch in X.org, and the toolkits are following this
>>> development.
>>>
>>> If you want to give a try, you can download our mt-diagnostic software
>>> at: =A0http://lii-enac.fr/en/architecture/linux-input/mtdiag.html .
>>
>> That's alright. I know of the efforts, I stupidly thought that this
>> would behave the same way as the MacBook touchpads (eg. give me access
>> to a right-click).
>
> You won't have the right click out of the box for now. Peter Hutterer
> submitted last week patches to enable right click simulation with long
> press. It works well for absolute device, but you need a development
> tree of Xorg... So, we will have to wait for it too. :(
>
>>
>>> >
>>> > Let me know if you want me to test anything else. I'll try not to tak=
e
>>> > as long to do the testing next time, but we were working on our first
>>> > GNOME 3 test day.
>>>
>>> Well, the device does not sends much relevant informations: we have to
>>> rebuild some informations, so the final patch will be really close to
>>> the one I sent last week. Once I made it, I'll ask you to test it
>>> before submitting it for 2.6.38 (if it's still possible).
>>
>> Sure thing. I'll look for it in my mail.
>>
>> Still interested in me trying out Windows for that "need to press hard"
>> touch?
>
> Sure, but I don't know if we will be able to solve it (I did not found
> anything in the reports descriptors that add such feature).
>
> Cheers,
> Benjamin
>

--0016367fa53eedafad049bc66d74
Content-Type: text/x-patch; charset=US-ASCII; name="elo_ts.patch"
Content-Disposition: attachment; filename="elo_ts.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjwx9jiu0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1tdWx0aXRvdWNoLmMgYi9kcml2ZXJzL2hpZC9o
aWQtbXVsdGl0b3VjaC5jCmluZGV4IGE3MjE3MTAuLjNiNzNjODggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaGlkL2hpZC1tdWx0aXRvdWNoLmMKKysrIGIvZHJpdmVycy9oaWQvaGlkLW11bHRpdG91Y2gu
YwpAQCAtNzAsNiArNzAsNyBAQCBzdHJ1Y3QgbXRfY2xhc3MgewogI2RlZmluZSBNVF9DTFNfRFVB
TF9JTlJBTkdFX0NPTlRBQ1RJRAkJMgogI2RlZmluZSBNVF9DTFNfRFVBTF9JTlJBTkdFX0NPTlRB
Q1ROVU1CRVIJMwogI2RlZmluZSBNVF9DTFNfQ1lQUkVTUwkJCQk0CisjZGVmaW5lIE1UX0NMU19E
VUFMX05TTVVfQ09OVEFDVElECQk1CiAKIC8qCiAgKiB0aGVzZSBkZXZpY2UtZGVwZW5kZW50IGZ1
bmN0aW9ucyBkZXRlcm1pbmUgd2hhdCBzbG90IGNvcnJlc3BvbmRzCkBAIC0xMTksNiArMTIwLDEw
IEBAIHN0cnVjdCBtdF9jbGFzcyBtdF9jbGFzc2VzW10gPSB7CiAJCS5xdWlya3MgPSBNVF9RVUlS
S19OT1RfU0VFTl9NRUFOU19VUCB8CiAJCQlNVF9RVUlSS19DWVBSRVNTLAogCQkubWF4Y29udGFj
dHMgPSAxMCB9LAorCXsgLm5hbWUgPSBNVF9DTFNfRFVBTF9OU01VX0NPTlRBQ1RJRCwKKwkJLnF1
aXJrcyA9IE1UX1FVSVJLX05PVF9TRUVOX01FQU5TX1VQIHwKKwkJCU1UX1FVSVJLX1NMT1RfSVNf
Q09OVEFDVElELAorCQkubWF4Y29udGFjdHMgPSAyIH0sCiAKIAl7IH0KIH07CkBAIC00NjcsNyAr
NDcyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBoaWRfZGV2aWNlX2lkIG10X2RldmljZXNbXSA9
IHsKIAkJCVVTQl9ERVZJQ0VfSURfQ1lQUkVTU19UUlVFVE9VQ0gpIH0sCiAKIAkvKiBFbG8gVG91
Y2hTeXN0ZW1zIEludGVsbGlUb3VjaCBQbHVzIHBhbmVsICovCi0JeyAuZHJpdmVyX2RhdGEgPSBN
VF9DTFNfREVGQVVMVCwKKwl7IC5kcml2ZXJfZGF0YSA9IE1UX0NMU19EVUFMX05TTVVfQ09OVEFD
VElELAogCQlISURfVVNCX0RFVklDRShVU0JfVkVORE9SX0lEX0VMTywKIAkJCVVTQl9ERVZJQ0Vf
SURfRUxPX1RTMjUxNSkgfSwKIAo=
--0016367fa53eedafad049bc66d74--
