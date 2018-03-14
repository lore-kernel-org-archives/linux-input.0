From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 05/36] drm/bridge: analogix_dp: add fast link train for
 eDP
Date: Wed, 14 Mar 2018 11:39:11 +0100
Message-ID: <6139185.TexXAUNAzh@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-6-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-6-enric.balletbo@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, thierry.reding@gmail.com, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, linux-kernel@vger.kernel.org, jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, tfiga@chromium.org, kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

QW0gRnJlaXRhZywgOS4gTcOkcnogMjAxOCwgMjM6MjI6NTYgQ0VUIHNjaHJpZWIgRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYToKPiBGcm9tOiB6YWluIHdhbmcgPHd6ekByb2NrLWNoaXBzLmNvbT4KPiAK
PiBXZSB3b3VsZCBtZWV0IGEgc2hvcnQgYmxhY2sgc2NyZWVuIHdoZW4gZXhpdCBQU1Igd2l0aCB0
aGUgZnVsbCBsaW5rCj4gdHJhaW5pbmcsIEluIHRoaXMgY2FzZSwgd2Ugc2hvdWxkIHVzZSBmYXN0
IGxpbmsgdHJhaW4gaW5zdGVhZCBvZiBmdWxsCj4gbGluayB0cmFpbmluZy4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiB6YWluIHdhbmcgPHd6ekByb2NrLWNoaXBzLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBT
ZWFuIFBhdWwgPHNlYW5wYXVsQGNocm9taXVtLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBUaGllcnJ5
IEVzY2FuZGUgPHRoaWVycnkuZXNjYW5kZUBjb2xsYWJvcmEuY29tPgo+IFNpZ25lZC1vZmYtYnk6
IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+Cj4g
VGVzdGVkLWJ5OiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+Cgph
cHBsaWVkIHRvIGRybS1taXNjLW5leHQKCkNoZWNraW5nIHRoZSB3aG9sZSBzZXJpZXMsIHRoZXJl
IGlzIG5vdGhpbmcgZWxzZSB0aGF0IHRvdWNoZXMgdGhlCnJlb3JkZXJlZCBoZWFkZXJzLCBzbyBJ
J3ZlIGRyb3BwZWQgdGhhdCBjaGFuZ2UsIGxlYXZpbmcgb25seSB0aGUKbmV3bHkgYWRkZWQgaW9w
b2xsLmggaW5jbHVzaW9uIGluIFswXS4KClRoYW5rcwpIZWlrbwoKClswXSBodHRwczovL2NnaXQu
ZnJlZWRlc2t0b3Aub3JnL2RybS9kcm0tbWlzYy9jb21taXQvP2lkPWY5ZDU2ODA1OTZmMmRhYzM5
MDkxOGU2YWVjM2UxNzRkYjAzNjMzYTMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
