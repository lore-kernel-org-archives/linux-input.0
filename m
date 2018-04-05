From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v6 05/30] drm/bridge: analogix_dp: Wait for HPD signal before
 configuring link
Date: Thu,  5 Apr 2018 11:49:35 +0200
Message-ID: <20180405095000.9756-6-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180405095000.9756-1-enric.balletbo@collabora.com>
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
YXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+ClJldmlld2VkLWJ5OiBB
cmNoaXQgVGFuZWphIDxhcmNoaXR0QGNvZGVhdXJvcmEub3JnPgotLS0KCiBkcml2ZXJzL2dwdS9k
cm0vYnJpZGdlL2FuYWxvZ2l4L2FuYWxvZ2l4X2RwX2NvcmUuYyB8IDExICsrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9icmlkZ2UvYW5hbG9naXgvYW5hbG9naXhfZHBfY29yZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2JyaWRnZS9hbmFsb2dpeC9hbmFsb2dpeF9kcF9jb3JlLmMKaW5kZXggYmY4MDVmMTU2MjcyLi4z
MjY5ZGVlYzczOWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgv
YW5hbG9naXhfZHBfY29yZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgv
YW5hbG9naXhfZHBfY29yZS5jCkBAIC0xMTY5LDYgKzExNjksMTcgQEAgc3RhdGljIGludCBhbmFs
b2dpeF9kcF9zZXRfYnJpZGdlKHN0cnVjdCBhbmFsb2dpeF9kcF9kZXZpY2UgKmRwKQogCWlmIChy
ZXQpCiAJCWdvdG8gb3V0X2RwX2luaXQ7CiAKKwkvKgorCSAqIEFjY29yZGluZyB0byBEUCBzcGVj
IHYxLjMgY2hhcCAzLjUuMS4yIExpbmsgVHJhaW5pbmcsCisJICogV2Ugc2hvdWxkIGZpcnN0IG1h
a2Ugc3VyZSB0aGUgSFBEIHNpZ25hbCBpcyBhc3NlcnRlZCBoaWdoIGJ5IGRldmljZQorCSAqIHdo
ZW4gd2Ugd2FudCB0byBlc3RhYmxpc2ggYSBsaW5rIHdpdGggaXQuCisJICovCisJcmV0ID0gYW5h
bG9naXhfZHBfZGV0ZWN0X2hwZChkcCk7CisJaWYgKHJldCkgeworCQlEUk1fRVJST1IoImZhaWxl
ZCB0byBnZXQgaHBkIHNpbmdsZSByZXQgPSAlZFxuIiwgcmV0KTsKKwkJZ290byBvdXRfZHBfaW5p
dDsKKwl9CisKIAlyZXQgPSBhbmFsb2dpeF9kcF9jb21taXQoZHApOwogCWlmIChyZXQpCiAJCWdv
dG8gb3V0X2RwX2luaXQ7Ci0tIAoyLjE2LjMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
