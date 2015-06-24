From: =?UTF-8?Q?Eric_Fargas_Esp=C3=ADn?= <efargaspro@gmail.com>
Subject: Fwd: adxl345 patches
Date: Thu, 25 Jun 2015 00:29:10 +0200
Message-ID: <CALSxS=gvAU+RiZkrBi0xU5_akryw7BUWA6PERxGL5ho6Dcij2A@mail.gmail.com>
References: <CALSxS=hDUMaYXvxCE+hh9+ZXKRpsNzAo9hR1-ntjw_FW7nVuEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c368cc308a1405194b0913
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:35540 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbbFXW3M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 18:29:12 -0400
Received: by lagi2 with SMTP id i2so34551916lag.2
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2015 15:29:11 -0700 (PDT)
In-Reply-To: <CALSxS=hDUMaYXvxCE+hh9+ZXKRpsNzAo9hR1-ntjw_FW7nVuEQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--001a11c368cc308a1405194b0913
Content-Type: text/plain; charset=UTF-8

This patches add module alias, usefull to load driver with DTS on beaglebone

--001a11c368cc308a1405194b0913
Content-Type: application/octet-stream; name="adxl34x_c.patch"
Content-Disposition: attachment; filename="adxl34x_c.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ibbbsxxm0

LS0tIGEvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHguYwkyMDEzLTA1LTExIDIyOjU3OjQ2LjAw
MDAwMDAwMCArMDIwMAorKysgYi9kcml2ZXJzL2lucHV0L21pc2MvYWR4bDM0eC5jCTIwMTUtMDUt
MTQgMTU6MjU6NDkuNjU2MjUwNzc0ICswMjAwCkBAIC05MTMsMyArOTEzLDQgQEAKIE1PRFVMRV9B
VVRIT1IoIk1pY2hhZWwgSGVubmVyaWNoIDxoZW5uZXJpY2hAYmxhY2tmaW4udWNsaW51eC5vcmc+
Iik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIkFEWEwzNDUvMzQ2IFRocmVlLUF4aXMgRGlnaXRhbCBB
Y2NlbGVyb21ldGVyIERyaXZlciIpOwogTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOworTU9EVUxFX0FM
SUFTKCJtaXNjOmFkeGwzNHgiKTsK
--001a11c368cc308a1405194b0913
Content-Type: application/octet-stream; name="adxl34x_i2c_c.patch"
Content-Disposition: attachment; filename="adxl34x_i2c_c.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ibbbsxy61

LS0tIGEvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHgtaTJjLmMJMjAxMy0wNS0xMSAyMjo1Nzo0
Ni4wMDAwMDAwMDAgKzAyMDAKKysrIGIvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHgtaTJjLmMJ
MjAxNS0wNS0xNCAxNToyNTo0OS42NTgyMDM4OTkgKzAyMDAKQEAgLTE1MywzICsxNTMsNCBAQAog
TU9EVUxFX0FVVEhPUigiTWljaGFlbCBIZW5uZXJpY2ggPGhlbm5lcmljaEBibGFja2Zpbi51Y2xp
bnV4Lm9yZz4iKTsKIE1PRFVMRV9ERVNDUklQVElPTigiQURYTDM0NS8zNDYgVGhyZWUtQXhpcyBE
aWdpdGFsIEFjY2VsZXJvbWV0ZXIgSTJDIEJ1cyBEcml2ZXIiKTsKIE1PRFVMRV9MSUNFTlNFKCJH
UEwiKTsKK01PRFVMRV9BTElBUygiaTJjOmFkeGwzNHgiKTsK
--001a11c368cc308a1405194b0913
Content-Type: application/octet-stream; name="adxl34x_spi_c.patch"
Content-Disposition: attachment; filename="adxl34x_spi_c.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ibbbsxyd2

LS0tIGEvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHgtc3BpLmMJMjAxMy0wNS0xMSAyMjo1Nzo0
Ni4wMDAwMDAwMDAgKzAyMDAKKysrIGIvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHgtc3BpLmMJ
MjAxNS0wNi0yMCAwMTo0MzoxMy40NzIyNzMwMjEgKzAyMDAKQEAgLTEzMSw2ICsxMzEsMTYgQEAK
IAogbW9kdWxlX3NwaV9kcml2ZXIoYWR4bDM0eF9kcml2ZXIpOwogCitzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNwaV9kZXZpY2VfaWQgYWR4bDM0eF9pZFtdID0geworCXsgImFkeGwzNHgiLCAwIH0sCisJ
eyB9Cit9OworCitNT0RVTEVfREVWSUNFX1RBQkxFKHNwaSwgYWR4bDM0eF9pZCk7CisKIE1PRFVM
RV9BVVRIT1IoIk1pY2hhZWwgSGVubmVyaWNoIDxoZW5uZXJpY2hAYmxhY2tmaW4udWNsaW51eC5v
cmc+Iik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIkFEWEwzNDUvMzQ2IFRocmVlLUF4aXMgRGlnaXRh
bCBBY2NlbGVyb21ldGVyIFNQSSBCdXMgRHJpdmVyIik7CiBNT0RVTEVfTElDRU5TRSgiR1BMIik7
CitNT0RVTEVfQUxJQVMoInNwaTphZHhsMzR4Iik7CisKKwo=
--001a11c368cc308a1405194b0913--
