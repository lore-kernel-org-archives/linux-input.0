From: Sadrul Chowdhury <sadrul@chromium.org>
Subject: [PATCH] input-mt: Allow -1 for tracking id
Date: Thu, 14 Apr 2011 18:13:17 -0400
Message-ID: <BANLkTimcCh7MbmxtuzTCEFyT28FHZU+ijw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504501716fa50a2204a0e83c2d
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:53615 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab1DNWNj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Apr 2011 18:13:39 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id p3EMDcoK019724
	for <linux-input@vger.kernel.org>; Thu, 14 Apr 2011 15:13:38 -0700
Received: from iwn33 (iwn33.prod.google.com [10.241.68.97])
	by wpaz1.hot.corp.google.com with ESMTP id p3EMDE8a021685
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 14 Apr 2011 15:13:37 -0700
Received: by iwn33 with SMTP id 33so3040149iwn.27
        for <linux-input@vger.kernel.org>; Thu, 14 Apr 2011 15:13:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--00504501716fa50a2204a0e83c2d
Content-Type: text/plain; charset=UTF-8

In protocol B, the tracking ID can be set to -1. But since the min
value is set to 0, the clients don't receive a -1 when a contact is
lifted. The attached patch sets the min to -1 to fix this issue.

Cheers.
Sadrul

--00504501716fa50a2204a0e83c2d
Content-Type: text/x-patch; charset=US-ASCII; name="0001-mt-Allow-1-for-tracking-id.patch"
Content-Disposition: attachment;
	filename="0001-mt-Allow-1-for-tracking-id.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmi8snvu0

RnJvbSBkYzVmMzk4MTFiZmQyMTQwOTg1M2ZiNGY1MDQ3ZjJhYzQ3NjE4Yzc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWRydWwgSGFiaWIgQ2hvd2RodXJ5IDxzYWRydWxAY2hyb21p
dW0ub3JnPgpEYXRlOiBUaHUsIDE0IEFwciAyMDExIDE3OjQyOjI3IC0wNDAwClN1YmplY3Q6IFtQ
QVRDSF0gaW5wdXQtbXQ6IEFsbG93IC0xIGZvciB0cmFja2luZyBpZC4KClRoZSB0cmFja2luZyBp
ZCBzZXQgdG8gLTEgd2hlbiBhIHNsb3QgaXMgcmVsZWFzZWQuIFNvIGFsbG93IHRoZSBtaW5pbXVt
CnZhbHVlIHRvIHJlYWNoIC0xLgoKQ2hhbmdlLUlkOiBJOGZmZWFlZDcwZmQ0ODI0ZDU3NzhhZDJm
MmQ3YmM0NjcxNTc4ODdmYwoKU2lnbmVkLW9mZi1ieTogU2FkcnVsIEhhYmliIENob3dkaHVyeSA8
c2FkcnVsQGNocm9taXVtLm9yZz4KLS0tCiBkcml2ZXJzL2lucHV0L2lucHV0LW10LmMgfCAgICAy
ICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2lucHV0LW10LmMgYi9kcml2ZXJzL2lucHV0L2lucHV0
LW10LmMKaW5kZXggYzQ4YzgxZi4uNWZiMTFlNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9p
bnB1dC1tdC5jCisrKyBiL2RyaXZlcnMvaW5wdXQvaW5wdXQtbXQuYwpAQCAtMzksNyArMzksNyBA
QCBpbnQgaW5wdXRfbXRfaW5pdF9zbG90cyhzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYsIHVuc2lnbmVk
IGludCBudW1fc2xvdHMpCiAKIAlkZXYtPm10c2l6ZSA9IG51bV9zbG90czsKIAlpbnB1dF9zZXRf
YWJzX3BhcmFtcyhkZXYsIEFCU19NVF9TTE9ULCAwLCBudW1fc2xvdHMgLSAxLCAwLCAwKTsKLQlp
bnB1dF9zZXRfYWJzX3BhcmFtcyhkZXYsIEFCU19NVF9UUkFDS0lOR19JRCwgMCwgVFJLSURfTUFY
LCAwLCAwKTsKKwlpbnB1dF9zZXRfYWJzX3BhcmFtcyhkZXYsIEFCU19NVF9UUkFDS0lOR19JRCwg
LTEsIFRSS0lEX01BWCwgMCwgMCk7CiAJaW5wdXRfc2V0X2V2ZW50c19wZXJfcGFja2V0KGRldiwg
NiAqIG51bV9zbG90cyk7CiAKIAkvKiBNYXJrIHNsb3RzIGFzICd1bnVzZWQnICovCi0tIAoxLjcu
Mi4zCgo=
--00504501716fa50a2204a0e83c2d--
