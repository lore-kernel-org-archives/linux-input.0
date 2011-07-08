From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH v2 0/2] mc13783: add pwr button support
Date: Fri,  8 Jul 2011 16:23:55 +0200
Message-ID: <1310135037-24289-1-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: s.hauer@pengutronix.de
Cc: linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, sameo@linux.intel.com, dmitry.torokhov@gmail.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

SGVsbG8KClRoaXMgYWRkIGJ1dHRvbiBoYW5kbGluZyBmb3IgdGhlIE1DMTM3ODMgUE1JQy4KVGhl
IGZpcnN0IHBhdGNoIG1vZGlmeSB0aGUgbWMxMzc4MyBNRkQgZHJpdmVyIHRvIGFkZCBhIGJ1dHRv
biAKc3ViZGV2aWNlIGFuZCBhbHNvIGFkZHMgdGhlIG1jMTM3ODMtcHdyYnV0dG9uIGRyaXZlciB1
c2luZyBhIG1pc2MKaW5wdXQgZGV2aWNlLgoKdjI6IGZpcnN0IHBhdGNoIG1vZGlmaWVkIGFjY29y
ZGluZyB0byBjb21tZW50cyBieSBEbWl0cnkgVG9yb2tob3YKClRoZSBzZWNvbmQgcGF0Y2ggYWRk
cyB0aGUgcG93ZXIgb24gYnV0dG9uIHN1cHBvcnQgdG8gdGhlIG14MzFtb2JvYXJkCmJvYXJkcy4K
ClJlZ2FyZHMsClBoaWxpcHBlCgoKUGhpbGlwcGUgUsOpdG9ybmF6ICgyKToKICBtYzEzNzgzOiBh
ZGQgcG93ZXIgYnV0dG9uIHN1cHBvcnQKICBteDMxbW9ib2FyZDogQWRkIE1DMTM3ODMgcG93ZXIg
YnV0dG9uIHN1cHBvcnQKCiBhcmNoL2FybS9tYWNoLWlteC9tYWNoLW14MzFtb2JvYXJkLmMgICB8
ICAgMTAgKy0KIGRyaXZlcnMvaW5wdXQvbWlzYy9LY29uZmlnICAgICAgICAgICAgIHwgICAxMSAr
KwogZHJpdmVycy9pbnB1dC9taXNjL01ha2VmaWxlICAgICAgICAgICAgfCAgICAxICsKIGRyaXZl
cnMvaW5wdXQvbWlzYy9tYzEzNzgzLXB3cmJ1dHRvbi5jIHwgIDI4OCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogZHJpdmVycy9tZmQvbWMxM3h4eC1jb3JlLmMgICAgICAgICAgICAg
fCAgICA0ICsKIGluY2x1ZGUvbGludXgvbWZkL21jMTM3ODMuaCAgICAgICAgICAgIHwgICAgMSAr
CiBpbmNsdWRlL2xpbnV4L21mZC9tYzEzeHh4LmggICAgICAgICAgICB8ICAgMTggKysKIDcgZmls
ZXMgY2hhbmdlZCwgMzMyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9pbnB1dC9taXNjL21jMTM3ODMtcHdyYnV0dG9uLmMKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
