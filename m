From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2] ARM: dts: am437x: make edt-ft5x06 a wakeup source
Date: Sun, 17 Jun 2018 13:53:09 +0200
Message-ID: <20180617115309.1341-1-daniel@zonque.org>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com
Cc: devicetree@vger.kernel.org, Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

VGhlIHRvdWNoc2NyZWVuIGRyaXZlciBubyBsb25nZXIgY29uZmlndXJlcyB0aGUgZGV2aWNlIGFz
IHdha2V1cCBzb3VyY2UgYnkKZGVmYXVsdC4gQSAid2FrZXVwLXNvdXJjZSIgcHJvcGVydHkgaXMg
bmVlZGVkLgoKU2lnbmVkLW9mZi1ieTogRGFuaWVsIE1hY2sgPGRhbmllbEB6b25xdWUub3JnPgot
LS0KdjEg4oaSIHYyOiBhbWVuZGVkIHN1YmplY3QgdG8gbm90IG1lbnRpb24gaW14NiBhbnltb3Jl
CgogYXJjaC9hcm0vYm9vdC9kdHMvYW00Mzd4LXNrLWV2bS5kdHMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYW00
Mzd4LXNrLWV2bS5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hbTQzN3gtc2stZXZtLmR0cwppbmRl
eCA0NDAzNTFhZDBiODAuLmQ0YmUzZmQwYjZmNCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvYW00Mzd4LXNrLWV2bS5kdHMKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYW00Mzd4LXNrLWV2
bS5kdHMKQEAgLTYxMCw2ICs2MTAsOCBAQAogCiAJCXRvdWNoc2NyZWVuLXNpemUteCA9IDw0ODA+
OwogCQl0b3VjaHNjcmVlbi1zaXplLXkgPSA8MjcyPjsKKworCQl3YWtldXAtc291cmNlOwogCX07
CiAKIAl0bHYzMjBhaWMzMTA2OiB0bHYzMjBhaWMzMTA2QDFiIHsKLS0gCjIuMTcuMQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
