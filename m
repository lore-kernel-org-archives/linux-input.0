From: Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v5 11/36] drm/bridge: analogix_dp: Wait for HPD signal
 before configuring link
Date: Wed, 14 Mar 2018 11:39:27 +0530
Message-ID: <636d85d6-64bb-5387-912d-1ec09e47f0ef@codeaurora.org>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-12-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-12-enric.balletbo@collabora.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com, =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

CgpPbiBTYXR1cmRheSAxMCBNYXJjaCAyMDE4IDAzOjUzIEFNLCBFbnJpYyBCYWxsZXRibyBpIFNl
cnJhIHdyb3RlOgo+IEZyb206IHphaW4gd2FuZyA8d3p6QHJvY2stY2hpcHMuY29tPgo+IAo+IEFj
Y29yZGluZyB0byBEUCBzcGVjIHYxLjMgY2hhcCAzLjUuMS4yIExpbmsgVHJhaW5pbmcsIExpbmsg
UG9saWN5IE1ha2VyCj4gbXVzdCBmaXJzdCBkZXRlY3QgdGhhdCB0aGUgSFBEIHNpZ25hbCBpcyBh
c3NlcnRlZCBoaWdoIGJ5IHRoZSBEb3duc3RyZWFtCj4gRGV2aWNlIGJlZm9yZSBlc3RhYmxpc2hp
bmcgYSBsaW5rIHdpdGggaXQuCgpSZXZpZXdlZC1ieTogQXJjaGl0IFRhbmVqYSA8YXJjaGl0dEBj
b2RlYXVyb3JhLm9yZz4KClRoYW5rcywKQXJjaGl0Cgo+IAo+IENjOiBTdMOpcGhhbmUgTWFyY2hl
c2luIDxtYXJjaGV1QGNocm9taXVtLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiB6YWluIHdhbmcgPHd6
ekByb2NrLWNoaXBzLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIFBhdWwgPHNlYW5wYXVsQGNo
cm9taXVtLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBUaGllcnJ5IEVzY2FuZGUgPHRoaWVycnkuZXNj
YW5kZUBjb2xsYWJvcmEuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEVucmljIEJhbGxldGJvIGkgU2Vy
cmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+Cj4gVGVzdGVkLWJ5OiBNYXJlayBTenlw
cm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+Cj4gLS0tCj4gCj4gICBkcml2ZXJzL2dw
dS9kcm0vYnJpZGdlL2FuYWxvZ2l4L2FuYWxvZ2l4X2RwX2NvcmUuYyB8IDExICsrKysrKysrKysr
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYnJpZGdlL2FuYWxvZ2l4L2FuYWxvZ2l4X2RwX2NvcmUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW5hbG9naXhfZHBfY29yZS5jCj4gaW5kZXggYzgx
NzMzYjgxODVlLi45MmZiOWEwNzJjYjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Jy
aWRnZS9hbmFsb2dpeC9hbmFsb2dpeF9kcF9jb3JlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YnJpZGdlL2FuYWxvZ2l4L2FuYWxvZ2l4X2RwX2NvcmUuYwo+IEBAIC0xMTY5LDYgKzExNjksMTcg
QEAgc3RhdGljIGludCBhbmFsb2dpeF9kcF9zZXRfYnJpZGdlKHN0cnVjdCBhbmFsb2dpeF9kcF9k
ZXZpY2UgKmRwKQo+ICAgCWlmIChyZXQpCj4gICAJCWdvdG8gb3V0X2RwX2luaXQ7Cj4gICAKPiAr
CS8qCj4gKwkgKiBBY2NvcmRpbmcgdG8gRFAgc3BlYyB2MS4zIGNoYXAgMy41LjEuMiBMaW5rIFRy
YWluaW5nLAo+ICsJICogV2Ugc2hvdWxkIGZpcnN0IG1ha2Ugc3VyZSB0aGUgSFBEIHNpZ25hbCBp
cyBhc3NlcnRlZCBoaWdoIGJ5IGRldmljZQo+ICsJICogd2hlbiB3ZSB3YW50IHRvIGVzdGFibGlz
aCBhIGxpbmsgd2l0aCBpdC4KPiArCSAqLwo+ICsJcmV0ID0gYW5hbG9naXhfZHBfZGV0ZWN0X2hw
ZChkcCk7Cj4gKwlpZiAocmV0KSB7Cj4gKwkJRFJNX0VSUk9SKCJmYWlsZWQgdG8gZ2V0IGhwZCBz
aW5nbGUgcmV0ID0gJWRcbiIsIHJldCk7Cj4gKwkJZ290byBvdXRfZHBfaW5pdDsKPiArCX0KPiAr
Cj4gICAJcmV0ID0gYW5hbG9naXhfZHBfY29tbWl0KGRwKTsKPiAgIAlpZiAocmV0KQo+ICAgCQln
b3RvIG91dF9kcF9pbml0Owo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9k
cmktZGV2ZWwK
