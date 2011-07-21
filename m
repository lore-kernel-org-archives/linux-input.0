From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 2/6] mx31moboard: Add MC13783 power button support
Date: Thu, 21 Jul 2011 17:10:02 +0200
Message-ID: <1311261006-28048-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1311261006-28048-1-git-send-email-philippe.retornaz@epfl.ch>
	<1311261006-28048-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1311261006-28048-2-git-send-email-philippe.retornaz@epfl.ch>
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

QWRkIHRoZSBwb3dlci1vbiBidXR0b24gb24gbXgzMW1vYm9hcmQgdXNpbmcgTUMxMzc4MyBQTUlD
LgoKU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgUsOpdG9ybmF6IDxwaGlsaXBwZS5yZXRvcm5hekBl
cGZsLmNoPgotLS0KIGFyY2gvYXJtL21hY2gtaW14L21hY2gtbXgzMW1vYm9hcmQuYyB8ICAgIDgg
KysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtaW14L21hY2gtbXgzMW1vYm9hcmQuYyBiL2Fy
Y2gvYXJtL21hY2gtaW14L21hY2gtbXgzMW1vYm9hcmQuYwppbmRleCAxMmVlNzU1Li42ODA1NWRl
IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLWlteC9tYWNoLW14MzFtb2JvYXJkLmMKKysrIGIv
YXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1teDMxbW9ib2FyZC5jCkBAIC0yOCw2ICsyOCw3IEBACiAj
aW5jbHVkZSA8bGludXgvc3BpL3NwaS5oPgogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CiAjaW5j
bHVkZSA8bGludXgvbWVtYmxvY2suaD4KKyNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgogCiAjaW5j
bHVkZSA8bGludXgvdXNiL290Zy5oPgogI2luY2x1ZGUgPGxpbnV4L3VzYi91bHBpLmg+CkBAIC0y
NjQsMTIgKzI2NSwxOSBAQCBzdGF0aWMgc3RydWN0IG1jMTM3ODNfbGVkc19wbGF0Zm9ybV9kYXRh
IG1vYm9hcmRfbGVkcyA9IHsKIAkudGMyX3BlcmlvZCA9IE1DMTM3ODNfTEVEX1BFUklPRF8xME1T
LAogfTsKIAorc3RhdGljIHN0cnVjdCBtYzEzNzgzX2J1dHRvbnNfcGxhdGZvcm1fZGF0YSBtb2Jv
YXJkX2J1dHRvbnMgPSB7CisJLmIxb25fZmxhZ3MgPSBNQzEzNzgzX0JVVFRPTl9EQk5DXzc1ME1T
IHwgTUMxMzc4M19CVVRUT05fRU5BQkxFIHwKKwkJCU1DMTM3ODNfQlVUVE9OX1BPTF9JTlZFUlQs
CisJLmIxb25fa2V5ID0gS0VZX1BPV0VSLAorfTsKKwogc3RhdGljIHN0cnVjdCBtYzEzeHh4X3Bs
YXRmb3JtX2RhdGEgbW9ib2FyZF9wbWljID0gewogCS5yZWd1bGF0b3JzID0gewogCQkucmVndWxh
dG9ycyA9IG1vYm9hcmRfcmVndWxhdG9ycywKIAkJLm51bV9yZWd1bGF0b3JzID0gQVJSQVlfU0la
RShtb2JvYXJkX3JlZ3VsYXRvcnMpLAogCX0sCiAJLmxlZHMgPSAmbW9ib2FyZF9sZWRzLAorCS5i
dXR0b25zID0gJm1vYm9hcmRfYnV0dG9ucywKIAkuZmxhZ3MgPSBNQzEzWFhYX1VTRV9SRUdVTEFU
T1IgfCBNQzEzWFhYX1VTRV9SVEMgfAogCQlNQzEzWFhYX1VTRV9BREMgfCBNQzEzWFhYX1VTRV9M
RUQsCiB9OwotLSAKMS42LjMuMwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
