From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Fri, 22 Oct 2010 00:54:45 +0400
Message-ID: <AANLkTimhssEEG+ddDULfmLsetMCsWUg13itoDysupug_@mail.gmail.com>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
	<AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
	<20100930062547.GF5260@core.coreip.homeip.net>
	<AANLkTimZxi8V9SLFQ8N-oSDTSt+7PjLNPt=H=Ja2mpr9@mail.gmail.com>
	<20101007163606.GA24406@core.coreip.homeip.net>
	<AANLkTinBLr6ETMxBzDCZog9qLPRwUsutS=QaKDQC-sA7@mail.gmail.com>
	<20101014142347.GA18011@core.coreip.homeip.net>
	<4CBC2E83.70308@gmail.com>
	<20101018155626.GB10559@core.coreip.homeip.net>
	<20101018161152.GC10559@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636832f2c64ef40049326bc3a
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42870 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0JUUyq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Oct 2010 16:54:46 -0400
Received: by wwe15 with SMTP id 15so35755wwe.1
        for <linux-input@vger.kernel.org>; Thu, 21 Oct 2010 13:54:45 -0700 (PDT)
In-Reply-To: <20101018161152.GC10559@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

--001636832f2c64ef40049326bc3a
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 18, 2010 at 8:11 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> BTW, is there corresponding patches to inputattach?
>

Attached.


-- 
With best wishes
Dmitry

--001636832f2c64ef40049326bc3a
Content-Type: application/octet-stream; name="support-ps2mult.patch"
Content-Disposition: attachment; filename="support-ps2mult.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfk41n2j0

SW5kZXg6IGpveXN0aWNrLTIwMDUxMDE5L3V0aWxzL2lucHV0YXR0YWNoLmMKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gam95c3RpY2stMjAwNTEwMTkub3JpZy91dGlscy9pbnB1dGF0dGFjaC5jCTIwMTAtMDctMTUg
MTY6MjI6NDIuMDU1MDA2NjQyICswNDAwCisrKyBqb3lzdGljay0yMDA1MTAxOS91dGlscy9pbnB1
dGF0dGFjaC5jCTIwMTAtMDctMTUgMTY6MjI6NDUuMjQzMDA1Mzk4ICswNDAwCkBAIC01MzYsNiAr
NTM2LDkgQEAKIHsgIi0tZnVqaXRzdSIsCQkiLWZqdCIsCSJGdWppdHN1IHNlcmlhbCB0b3VjaHNj
cmVlbiIsCiAJQjk2MDAsIENTOCwKIAlTRVJJT19GVUpJVFNVLAkJMHgwMCwJMHgwMCwJMSwJZnVq
aXRzdV9pbml0IH0sCit7ICItLXBzMm11bHQiLAkiLXBzMm0iLAkiUFMvMiBzZXJpYWwgbXVsdGlw
bGV4ZXIiLAorCUI1NzYwMCwgQ1M4LAorCVNFUklPX1BTMk1VTFQsCQkweDAwLAkweDAwLAkxLAlO
VUxMIH0sCiB7ICItLWR1bXAiLAkJIi1kdW1wIiwJIkp1c3QgZW5hYmxlIGRldmljZSIsCiAJQjI0
MDAsIENTOCwKIAkwLAkJCTB4MDAsCTB4MDAsCTAsCWR1bXBfaW5pdCB9LApJbmRleDogam95c3Rp
Y2stMjAwNTEwMTkvdXRpbHMvc2VyaW8taWRzLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gam95c3RpY2stMjAw
NTEwMTkub3JpZy91dGlscy9zZXJpby1pZHMuaAkyMDEwLTA3LTE1IDE2OjIwOjU4LjY1OTAwNTYw
MiArMDQwMAorKysgam95c3RpY2stMjAwNTEwMTkvdXRpbHMvc2VyaW8taWRzLmgJMjAxMC0wNy0x
NSAxNjoyMToxNy4wMDcwMDczOTcgKzA0MDAKQEAgLTEyMiw1ICsxMjIsOCBAQAogI2lmbmRlZiBT
RVJJT19XODAwMQogIyBkZWZpbmUgU0VSSU9fVzgwMDEJCTB4MzkKICNlbmRpZgorI2lmbmRlZiBT
RVJJT19QU01VTFQKKyMgZGVmaW5lIFNFUklPX1BTMk1VTFQJCTB4M2MKKyNlbmRpZgogCiAjZW5k
aWYK
--001636832f2c64ef40049326bc3a--
