From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v6 28/30] drm/rockchip: Disable PSR from reboot notifier
Date: Mon, 16 Apr 2018 13:12:07 +0000
Message-ID: <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <CGME20180405095117epcas2p2093448b49aab2abd6684bf689f8888d5@epcas2p2.samsung.com>
 <20180405095000.9756-29-enric.balletbo@collabora.com>
 <a9e436f8-34ec-123a-9c69-efabb4576bea@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <a9e436f8-34ec-123a-9c69-efabb4576bea@samsung.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: a.hajda@samsung.com
Cc: David Airlie <airlied@linux.ie>, dri-devel <dri-devel@lists.freedesktop.org>, Douglas Anderson <dianders@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Yakir Yang <ykk@rock-chips.com>, kernel@collabora.com, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, rydberg@bitmath.org, Krzysztof Kozlowski <krzk@kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, kgene@kernel.org, linux-input@vger.kernel.org, =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>, Caesar Wang <wxt@rock-chips.com>, Jeffy <jeffy.chen@rock-chips.com>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>, Mark yao <mark.yao@rock-chips.com>, =?UTF-8?B?546L5b6B5aKe?= <wzz@rock-chi>
List-Id: linux-input@vger.kernel.org

SGkgQW5kcnplaiwKCk9uIE1vbiwgQXByIDE2LCAyMDE4IGF0IDY6NTcgUE0gQW5kcnplaiBIYWpk
YSA8YS5oYWpkYUBzYW1zdW5nLmNvbT4gd3JvdGU6Cgo+IE9uIDA1LjA0LjIwMTggMTE6NDksIEVu
cmljIEJhbGxldGJvIGkgU2VycmEgd3JvdGU6Cj4gPiBGcm9tOiBUb21hc3ogRmlnYSA8dGZpZ2FA
Y2hyb21pdW0ub3JnPgo+ID4KPiA+IEl0IGxvb2tzIGxpa2UgdGhlIGRyaXZlciBzdWJzeXN0ZW0g
ZGV0YWNoZXMgZGV2aWNlcyBmcm9tIHBvd2VyIGRvbWFpbnMKPiA+IGF0IHNodXRkb3duIHdpdGhv
dXQgY29uc2VudCBvZiB0aGUgZHJpdmVycy4KCj4gSXQgbG9va3MgYml0IHN0cmFuZ2UuIENvdWxk
IHlvdSBlbGFib3JhdGUgbW9yZSBvbiBpdC4gQ291bGQgeW91IHNob3cgdGhlCj4gY29kZSBwZXJm
b3JtaW5nIHRoZSBkZXRhY2g/CgpJdCBub3Qgb25seSBsb29rcyBzdHJhbmdlLCBidXQgaXQgaXMg
c3RyYW5nZS4gVGhlIGNvZGUgd2FzIHByZXNlbnQgaW4gNC40OgoKaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjQuNC4xMjgvc291cmNlL2RyaXZlcnMvYmFzZS9wbGF0Zm9ybS5jI0w1
NTMKCmJ1dCB3YXMgYXBwYXJlbnRseSByZW1vdmVkIGluIDQuNToKCmh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0
L2RyaXZlcnMvYmFzZS9wbGF0Zm9ybS5jP2g9bmV4dC0yMDE4MDQxNiZpZD0yZDMwYmIwYjM4ODlh
ZGYwOWIzNDI3MjJiMmNlNTk2YzA3NjNiYzkzCgpTbyB3ZSBtaWdodCBub3QgbmVlZCB0aGlzIHBh
dGNoIGFueW1vcmUuCgpCZXN0IHJlZ2FyZHMsClRvbWFzegpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
