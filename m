From: Denis Carikli <denis@eukrea.com>
Subject: [PATCHv4][ 3/4] ARM: dts: cpuimx35 Add touchscreen support.
Date: Mon, 21 Oct 2013 15:54:26 +0200
Message-ID: <1382363667-10341-3-git-send-email-denis@eukrea.com>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1382363667-10341-1-git-send-email-denis@eukrea.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Denis Carikli <denis@eukrea.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Q2M6IFJvYiBIZXJyaW5nIDxyb2IuaGVycmluZ0BjYWx4ZWRhLmNvbT4KQ2M6IFBhd2VsIE1vbGwg
PHBhd2VsLm1vbGxAYXJtLmNvbT4KQ2M6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5j
b20+CkNjOiBTdGVwaGVuIFdhcnJlbiA8c3dhcnJlbkB3d3dkb3Rvcmcub3JnPgpDYzogSWFuIENh
bXBiZWxsIDxpamMrZGV2aWNldHJlZUBoZWxsaW9uLm9yZy51az4KQ2M6IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnCkNjOiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5j
b20+CkNjOiBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmcKQ2M6IFNhc2NoYSBIYXVlciA8a2Vy
bmVsQHBlbmd1dHJvbml4LmRlPgpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCkNjOiBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+CkNjOiBFcmlj
IELDqW5hcmQgPGVyaWNAZXVrcmVhLmNvbT4KU2lnbmVkLW9mZi1ieTogRGVuaXMgQ2FyaWtsaSA8
ZGVuaXNAZXVrcmVhLmNvbT4KLS0tCkNoYW5nZUxvZyB2Mi0+djQ6Ci0gVGhpcyBwYXRjaCB3YXMg
c3BsaXR0ZWQsIG9ubHkgdGhlIHBhcnQgZW5hYmxpbmcgdGhlIGF1ZGlvIHdhcyBrZXB0LgogIFBh
cnQgb2YgdGhlIHJlc3QgaGFzIGFscmVhZHkgYmVlbiBzdWJtaXRlZCwgYW5kIHRoZSByZW1haW5p
bmcgcGFydHMKICB3aWxsIGJlIHN1Ym1pdGVkIGxhdGVyLCBiZWNhdXNlIHRoZXkgZGVwZW5kIG9u
IGNoYW5nZXMgdG91Y2hpbmcgb3RoZXIKICBzdWJzeXN0ZW1zLgotIFRoZSB4LXBsYXRlLW9obXMg
cHJvcGVydHkgd2FzIHJlbmFtZWQgdG8gdGkseC1wbGF0ZS1vaG1zLgotLS0KIGFyY2gvYXJtL2Jv
b3QvZHRzL2lteDM1LWV1a3JlYS1jcHVpbXgzNS5kdHNpIHwgICAxMSArKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9pbXgzNS1ldWtyZWEtY3B1aW14MzUuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDM1
LWV1a3JlYS1jcHVpbXgzNS5kdHNpCmluZGV4IDJjMmQ0Y2QuLmEyMjIzMGIgMTAwNjQ0Ci0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDM1LWV1a3JlYS1jcHVpbXgzNS5kdHNpCisrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDM1LWV1a3JlYS1jcHVpbXgzNS5kdHNpCkBAIC00MSw2ICs0MSwxNyBA
QAogCQljb21wYXRpYmxlID0gIm54cCxwY2Y4NTYzIjsKIAkJcmVnID0gPDB4NTE+OwogCX07CisK
Kwl0c2MyMDA3OiB0c2MyMDA3QDQ4IHsKKwkJY29tcGF0aWJsZSA9ICJ0aSx0c2MyMDA3IjsKKwkJ
cmVnID0gPDB4NDg+OworCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOworCQlwaW5jdHJsLTAg
PSA8JnBpbmN0cmxfdHNjMjAwN18xPjsKKwkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzM+Owor
CQlpbnRlcnJ1cHRzID0gPDB4MiAweDg+OworCQlncGlvcyA9IDwmZ3BpbzMgMiAwPjsKKwkJdGks
eC1wbGF0ZS1vaG1zID0gPDE4MD47CisJfTsKIH07CiAKICZpb211eGMgewotLSAKMS43LjkuNQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
