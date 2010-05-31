From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 0/2] mc13783: add pwr button support
Date: Mon, 31 May 2010 21:28:58 +0200
Message-ID: <1275334140-29339-1-git-send-email-philippe.retornaz@epfl.ch>
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
Cc: linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, sameo@linux.intel.com, dmitry.torokhov@gmail.com, valentin.longchamp@epfl.ch, ext-jari.vanhala@nokia.com, u.kleine-koenig@pengutronix.de, =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

SGVsbG8KClRoaXMgYWRkIGJ1dHRvbiBoYW5kbGluZyBmb3IgdGhlIE1DMTM3ODMgUE1JQy4KVGhl
IGZpcnN0IHBhdGNoIG1vZGlmeSB0aGUgbWMxMzc4MyBNRkQgZHJpdmVyIHRvIGFkZCBhIGJ1dHRv
biAKc3ViZGV2aWNlIGFuZCBhbHNvIGFkZHMgdGhlIG1jMTM3ODMtcHdyYnV0dG9uIGRyaXZlciB1
c2luZyBhIG1pc2MKaW5wdXQgZGV2aWNlLgoKVGhlIHNlY29uZCBwYXRjaCBhZGRzIHRoZSBwb3dl
ciBvbiBidXR0b24gc3VwcG9ydCB0byB0aGUgbXgzMW1vYm9hcmQKYm9hcmRzLgoKUmVnYXJkcywK
UGhpbGlwcGUKCgpQaGlsaXBwZSBSw6l0b3JuYXogKDIpOgogIG1jMTM3ODM6IGFkZCBwb3dlciBi
dXR0b24gc3VwcG9ydAogIG14MzFtb2JvYXJkOiBBZGQgTUMxMzc4MyBwb3dlciBidXR0b24gc3Vw
cG9ydAoKIGFyY2gvYXJtL21hY2gtbXgzL21hY2gtbXgzMW1vYm9hcmQuYyAgIHwgICAxMCArLQog
ZHJpdmVycy9pbnB1dC9taXNjL0tjb25maWcgICAgICAgICAgICAgfCAgICA3ICsKIGRyaXZlcnMv
aW5wdXQvbWlzYy9NYWtlZmlsZSAgICAgICAgICAgIHwgICAgMSArCiBkcml2ZXJzL2lucHV0L21p
c2MvbWMxMzc4My1wd3JidXR0b24uYyB8ICAzMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIGRyaXZlcnMvbWZkL21jMTM3ODMtY29yZS5jICAgICAgICAgICAgIHwgICAgNCArCiBp
bmNsdWRlL2xpbnV4L21mZC9tYzEzNzgzLmggICAgICAgICAgICB8ICAgMTkgKysKIDYgZmlsZXMg
Y2hhbmdlZCwgMzQxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9pbnB1dC9taXNjL21jMTM3ODMtcHdyYnV0dG9uLmMKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
