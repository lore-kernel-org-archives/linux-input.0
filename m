From: Marcos Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH 1/2] input/serio/i8042: Skip selftest on i8042 controller
 in some ASUS laptops
Date: Tue, 26 Jul 2016 22:13:50 -0300
Message-ID: <CAH0vN5JonW+PWTS4mY9Jiwp60DuMQsiYCPnrgu+i5YFgU764rA@mail.gmail.com>
References: <1469467222-2382-1-git-send-email-marcos.souza.org@gmail.com>
 <20160725182237.GC27415@dtor-ws> <CAH0vN5KRM+KWirV+cp=ANg3=YVFCPzvW-E2T=KQWhm_u5xs5jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11398802f13a4f053893ba66
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33138 "EHLO
	mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbcG0BNw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2016 21:13:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id j37so1087262qta.0
        for <linux-input@vger.kernel.org>; Tue, 26 Jul 2016 18:13:51 -0700 (PDT)
In-Reply-To: <CAH0vN5KRM+KWirV+cp=ANg3=YVFCPzvW-E2T=KQWhm_u5xs5jg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN),
	linux-kernel@vger.kernel.org (open list)" <linux-input@vger.kernel.org>

--001a11398802f13a4f053893ba66
Content-Type: text/plain; charset=UTF-8

Hi Dmitry,

On Mon, Jul 25, 2016 at 3:48 PM, Marcos Souza
<marcos.souza.org@gmail.com> wrote:
> Hi Dmitry,
>
> On Mon, Jul 25, 2016 at 3:22 PM Dmitry Torokhov <dmitry.torokhov@gmail.com>
> wrote:
>>
>> [ resending to all - mutt is for some reason confused about recipent
>> list ]
>> On Mon, Jul 25, 2016 at 02:20:16PM -0300, Marcos Paulo de Souza wrote:
>> > On suspend/resume cycle, selftest is executed on to reset i8042
>> > controller. But
>> > when this is done in these devices, posterior calls to detect/init
>> > functions
>> > to elantech driver fails. Skipping selftest fixes this problem.
>> >
>> > An easier step to reproduce this problem is adding i8042.reset=1 as a
>> > kernel
>> > parameter. On problematic laptops, it'll make the system to start with
>> > the
>> > touchpad already stucked, since psmouse_probe forcibly calls the
>> > selftest function.
>> >
>> > This patch was inspired by John Hiesey's change[1].
>> >
>> > [1]: https://marc.info/?l=linux-input&m=144312209020616&w=2
>> >
>> > Fixes: "ETPS/2 Elantech Touchpad dies after resume from suspend"
>> > (https://bugzilla.kernel.org/show_bug.cgi?id=7739)
>>
>> *sigh* You just cant win, they'll manage to mess up the firmware one way
>> or another :( Witness:
>
>
> They're experts on messing things up :(
>
>>
>>
>> "
>> commit 1ca56e513a9fd356d5a9e0de45dbe0e189e00386
>> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Date:   Tue Jul 20 20:25:34 2010 -0700
>>
>>     Input: i8042 - reset keyboard controller wehen resuming from S2R
>>
>>     Some laptops, such as Lenovo 3000 N100, require keyboard controller
>> reset
>>     in order to have touchpad operable after suspend to RAM. Even if box
>> does
>>     not need the reset it should be safe to do so, so instead of chasing
>>     after misbehaving boxes and grow DMI tables, let's reset the
>> controller
>>     unconditionally.
>>
>>     Reported-and-tested-by: Jerome Lacoste <jerome.lacoste@gmail.com>
>>     Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> "
>>
>> so apparently it is not safe to reset the controller on resume. Oh joy.
>>
>> The issue I have here is selftest is the same as reset, and we already
>> have i8042_reset flag, so 2 flags controlling the same functionality is
>> not great. Could we extend i8042 to an enum, like:
>>
>> I8042_RESET_ALWAYS
>> I8042_RESET_NEVER
>> I8042_RESET_ON_RESUME (default)
>>
>> and have a custom module parameter for it?
>>
>> i8042.reset and i8042_reset={1|Y|y} would result in I8042_RESET_ALWAYS
>> i8042.reset={0|N|n} would result in I8042_RESET_NEVER
>> Without i8042.reset we just reset it when resuming from S3.
>>
>> What do you think?
>
>
> Seems to be a very good approach. I'll send a new version.

You asked me to adapt my previous patch, making it accept:

i8042.reset
i8042.reset={1,y,Y}
i8042.reset={0,n,N}

But, when using a charp as module parameter, it doesn't allocate
memory to i8042_reset when we don't use the equal sign. So, in this
case I can't tell if the user is using i8042.reset, or don't any
parameter (in this case it means to use I8042_RESET_ON_RESUME)

So, in this case, should we just change i8042.reset to accept 1,y,n?
This should solve the problem too (although I think people who already
use such parameter will complain...)

What do you think?

I attached my current diff here, by using a new kernel parameter
reset_mode. Besides the new parameter,It works great if I remove the
comment about the ASUS DMI info.

Thanks,

>
>>
>>
>> Thanks.
>>
>> --
>> Dmitry



-- 
Att,

Marcos Paulo de Souza
Github: https://github.com/marcosps/

--001a11398802f13a4f053893ba66
Content-Type: text/x-patch; charset=US-ASCII; name="i8042_controller_reset_fix.patch"
Content-Disposition: attachment; filename="i8042_controller_reset_fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ir475o1z0

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24va2VybmVsLXBhcmFtZXRlcnMudHh0IGIvRG9jdW1l
bnRhdGlvbi9rZXJuZWwtcGFyYW1ldGVycy50eHQKaW5kZXggODJiNDJjOS4uYWMwZDVjZCAxMDA2
NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9rZXJuZWwtcGFyYW1ldGVycy50eHQKKysrIGIvRG9jdW1l
bnRhdGlvbi9rZXJuZWwtcGFyYW1ldGVycy50eHQKQEAgLTE0MzEsNiArMTQzMSwxMyBAQCBieXRl
cyByZXNwZWN0aXZlbHkuIFN1Y2ggbGV0dGVyIHN1ZmZpeGVzIGNhbiBhbHNvIGJlIGVudGlyZWx5
IG9taXR0ZWQuCiAJCQkgICAgIGNvbnRyb2xsZXJzCiAJaTgwNDIubm90aW1lb3V0CVtIV10gSWdu
b3JlIHRpbWVvdXQgY29uZGl0aW9uIHNpZ25hbGxlZCBieSBjb250cm9sbGVyCiAJaTgwNDIucmVz
ZXQJW0hXXSBSZXNldCB0aGUgY29udHJvbGxlciBkdXJpbmcgaW5pdCBhbmQgY2xlYW51cAorCWk4
MDQyLnJlc2V0X21vZGUKKwkJCVtIV10gUmVzZXQgdGhlIGNvbnRyb2xsZXIsIGFsd2F5cywgbmV2
ZXIgb3IganVzdCBvbgorCQkJcmVzdW1lCisJCQlGb3JtYXQ6IHsgMSB8IFkgfCB5IHwgMCB8IE4g
fCBuIH0KKwkJCTEsIFksIHk6IEFsd2F5cyByZXNldCBjb250cm9sbGVyIChzYW1lIGFzIHRoZSBp
ODA0Mi5yZXNldCkKKwkJCTAsIE4sIG46IE5ldmVyIHJlc2V0IGNvbnRyb2xsZXIKKwkJCURlZmF1
bHQ6IEp1c3QgcmVzZXQgb24gUzMgcmVzdW1lCiAJaTgwNDIudW5sb2NrCVtIV10gVW5sb2NrIChp
Z25vcmUpIHRoZSBrZXlsb2NrCiAJaTgwNDIua2JkcmVzZXQgIFtIV10gUmVzZXQgZGV2aWNlIGNv
bm5lY3RlZCB0byBLQkQgcG9ydAogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3NlcmlvL2k4
MDQyLXg4NmlhNjRpby5oIGIvZHJpdmVycy9pbnB1dC9zZXJpby9pODA0Mi14ODZpYTY0aW8uaApp
bmRleCA2OGY1ZjRhLi40MGE3OGQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L3NlcmlvL2k4
MDQyLXg4NmlhNjRpby5oCisrKyBiL2RyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDIteDg2aWE2NGlv
LmgKQEAgLTUxMCw2ICs1MTAsNjAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lk
IF9faW5pdGNvbnN0IGk4MDQyX2RtaV9ub211eF90YWJsZVtdID0gewogCXsgfQogfTsKIAorLyoK
KyAqIE9uIHNvbWUgaGFyZHdhcmUganVzdCBydW5uaW5nIHRoZSBzZWxmIHRlc3QgY2F1c2VzIHBy
b2JsZW1zLgorICovCitzdGF0aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgX19pbml0Y29u
c3QgaTgwNDJfZG1pX25vc2VsZnRlc3RfdGFibGVbXSA9IHsKKwl7CisJCS5tYXRjaGVzID0gewor
CQkJRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiQVNVU1RlSyBDT01QVVRFUiBJTkMuIiksCisJ
CQlETUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFNRSwgIks0MDFMQiIpLAorCQl9LAorCX0sCisJewor
CQkubWF0Y2hlcyA9IHsKKwkJCURNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwgIkFTVVNUZUsgQ09N
UFVURVIgSU5DLiIpLAorCQkJRE1JX01BVENIKERNSV9QUk9EVUNUX05BTUUsICJLNTAxTFgiKSwK
KwkJfSwKKwl9LAorCXsKKwkJLm1hdGNoZXMgPSB7CisJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5E
T1IsICJBU1VTVGVLIENPTVBVVEVSIElOQy4iKSwKKwkJCURNSV9NQVRDSChETUlfUFJPRFVDVF9O
QU1FLCAiSzUwMUxEIiksCisJCX0sCisJfSwKKwl7CisJCS5tYXRjaGVzID0geworCQkJRE1JX01B
VENIKERNSV9TWVNfVkVORE9SLCAiQVNVU1RlSyBDT01QVVRFUiBJTkMuIiksCisJCQlETUlfTUFU
Q0goRE1JX1BST0RVQ1RfTkFNRSwgIlgzMDJMQSIpLAorCQl9LAorCX0sCisJeworCQkubWF0Y2hl
cyA9IHsKKwkJCURNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwgIkFTVVNUZUsgQ09NUFVURVIgSU5D
LiIpLAorCQkJRE1JX01BVENIKERNSV9QUk9EVUNUX05BTUUsICJYNDUwTENQIiksCisJCX0sCisJ
fSwKKwl7CisJCS5tYXRjaGVzID0geworCQkJRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiQVNV
U1RlSyBDT01QVVRFUiBJTkMuIiksCisJCQlETUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFNRSwgIlg0
NTBMRCIpLAorCQl9LAorCX0sCisJeworCQkubWF0Y2hlcyA9IHsKKwkJCURNSV9NQVRDSChETUlf
U1lTX1ZFTkRPUiwgIkFTVVNUZUsgQ09NUFVURVIgSU5DLiIpLAorCQkJRE1JX01BVENIKERNSV9Q
Uk9EVUNUX05BTUUsICJYNDU1TEFCIiksCisJCX0sCisJfSwKKwl7CisJCS5tYXRjaGVzID0gewor
CQkJRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiQVNVU1RlSyBDT01QVVRFUiBJTkMuIiksCisJ
CQlETUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFNRSwgIlg0NTVMREIiKSwKKwkJfSwKKwl9LAorCXsg
fQorfTsKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBfX2luaXRjb25zdCBpODA0
Ml9kbWlfcmVzZXRfdGFibGVbXSA9IHsKIAl7CiAJCS8qIE1TSSBXaW5kIFUtMTAwICovCkBAIC0x
MDc3LDcgKzExMzEsMTEgQEAgc3RhdGljIGludCBfX2luaXQgaTgwNDJfcGxhdGZvcm1faW5pdCh2
b2lkKQogCiAjaWZkZWYgQ09ORklHX1g4NgogCWlmIChkbWlfY2hlY2tfc3lzdGVtKGk4MDQyX2Rt
aV9yZXNldF90YWJsZSkpCi0JCWk4MDQyX3Jlc2V0ID0gdHJ1ZTsKKwkJaTgwNDJfcmVzZXRfbW9k
ZSA9IEk4MDQyX1JFU0VUX0FMV0FZUzsKKworCS8vIGp1c3QgZGlzYWJsZSBjb250cm9sbGVyIHJl
c2V0CisJLy9pZiAoZG1pX2NoZWNrX3N5c3RlbShpODA0Ml9kbWlfbm9zZWxmdGVzdF90YWJsZSkp
CisJLy8JaTgwNDJfcmVzZXRfbW9kZSA9IEk4MDQyX1JFU0VUX05FVkVSOwogCiAJaWYgKGRtaV9j
aGVja19zeXN0ZW0oaTgwNDJfZG1pX25vbG9vcF90YWJsZSkpCiAJCWk4MDQyX25vbG9vcCA9IHRy
dWU7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLmMgYi9kcml2ZXJzL2lu
cHV0L3NlcmlvL2k4MDQyLmMKaW5kZXggNDU0MTk1Ny4uY2ZjMTU5MCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9pbnB1dC9zZXJpby9pODA0Mi5jCisrKyBiL2RyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDIu
YwpAQCAtNTIsNiArNTIsMTcgQEAgc3RhdGljIGJvb2wgaTgwNDJfcmVzZXQ7CiBtb2R1bGVfcGFy
YW1fbmFtZWQocmVzZXQsIGk4MDQyX3Jlc2V0LCBib29sLCAwKTsKIE1PRFVMRV9QQVJNX0RFU0Mo
cmVzZXQsICJSZXNldCBjb250cm9sbGVyIGR1cmluZyBpbml0IGFuZCBjbGVhbnVwLiIpOwogCitl
bnVtIGk4MDQyX2NvbnRyb2xsZXJfcmVzZXRfbW9kZSB7CisJSTgwNDJfUkVTRVRfTkVWRVIsCisJ
STgwNDJfUkVTRVRfQUxXQVlTLAorCUk4MDQyX1JFU0VUX09OX1JFU1VNRQorfTsKKworc3RhdGlj
IHVuc2lnbmVkIGludCBpODA0Ml9yZXNldF9tb2RlID0gSTgwNDJfUkVTRVRfT05fUkVTVU1FOwor
c3RhdGljIGNoYXIgKmk4MDQyX3Jlc2V0X3BhcmFtOworbW9kdWxlX3BhcmFtX25hbWVkKHJlc2V0
X21vZGUsIGk4MDQyX3Jlc2V0X3BhcmFtLCBjaGFycCwgMCk7CitNT0RVTEVfUEFSTV9ERVNDKHJl
c2V0X21vZGUsICJSZXNldCBjb250cm9sbGVyIG1vZGUsIGJlaW5nIGFsd2F5cywgbmV2ZXIgb3Ig
anVzdCBvbiByZXN1bWUiKTsKKwogc3RhdGljIGJvb2wgaTgwNDJfZGlyZWN0OwogbW9kdWxlX3Bh
cmFtX25hbWVkKGRpcmVjdCwgaTgwNDJfZGlyZWN0LCBib29sLCAwKTsKIE1PRFVMRV9QQVJNX0RF
U0MoZGlyZWN0LCAiUHV0IGtleWJvYXJkIHBvcnQgaW50byBub24tdHJhbnNsYXRlZCBtb2RlLiIp
OwpAQCAtODkwLDYgKzkwMSw5IEBAIHN0YXRpYyBpbnQgaTgwNDJfY29udHJvbGxlcl9zZWxmdGVz
dCh2b2lkKQogCXVuc2lnbmVkIGNoYXIgcGFyYW07CiAJaW50IGkgPSAwOwogCisJaWYgKGk4MDQy
X3Jlc2V0X21vZGUgPT0gSTgwNDJfUkVTRVRfTkVWRVIpCisJCXJldHVybiAwOworCiAJLyoKIAkg
KiBXZSB0cnkgdGhpcyA1IHRpbWVzOyBvbiBzb21lIHJlYWxseSBmcmFnaWxlIHN5c3RlbXMgdGhp
cyBkb2VzIG5vdAogCSAqIHRha2UgdGhlIGZpcnN0IHRpbWUuLi4KQEAgLTE0OTUsNyArMTUwOSwy
MCBAQCBzdGF0aWMgaW50IF9faW5pdCBpODA0Ml9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpkZXYpCiAKIAlpODA0Ml9wbGF0Zm9ybV9kZXZpY2UgPSBkZXY7CiAKLQlpZiAoaTgwNDJfcmVz
ZXQpIHsKKwlpZiAoaTgwNDJfcmVzZXRfcGFyYW0gIT0gTlVMTCkgeworCQlpZiAoIXN0cm5jbXAo
aTgwNDJfcmVzZXRfcGFyYW0sICIxIiwgMSkKKwkJCXx8ICFzdHJuY2FzZWNtcChpODA0Ml9yZXNl
dF9wYXJhbSwgInkiLCAxKSkgeworCQkJaTgwNDJfcmVzZXRfbW9kZSA9IEk4MDQyX1JFU0VUX0FM
V0FZUzsKKwkJfSBlbHNlIGlmICghc3RybmNtcChpODA0Ml9yZXNldF9wYXJhbSwgIjAiLCAxKQor
CQkJfHwgIXN0cm5jYXNlY21wKGk4MDQyX3Jlc2V0X3BhcmFtLCAibiIsIDEpKSB7CisJCQlpODA0
Ml9yZXNldF9tb2RlID0gSTgwNDJfUkVTRVRfTkVWRVI7CisJCX0KKwl9CisKKwlpZiAoaTgwNDJf
cmVzZXQpCisJCWk4MDQyX3Jlc2V0X21vZGUgPSBJODA0Ml9SRVNFVF9BTFdBWVM7CisKKwlpZiAo
aTgwNDJfcmVzZXRfbW9kZSA9PSBJODA0Ml9SRVNFVF9BTFdBWVMpIHsKIAkJZXJyb3IgPSBpODA0
Ml9jb250cm9sbGVyX3NlbGZ0ZXN0KCk7CiAJCWlmIChlcnJvcikKIAkJCXJldHVybiBlcnJvcjsK
--001a11398802f13a4f053893ba66--
