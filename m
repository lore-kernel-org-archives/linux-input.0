From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Thu, 7 Oct 2010 19:19:57 +0400
Message-ID: <AANLkTimZxi8V9SLFQ8N-oSDTSt+7PjLNPt=H=Ja2mpr9@mail.gmail.com>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
	<AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
	<20100930062547.GF5260@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00c09f9db08a5c310c0492086d21
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56958 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab0JGPT7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Oct 2010 11:19:59 -0400
Received: by qyk29 with SMTP id 29so181991qyk.19
        for <linux-input@vger.kernel.org>; Thu, 07 Oct 2010 08:19:59 -0700 (PDT)
In-Reply-To: <20100930062547.GF5260@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

--00c09f9db08a5c310c0492086d21
Content-Type: text/plain; charset=ISO-8859-1

Hello,

On Thu, Sep 30, 2010 at 10:25 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Sep 29, 2010 at 04:45:53PM +0400, Dmitry Eremin-Solenikov wrote:
>> On Thu, Sep 23, 2010 at 8:44 PM, Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com> wrote:
>> > PS2Mult is a simple serial protocol used for multiplexing several PS/2 streams
>> > into one serial data stream. It's used e.g. on TQM85xx serie of boards.
>> >
>> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> > ---
>> >
>> > It actually depends on "serio: multiple children" patch. I'm not resending it
>> > as you were the originator of the latest version of the patch.
>>
>> So, what about this version of patch?
>>
>
> Looks better but I think you also need ->start() to make sure you do not
> try to deliver events too early. Does the following still work for you?

Sorry for the delay. Crashes w/o the attached patch.

-- 
With best wishes
Dmitry

--00c09f9db08a5c310c0492086d21
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ps2mult-don-t-try-to-register-empty-serio-pointers.patch"
Content-Disposition: attachment;
	filename="0001-ps2mult-don-t-try-to-register-empty-serio-pointers.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gezrwd9g0

RnJvbSBmMzMwN2U2NjkzZTA0Mjg1YzViZTZjOWRjZjNhYWJjMDkxZjQ3Njg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEbWl0cnkgRXJlbWluLVNvbGVuaWtvdiA8ZGJhcnlzaGtvdkBn
bWFpbC5jb20+CkRhdGU6IFRodSwgNyBPY3QgMjAxMCAxODozMjoyNiArMDQwMApTdWJqZWN0OiBb
UEFUQ0hdIHBzMm11bHQ6IGRvbid0IHRyeSB0byByZWdpc3RlciBlbXB0eSBzZXJpbyBwb2ludGVy
cwoKU2lnbmVkLW9mZi1ieTogRG1pdHJ5IEVyZW1pbi1Tb2xlbmlrb3YgPGRiYXJ5c2hrb3ZAZ21h
aWwuY29tPgotLS0KIGRyaXZlcnMvaW5wdXQvc2VyaW8vcHMybXVsdC5jIHwgICAgMyAtLS0KIDEg
ZmlsZXMgY2hhbmdlZCwgMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5wdXQvc2VyaW8vcHMybXVsdC5jIGIvZHJpdmVycy9pbnB1dC9zZXJpby9w
czJtdWx0LmMKaW5kZXggMzY2NDM5OC4uMTUzNDFkMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1
dC9zZXJpby9wczJtdWx0LmMKKysrIGIvZHJpdmVycy9pbnB1dC9zZXJpby9wczJtdWx0LmMKQEAg
LTE5Niw5ICsxOTYsNiBAQCBzdGF0aWMgaW50IHBzMm11bHRfY29ubmVjdChzdHJ1Y3Qgc2VyaW8g
KnNlcmlvLCBzdHJ1Y3Qgc2VyaW9fZHJpdmVyICpkcnYpCiAKIAlwczJtdWx0X3Jlc2V0KHBzbSk7
CiAKLQlmb3IgKGkgPSAwOyBpIDwgIFBTMk1VTFRfTlVNX1BPUlRTOyBpKyspCi0JCXNlcmlvX3Jl
Z2lzdGVyX3BvcnQocHNtLT5wb3J0c1tpXS5zZXJpbyk7Ci0KIAlyZXR1cm4gMDsKIAogZXJyX291
dDoKLS0gCjEuNy4xCgo=
--00c09f9db08a5c310c0492086d21--
