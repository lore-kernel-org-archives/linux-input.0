From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 04/36] drm/rockchip: add mutex vop lock
Date: Mon, 12 Mar 2018 17:29:20 +0100
Message-ID: <3618546.KCVSigYX7Y@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-5-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-5-enric.balletbo@collabora.com>
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

QW0gRnJlaXRhZywgOS4gTcOkcnogMjAxOCwgMjM6MjI6NTUgQ0VUIHNjaHJpZWIgRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYToKPiBGcm9tOiB6YWluIHdhbmcgPHd6ekByb2NrLWNoaXBzLmNvbT4KPiAK
PiBBZGQgYSBsb2NrIHRvIHZvcCB0byBhdm9pZCBkaXNhYmxpbmcgdGhlIGNydGMgd2hpbGUgd2Fp
dGluZyBmb3IgYSBsaW5lCj4gZmxhZyB3aGlsZSBlbmFibGluZyBwc3IuIElmIHdlIGRpc2FibGUg
aW4gdGhlIG1pZGRsZSBvZiB3YWl0aW5nIGZvciB0aGUKPiBsaW5lIGZsYWcsIHdlJ2xsIGVuZCB1
cCB0aW1pbmcgb3V0IG9yIHdvcnNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IHphaW4gd2FuZyA8d3p6
QHJvY2stY2hpcHMuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gUGF1bCA8c2VhbnBhdWxAY2hy
b21pdW0ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFRoaWVycnkgRXNjYW5kZSA8dGhpZXJyeS5lc2Nh
bmRlQGNvbGxhYm9yYS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRW5yaWMgQmFsbGV0Ym8gaSBTZXJy
YSA8ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbT4KPiBUZXN0ZWQtYnk6IE1hcmVrIFN6eXBy
b3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KClJldmlld2VkLWJ5OiBIZWlrbyBTdHVl
Ym5lciA8aGVpa29Ac250ZWNoLmRlPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
