From: Kmarty <gkmarty@gmail.com>
Subject: Re: [PATCH 2/2] driver for Zhen Hua PCM-4CH RC transmitter v2
Date: Wed, 13 Feb 2008 17:52:18 +0100
Message-ID: <5fecb1300802130852xcf5fe9dyb1ddbf24e6338bdf@mail.gmail.com>
References: <5fecb1300802130751q6df572dap3a9d6f2231c6e890@mail.gmail.com>
	 <20080213105906.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_16764_21665641.1202921538229"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:5801 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758887AbYBMQwU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Feb 2008 11:52:20 -0500
Received: by el-out-1112.google.com with SMTP id v27so71461ele.23
        for <linux-input@vger.kernel.org>; Wed, 13 Feb 2008 08:52:19 -0800 (PST)
In-Reply-To: <20080213105906.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org

------=_Part_16764_21665641.1202921538229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/2/13, Dmitry Torokhov:
> Hi,
>
> On Wed, Feb 13, 2008 at 04:51:50PM +0100, Kmarty wrote:
> >
> > +int zhenhua_init(int fd, long *id, long *extra)
> > +{
> > +     /* Zhen Hua 5 byte protokol: prvni (synchronizacni) byte obsahuje vzdy 0xF7,
> > +      * nasledujici ctyri pak jednotlive osy ovladace v intervalu 50-200.
> > +      * Pozor, nacitana data (jednotlive bajty) jsou bitove prevracene (nejnizsi
> > +      * bit je nejvyssim bitem) - neco jako little-endian na bitove urovni.
> > +      * Synchronizacni byte ma tedy bez prevraceni hodnotu 0xEF
> > +      *
> > +      * Inicializace je temer shodna s twiddlerem */
> > +
>
> Could you please change this comment to english since this way most
> people can read it? Other than that it all looks good, thanks.
>
> --
> Dmitry
>
Ok, translated.

------=_Part_16764_21665641.1202921538229
Content-Type: application/octet-stream; name=inputattach.c.diffstat
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fcm4dhuh
Content-Disposition: attachment; filename=inputattach.c.diffstat

IGlucHV0YXR0YWNoLmMgfCAgIDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystCiAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo=

------=_Part_16764_21665641.1202921538229
Content-Type: text/x-patch; name=inputattach.c.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fcm4dkxd
Content-Disposition: attachment; filename=inputattach.c.diff

LS0tIGlucHV0YXR0YWNoLmMub3JpZwkyMDA4LTAyLTA2IDEwOjM1OjIyLjAwMDAwMDAwMCArMDEw
MAorKysgaW5wdXRhdHRhY2guYwkyMDA4LTAyLTEzIDE3OjQ4OjI5LjAwMDAwMDAwMCArMDEwMApA
QCAtMSw1ICsxLDQgQEAKIC8qCi0gKiAkSWQ6IGlucHV0YXR0YWNoLmMgMjM1MiAyMDA2LTAyLTA4
IDEyOjE5OjMxWiB2b2p0ZWNoICQKICAqCiAgKiAgQ29weXJpZ2h0IChjKSAxOTk5LTIwMDAgVm9q
dGVjaCBQYXZsaWsKICAqCkBAIC0zMTUsNiArMzE0LDQ0IEBACiAJcmV0dXJuIDA7CiB9CiAKK2lu
dCB6aGVuaHVhX2luaXQoaW50IGZkLCBsb25nICppZCwgbG9uZyAqZXh0cmEpCit7CisJLyogWmhl
biBIdWEgNSBieXRlIHByb3RvY29sOiBmaXJzdCAoc3luY2hyb25pemF0aW9uKSBieXRlIGFsbHdh
eXMKKwkgKiBjb250YWluIDB4RjcsIG5leHQgZm91ciBieXRlcyBhcmUgYXhpcyBvZiBjb250cm9s
bGVyIHdpdGggdmFsdWVzCisJICogYmV0d2VlbiA1MC0yMDAuCisJICogSW5jb21pbmcgZGF0YSAo
ZWFjaCBieXRlKSBoYXZlIHJldmVyc2VkIGJpdHMgKGxvd2VzdCBiaXQgaXMKKwkgKiBoaWdoZXN0
IGJpdCkgLSBzb21ldGhpbmcgbGlrZSBsaXR0bGUtZW5kaWFuIGJ1dCBvbiBiaXQgbGV2ZWwuCisJ
ICogU3luY2hyb25pemF0aW9uIGJ5dGUgd2l0aG91dCByZXZlcnNpbmcgYml0cyBoYXZlIChyYXcp
IHZhbHVlOgorCSAqIDB4RUYKKwkgKgorCSAqIEluaXRpYWxpemF0aW9uIGlzIGFsbW9zdCBzYW1l
IGFzIHR3aWRkbGVyX2luaXQgKi8KKworCXVuc2lnbmVkIGNoYXIgY1sxMF07CisJaW50IGNvdW50
OworCisJZm9yIChjb3VudD0wIDsgY291bnQgPCA1IDsgY291bnQrKykgeworCQlpZihyZWFkY2hh
cihmZCwgYyswLCA1MDApKSByZXR1cm4gLTE7CisJCWlmKGNbMF0gPT0gMHhlZikgYnJlYWs7CisJ
fQorCisJaWYgKGNvdW50ID09IDUpIHsKKwkJLyogQ291bGQgbm90IGZpbmQgaGVhZGVyIGJ5dGUg
aW4gZGF0YSBzdHJlYW0gKi8KKwkJcmV0dXJuIC0xOworCX0KKworCS8qIFJlYWQgcmVtYWluaW5n
IDQgYnl0ZXMgcGx1cyB0aGUgZnVsbCBuZXh0IGRhdGEgcGFja2V0ICovCisJZm9yIChjb3VudCA9
IDE7IGNvdW50IDwgMTA7IGNvdW50KyspIHsKKwkJaWYgKHJlYWRjaGFyKGZkLCBjK2NvdW50LCA1
MDApKSByZXR1cm4gLTE7CisJfQorCisJLyogY2hlY2sgaWYgbmV4dCBzeW5jIGJ5dGUgZXhpc3Rz
ICovCisJaWYgKGNbNV0gIT0gMHhlZikKKwkJcmV0dXJuIC0xOworCisJcmV0dXJuIDA7CisJCQor
fQorCiBpbnQgZHVtcF9pbml0KGludCBmZCwgbG9uZyAqaWQsIGxvbmcgKmV4dHJhKQogewogCXVu
c2lnbmVkIGNoYXIgYywgbyA9IDA7CkBAIC0zNzYsNiArNDEzLDcgQEAKIHsgIi0tZWxvNDAwMiIs
CQkiLWVsbzZiIiwJQjk2MDAsIENTOCB8IENSVFNDVFMsCQlTRVJJT19FTE8sCTEsCTAsCTAsCU5V
TEwgfSwKIHsgIi0tZWxvMjcxLTE0MCIsCSItZWxvNGIiLAlCOTYwMCwgQ1M4IHwgQ1JUU0NUUywJ
CVNFUklPX0VMTywJMiwJMCwJMCwJTlVMTCB9LAogeyAiLS1lbG8yNjEtMjgwIiwJIi1lbG8zYiIs
CUI5NjAwLCBDUzggfCBDUlRTQ1RTLAkJU0VSSU9fRUxPLAkzLAkwLAkwLAlOVUxMIH0sCit7ICIt
LXpoZW4taHVhIiwJCSItemhlbiIsCUIxOTIwMCwgQ1M4LCAJCQlTRVJJT19aSEVOSFVBLAkwLAkw
LAkwLAl6aGVuaHVhX2luaXQgfSwKIHsgIi0tZHVtcCIsCQkiLWR1bXAiLAlCMjQwMCwgQ1M4LCAJ
CQkwLAkJMCwJMCwJMCwJZHVtcF9pbml0IH0sCiB7ICIiLCAiIiwgMCwgMCB9CiAKQEAgLTQxNiw2
ICs0NTQsNyBAQAogCQlwdXRzKCIgIC0tcHMyc2Vya2JkICAgICAtcHMyc2VyIFBTLzIgdmlhIHNl
cmlhbCBrZXlib2FyZCIpOwogCQlwdXRzKCIgIC0tdHdpZGRsZXIgICAgICAtdHdpZCAgIEhhbmR5
a2V5IFR3aWRkbGVyIGNob3JkaW5nIGtleWJvYXJkIik7CiAJCXB1dHMoIiAgLS10d2lkZGxlci1q
b3kgIC10d2lkam95ICBIYW5keWtleSBUd2lkZGxlciB1c2VkIGFzIGEgam95c3RpY2siKTsKKwkJ
cHV0cygiICAtLXpoZW4taHVhICAgICAgLXpoZW4gIFpoZW4gSHVhIDUtYnl0ZSBwcm90b2NvbCIp
OwogCQlwdXRzKCIiKTsKICAgICAgICAgICAgICAgICByZXR1cm4gMTsKICAgICAgICAgfQo=
------=_Part_16764_21665641.1202921538229--
