From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v3 3/3] input: goodix: Print values in case of inconsistencies
Date: Fri, 15 Feb 2019 15:11:53 +0100
Message-ID: <c2f48f779b64478cb7e0c63e3a2ee19e160d1292.1550239328.git.agx@sigxcpu.org>
References: <cover.1550239328.git.agx@sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bastien Nocera <hadess@hadess.net>, Matthias Brugger <matthias.bgg@gmail.com>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-input@vger.kernel.org

IkludmFsaWQgY29uZmlnIiBnaXZlcyBsaXR0bGUgaWRlYSB3aGF0J3Mgd3JvbmcuIFByaW50IHRo
ZSB2YWx1ZXMgdGhhdAptdXN0IG5vdCBiZSAwIHNvIHdlIGtub3cgd2hpY2ggb25lcyBhcmUgb2Zm
LgoKU2lnbmVkLW9mZi1ieTogR3VpZG8gR8O8bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4KLS0tCiBk
cml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bnB1dC90b3VjaHNjcmVlbi9nb29kaXguYyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZ29v
ZGl4LmMKaW5kZXggNDdiMWNlZDQxNTc2Li5mNTdkODIyMjBhODggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LmMKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNj
cmVlbi9nb29kaXguYwpAQCAtNjkzLDcgKzY5Myw5IEBAIHN0YXRpYyBpbnQgZ29vZGl4X2NvbmZp
Z3VyZV9kZXYoc3RydWN0IGdvb2RpeF90c19kYXRhICp0cykKIAl0b3VjaHNjcmVlbl9wYXJzZV9w
cm9wZXJ0aWVzKHRzLT5pbnB1dF9kZXYsIHRydWUsICZ0cy0+cHJvcCk7CiAKIAlpZiAoIXRzLT5w
cm9wLm1heF94IHx8ICF0cy0+cHJvcC5tYXhfeSB8fCAhdHMtPm1heF90b3VjaF9udW0pIHsKLQkJ
ZGV2X2VycigmdHMtPmNsaWVudC0+ZGV2LCAiSW52YWxpZCBjb25maWcsIHVzaW5nIGRlZmF1bHRz
XG4iKTsKKwkJZGV2X2VycigmdHMtPmNsaWVudC0+ZGV2LAorCQkJIkludmFsaWQgY29uZmlnICgl
ZCwgJWQsICVkKSwgdXNpbmcgZGVmYXVsdHNcbiIsCisJCQl0cy0+cHJvcC5tYXhfeCwgdHMtPnBy
b3AubWF4X3ksIHRzLT5tYXhfdG91Y2hfbnVtKTsKIAkJdHMtPnByb3AubWF4X3ggPSBHT09ESVhf
TUFYX1dJRFRIIC0gMTsKIAkJdHMtPnByb3AubWF4X3kgPSBHT09ESVhfTUFYX0hFSUdIVCAtIDE7
CiAJCXRzLT5tYXhfdG91Y2hfbnVtID0gR09PRElYX01BWF9DT05UQUNUUzsKLS0gCjIuMjAuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
