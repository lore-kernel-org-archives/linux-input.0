From: Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v5 14/36] drm/bridge: analogix_dp: Extend hpd check time
 to 100ms
Date: Wed, 14 Mar 2018 11:45:06 +0530
Message-ID: <7a95aaf7-f692-c476-e4b6-822a6923951a@codeaurora.org>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-15-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-15-enric.balletbo@collabora.com>
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com, =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

CgpPbiBTYXR1cmRheSAxMCBNYXJjaCAyMDE4IDAzOjUzIEFNLCBFbnJpYyBCYWxsZXRibyBpIFNl
cnJhIHdyb3RlOgo+IEZyb206IExpbiBIdWFuZyA8aGxAcm9jay1jaGlwcy5jb20+Cj4gCj4gVGhl
cmUgd2FzIGEgMW1zIGRlbGF5IHRvIGRldGVjdCB0aGUgaHBkIHNpZ25hbCwgd2hpY2ggaXMgdG9v
IHNob3J0IHRvCj4gZGV0ZWN0IGEgc2hvcnQgcHVsc2UuIFRoaXMgcGF0Y2ggZXh0ZW5kcyB0aGlz
IGRlbGF5IHRvIDEwMG1zLgo+IAoKUmV2aWV3ZWQtYnk6IEFyY2hpdCBUYW5lamEgPGFyY2hpdHRA
Y29kZWF1cm9yYS5vcmc+CgpUaGFua3MsCkFyY2hpdAoKPiBDYzogU3TDqXBoYW5lIE1hcmNoZXNp
biA8bWFyY2hldUBjaHJvbWl1bS5vcmc+Cj4gQ2M6IOW+geWiniDnjosgPHd6ekByb2NrLWNoaXBz
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBMaW4gSHVhbmcgPGhsQHJvY2stY2hpcHMuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IFNlYW4gUGF1bCA8c2VhbnBhdWxAY2hyb21pdW0ub3JnPgo+IFNpZ25lZC1v
ZmYtYnk6IFRoaWVycnkgRXNjYW5kZSA8dGhpZXJyeS5lc2NhbmRlQGNvbGxhYm9yYS5jb20+Cj4g
UmV2aWV3ZWQtYnk6IEFuZHJ6ZWogSGFqZGEgPGEuaGFqZGFAc2Ftc3VuZy5jb20+Cj4gU2lnbmVk
LW9mZi1ieTogRW5yaWMgQmFsbGV0Ym8gaSBTZXJyYSA8ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3Jh
LmNvbT4KPiBUZXN0ZWQtYnk6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5n
LmNvbT4KPiAtLS0KPiAKPiAgIGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW5hbG9n
aXhfZHBfY29yZS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5h
bG9naXgvYW5hbG9naXhfZHBfY29yZS5jIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hbmFsb2dp
eC9hbmFsb2dpeF9kcF9jb3JlLmMKPiBpbmRleCAzYTIyMmU3ZTQ2ZWUuLjZjYmRlODQ3M2Y1OCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2FuYWxvZ2l4L2FuYWxvZ2l4X2Rw
X2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW5hbG9naXhf
ZHBfY29yZS5jCj4gQEAgLTc2LDcgKzc2LDcgQEAgc3RhdGljIGludCBhbmFsb2dpeF9kcF9kZXRl
Y3RfaHBkKHN0cnVjdCBhbmFsb2dpeF9kcF9kZXZpY2UgKmRwKQo+ICAgCQkJcmV0dXJuIDA7Cj4g
ICAKPiAgIAkJdGltZW91dF9sb29wKys7Cj4gLQkJdXNsZWVwX3JhbmdlKDEwLCAxMSk7Cj4gKwkJ
dXNsZWVwX3JhbmdlKDEwMDAsIDExMDApOwo+ICAgCX0KPiAgIAo+ICAgCS8qCj4gCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
