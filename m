From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v5 11/36] drm/bridge: analogix_dp: Wait for HPD signal before
 configuring link
Date: Fri,  9 Mar 2018 23:23:02 +0100
Message-ID: <20180309222327.18689-12-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180309222327.18689-1-enric.balletbo@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, kyungmin.park@samsung.com, Enric Balletbo i Serra <enric.balletbo@collabora.com>, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

RnJvbTogemFpbiB3YW5nIDx3enpAcm9jay1jaGlwcy5jb20+CgpBY2NvcmRpbmcgdG8gRFAgc3Bl
YyB2MS4zIGNoYXAgMy41LjEuMiBMaW5rIFRyYWluaW5nLCBMaW5rIFBvbGljeSBNYWtlcgptdXN0
IGZpcnN0IGRldGVjdCB0aGF0IHRoZSBIUEQgc2lnbmFsIGlzIGFzc2VydGVkIGhpZ2ggYnkgdGhl
IERvd25zdHJlYW0KRGV2aWNlIGJlZm9yZSBlc3RhYmxpc2hpbmcgYSBsaW5rIHdpdGggaXQuCgpD
YzogU3TDqXBoYW5lIE1hcmNoZXNpbiA8bWFyY2hldUBjaHJvbWl1bS5vcmc+ClNpZ25lZC1vZmYt
Ynk6IHphaW4gd2FuZyA8d3p6QHJvY2stY2hpcHMuY29tPgpTaWduZWQtb2ZmLWJ5OiBTZWFuIFBh
dWwgPHNlYW5wYXVsQGNocm9taXVtLm9yZz4KU2lnbmVkLW9mZi1ieTogVGhpZXJyeSBFc2NhbmRl
IDx0aGllcnJ5LmVzY2FuZGVAY29sbGFib3JhLmNvbT4KU2lnbmVkLW9mZi1ieTogRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYSA8ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbT4KVGVzdGVkLWJ5OiBN
YXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+Ci0tLQoKIGRyaXZlcnMv
Z3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW5hbG9naXhfZHBfY29yZS5jIHwgMTEgKysrKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2JyaWRnZS9hbmFsb2dpeC9hbmFsb2dpeF9kcF9jb3JlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYnJpZGdlL2FuYWxvZ2l4L2FuYWxvZ2l4X2RwX2NvcmUuYwppbmRleCBjODE3MzNiODE4
NWUuLjkyZmI5YTA3MmNiNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hbmFs
b2dpeC9hbmFsb2dpeF9kcF9jb3JlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hbmFs
b2dpeC9hbmFsb2dpeF9kcF9jb3JlLmMKQEAgLTExNjksNiArMTE2OSwxNyBAQCBzdGF0aWMgaW50
IGFuYWxvZ2l4X2RwX3NldF9icmlkZ2Uoc3RydWN0IGFuYWxvZ2l4X2RwX2RldmljZSAqZHApCiAJ
aWYgKHJldCkKIAkJZ290byBvdXRfZHBfaW5pdDsKIAorCS8qCisJICogQWNjb3JkaW5nIHRvIERQ
IHNwZWMgdjEuMyBjaGFwIDMuNS4xLjIgTGluayBUcmFpbmluZywKKwkgKiBXZSBzaG91bGQgZmly
c3QgbWFrZSBzdXJlIHRoZSBIUEQgc2lnbmFsIGlzIGFzc2VydGVkIGhpZ2ggYnkgZGV2aWNlCisJ
ICogd2hlbiB3ZSB3YW50IHRvIGVzdGFibGlzaCBhIGxpbmsgd2l0aCBpdC4KKwkgKi8KKwlyZXQg
PSBhbmFsb2dpeF9kcF9kZXRlY3RfaHBkKGRwKTsKKwlpZiAocmV0KSB7CisJCURSTV9FUlJPUigi
ZmFpbGVkIHRvIGdldCBocGQgc2luZ2xlIHJldCA9ICVkXG4iLCByZXQpOworCQlnb3RvIG91dF9k
cF9pbml0OworCX0KKwogCXJldCA9IGFuYWxvZ2l4X2RwX2NvbW1pdChkcCk7CiAJaWYgKHJldCkK
IAkJZ290byBvdXRfZHBfaW5pdDsKLS0gCjIuMTYuMQoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
