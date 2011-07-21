From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 6/6] mc13xxx: remove unused define
Date: Thu, 21 Jul 2011 17:10:06 +0200
Message-ID: <1311261006-28048-7-git-send-email-philippe.retornaz@epfl.ch>
References: <1311261006-28048-1-git-send-email-philippe.retornaz@epfl.ch>
	<1311261006-28048-2-git-send-email-philippe.retornaz@epfl.ch>
	<1311261006-28048-3-git-send-email-philippe.retornaz@epfl.ch>
	<1311261006-28048-4-git-send-email-philippe.retornaz@epfl.ch>
	<1311261006-28048-5-git-send-email-philippe.retornaz@epfl.ch>
	<1311261006-28048-6-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1311261006-28048-6-git-send-email-philippe.retornaz@epfl.ch>
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
Cc: amit.kucheria@canonical.com, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, philippe.retornaz@epfl.ch, linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFLDqXRvcm5heiA8cGhpbGlwcGUucmV0b3JuYXpAZXBm
bC5jaD4KLS0tCiBpbmNsdWRlL2xpbnV4L21mZC9tYzEzNzgzLmggfCAgICAyIC0tCiBpbmNsdWRl
L2xpbnV4L21mZC9tYzEzeHh4LmggfCAgICAyIC0tCiAyIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC9t
YzEzNzgzLmggYi9pbmNsdWRlL2xpbnV4L21mZC9tYzEzNzgzLmgKaW5kZXggYmQ0ZmJhYy4uYWE4
MjRkMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tZmQvbWMxMzc4My5oCisrKyBiL2luY2x1
ZGUvbGludXgvbWZkL21jMTM3ODMuaApAQCAtMTEzLDggKzExMyw2IEBAIHN0YXRpYyBpbmxpbmUg
aW50IG1jMTM3ODNfaXJxX2FjayhzdHJ1Y3QgbWMxMzc4MyAqbWMxMzc4MywgaW50IGlycSkKICNk
ZWZpbmUgTUMxMzc4M19VU0VfQ09ERUMJTUMxM1hYWF9VU0VfQ09ERUMKICNkZWZpbmUgTUMxMzc4
M19VU0VfQURDCQlNQzEzWFhYX1VTRV9BREMKICNkZWZpbmUgTUMxMzc4M19VU0VfUlRDCQlNQzEz
WFhYX1VTRV9SVEMKLSNkZWZpbmUgTUMxMzc4M19VU0VfUkVHVUxBVE9SCU1DMTNYWFhfVVNFX1JF
R1VMQVRPUgotI2RlZmluZSBNQzEzNzgzX1VTRV9MRUQJCU1DMTNYWFhfVVNFX0xFRAogCiAjZGVm
aW5lIE1DMTM3ODNfQURDX01PREVfVFMJCTEKICNkZWZpbmUgTUMxMzc4M19BRENfTU9ERV9TSU5H
TEVfQ0hBTgkyCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC9tYzEzeHh4LmggYi9pbmNs
dWRlL2xpbnV4L21mZC9tYzEzeHh4LmgKaW5kZXggNTU1YjFkNS4uZjI0YmU2OCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9tZmQvbWMxM3h4eC5oCisrKyBiL2luY2x1ZGUvbGludXgvbWZkL21j
MTN4eHguaApAQCAtMTU4LDggKzE1OCw2IEBAIHN0cnVjdCBtYzEzeHh4X3BsYXRmb3JtX2RhdGEg
ewogI2RlZmluZSBNQzEzWFhYX1VTRV9DT0RFQwkoMSA8PCAxKQogI2RlZmluZSBNQzEzWFhYX1VT
RV9BREMJCSgxIDw8IDIpCiAjZGVmaW5lIE1DMTNYWFhfVVNFX1JUQwkJKDEgPDwgMykKLSNkZWZp
bmUgTUMxM1hYWF9VU0VfUkVHVUxBVE9SCSgxIDw8IDQpCi0jZGVmaW5lIE1DMTNYWFhfVVNFX0xF
RAkJKDEgPDwgNSkKIAl1bnNpZ25lZCBpbnQgZmxhZ3M7CiAKIAlzdHJ1Y3QgbWMxM3h4eF9yZWd1
bGF0b3JfcGxhdGZvcm1fZGF0YSByZWd1bGF0b3JzOwotLSAKMS42LjMuMwoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
