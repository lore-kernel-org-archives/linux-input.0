From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 03/36] drm/bridge: analogix_dp: Don't change psr while
 bridge is disabled
Date: Wed, 14 Mar 2018 11:32:56 +0100
Message-ID: <2007370.FhFqbYQVrQ@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-4-enric.balletbo@collabora.com>
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, thierry.reding@gmail.com, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, linux-kernel@vger.kernel.org, jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, Tomeu Vizoso <tomeu.vizoso@collabora.com>, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, tfiga@chromium.org, kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

QW0gRnJlaXRhZywgOS4gTcOkcnogMjAxOCwgMjM6MjI6NTQgQ0VUIHNjaHJpZWIgRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYToKPiBGcm9tOiB6YWluIHdhbmcgPHd6ekByb2NrLWNoaXBzLmNvbT4KPiAK
PiBUaGVyZSBpcyBhIHJhY2UgYmV0d2VlbiBBVVggQ0ggYnJpbmctdXAgYW5kIGVuYWJsaW5nIGJy
aWRnZSB3aGljaCB3aWxsCj4gY2F1c2UgbGluayB0cmFpbmluZyB0byBmYWlsLiBUbyBhdm9pZCBo
aXR0aW5nIGl0LCBkb24ndCBjaGFuZ2UgcHNyIHN0YXRlCj4gd2hpbGUgZW5hYmxpbmcgdGhlIGJy
aWRnZS4KPiAKPiBDYzogVG9tZXUgVml6b3NvIDx0b21ldS52aXpvc29AY29sbGFib3JhLmNvbT4K
PiBDYzogU2VhbiBQYXVsIDxzZWFucGF1bEBjaHJvbWl1bS5vcmc+Cj4gU2lnbmVkLW9mZi1ieTog
emFpbiB3YW5nIDx3enpAcm9jay1jaGlwcy5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQ2Flc2FyIFdh
bmcgPHd4dEByb2NrLWNoaXBzLmNvbT4KPiBbc2VhbnBhdWwgZml4ZWQgdXAgdGhlIGNvbW1pdCBt
ZXNzYWdlIGEgYml0IGFuZCByZW5hbWVkICpfc3VwcG9ydGVkIHRvCj4gKl9lbmFibGVkXSBTaWdu
ZWQtb2ZmLWJ5OiBTZWFuIFBhdWwgPHNlYW5wYXVsQGNocm9taXVtLm9yZz4KPiBTaWduZWQtb2Zm
LWJ5OiBUaGllcnJ5IEVzY2FuZGUgPHRoaWVycnkuZXNjYW5kZUBjb2xsYWJvcmEuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxh
Ym9yYS5jb20+Cj4gVGVzdGVkLWJ5OiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ft
c3VuZy5jb20+CgoKYXBwbGllZCB0byBkcm0tbWlzYy1uZXh0CgpUaGFua3MKSGVpa28KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
