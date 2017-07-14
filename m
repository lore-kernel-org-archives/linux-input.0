From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/14] Input: adxl34x - fix gcc-7 -Wint-in-bool-context warning
Date: Fri, 14 Jul 2017 11:25:20 +0200
Message-ID: <20170714092540.1217397-9-arnd@arndb.de>
References: <20170714092540.1217397-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170714092540.1217397-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

RklGT19NT0RFIGlzIGFuIG1hY3JvIGV4cHJlc3Npb24gd2l0aCBhICc8PCcgb3BlcmF0b3IsIHdo
aWNoCmdjYyBwb2ludHMgb3V0IGNvdWxkIGJlIG1pc3JlYWQgYXMgYSAnPCc6Cgpkcml2ZXJzL2lu
cHV0L21pc2MvYWR4bDM0eC5jOiBJbiBmdW5jdGlvbiAnYWR4bDM0eF9wcm9iZSc6CmRyaXZlcnMv
aW5wdXQvbWlzYy9hZHhsMzR4LmM6Nzk5OjM2OiBlcnJvcjogJzw8JyBpbiBib29sZWFuIGNvbnRl
eHQsIGRpZCB5b3UgbWVhbiAnPCcgPyBbLVdlcnJvcj1pbnQtaW4tYm9vbC1jb250ZXh0XQoKVGhp
cyBjb252ZXJ0cyB0aGUgdGVzdCB0byBhbiBleHBsaWNpdCBjb21wYXJpc29uIHdpdGggemVybywK
bWFraW5nIGl0IGNsZWFyZXIgdG8gZ2NjIGFuZCB0aGUgcmVhZGVyIHdoYXQgaXMgaW50ZW5kZWQu
CgpGaXhlczogZTI3YzcyOTIxOWFkICgiSW5wdXQ6IGFkZCBkcml2ZXIgZm9yIEFEWEwzNDUvMzQ2
IERpZ2l0YWwgQWNjZWxlcm9tZXRlcnMiKQpTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxh
cm5kQGFybmRiLmRlPgotLS0KIGRyaXZlcnMvaW5wdXQvbWlzYy9hZHhsMzR4LmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lucHV0L21pc2MvYWR4bDM0eC5jIGIvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwz
NHguYwppbmRleCAyYjJkMDJmNDA4YmIuLmUwY2FhYTBkZTQ1NCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9pbnB1dC9taXNjL2FkeGwzNHguYworKysgYi9kcml2ZXJzL2lucHV0L21pc2MvYWR4bDM0eC5j
CkBAIC03OTYsNyArNzk2LDcgQEAgc3RydWN0IGFkeGwzNHggKmFkeGwzNHhfcHJvYmUoc3RydWN0
IGRldmljZSAqZGV2LCBpbnQgaXJxLAogCiAJaWYgKHBkYXRhLT53YXRlcm1hcmspIHsKIAkJYWMt
PmludF9tYXNrIHw9IFdBVEVSTUFSSzsKLQkJaWYgKCFGSUZPX01PREUocGRhdGEtPmZpZm9fbW9k
ZSkpCisJCWlmIChGSUZPX01PREUocGRhdGEtPmZpZm9fbW9kZSkgPT0gMCkKIAkJCWFjLT5wZGF0
YS5maWZvX21vZGUgfD0gRklGT19TVFJFQU07CiAJfSBlbHNlIHsKIAkJYWMtPmludF9tYXNrIHw9
IERBVEFfUkVBRFk7Ci0tIAoyLjkuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
