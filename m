From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 19/36] drm/rockchip: Restore psr->state when
 enable/disable psr failed
Date: Mon, 12 Mar 2018 18:06:56 +0100
Message-ID: <8139042.U9NTKlgutZ@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-20-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-20-enric.balletbo@collabora.com>
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

QW0gRnJlaXRhZywgOS4gTcOkcnogMjAxOCwgMjM6MjM6MTAgQ0VUIHNjaHJpZWIgRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYToKPiBGcm9tOiB6YWluIHdhbmcgPHd6ekByb2NrLWNoaXBzLmNvbT4KPiAK
PiBJZiB3ZSBmYWlsZWQgZGlzYWJsZSBwc3IsIGl0IHdvdWxkIGhhbmcgdGhlIGRpc3BsYXkgdW50
aWwgbmV4dCBwc3IKPiBjeWNsZSBjb21pbmcuIFNvIHdlIHNob3VsZCByZXN0b3JlIHBzci0+c3Rh
dGUgd2hlbiBpdCBmYWlsZWQuCj4gCj4gQ2M6IFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJvbWl1bS5v
cmc+Cj4gU2lnbmVkLW9mZi1ieTogemFpbiB3YW5nIDx3enpAcm9jay1jaGlwcy5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogRG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPgo+IFNp
Z25lZC1vZmYtYnk6IFNlYW4gUGF1bCA8c2VhbnBhdWxAY2hyb21pdW0ub3JnPgo+IFNpZ25lZC1v
ZmYtYnk6IFRoaWVycnkgRXNjYW5kZSA8dGhpZXJyeS5lc2NhbmRlQGNvbGxhYm9yYS5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogRW5yaWMgQmFsbGV0Ym8gaSBTZXJyYSA8ZW5yaWMuYmFsbGV0Ym9AY29s
bGFib3JhLmNvbT4KPiBUZXN0ZWQtYnk6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBz
YW1zdW5nLmNvbT4KClJldmlld2VkLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNoLmRl
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
