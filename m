From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v6 28/30] drm/rockchip: Disable PSR from reboot notifier
Date: Wed, 18 Apr 2018 11:18:30 +0200
Message-ID: <CAFqH_51tQ66=oKb0ZhiicRicMd4_zN415tzhHc7X6SUTgg9mFA@mail.gmail.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <CGME20180405095117epcas2p2093448b49aab2abd6684bf689f8888d5@epcas2p2.samsung.com>
 <20180405095000.9756-29-enric.balletbo@collabora.com>
 <a9e436f8-34ec-123a-9c69-efabb4576bea@samsung.com>
 <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: David Airlie <airlied@linux.ie>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Yakir Yang <ykk@rock-chips.com>, kernel@collabora.com, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, rydberg@bitmath.org, Krzysztof Kozlowski <krzk@kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>, Caesar Wang <wxt@rock-chips.com>, Jeffy <jeffy.chen@rock-chips.com>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>, Mark yao <mark.yao@rock-chips.com>, =?UTF-8?B
List-Id: linux-input@vger.kernel.org

SGkgQW5kcnplaiwgVG9tYXN6CgoyMDE4LTA0LTE2IDE1OjEyIEdNVCswMjowMCBUb21hc3ogRmln
YSA8dGZpZ2FAY2hyb21pdW0ub3JnPjoKPiBIaSBBbmRyemVqLAo+Cj4gT24gTW9uLCBBcHIgMTYs
IDIwMTggYXQgNjo1NyBQTSBBbmRyemVqIEhhamRhIDxhLmhhamRhQHNhbXN1bmcuY29tPiB3cm90
ZToKPgo+PiBPbiAwNS4wNC4yMDE4IDExOjQ5LCBFbnJpYyBCYWxsZXRibyBpIFNlcnJhIHdyb3Rl
Ogo+PiA+IEZyb206IFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJvbWl1bS5vcmc+Cj4+ID4KPj4gPiBJ
dCBsb29rcyBsaWtlIHRoZSBkcml2ZXIgc3Vic3lzdGVtIGRldGFjaGVzIGRldmljZXMgZnJvbSBw
b3dlciBkb21haW5zCj4+ID4gYXQgc2h1dGRvd24gd2l0aG91dCBjb25zZW50IG9mIHRoZSBkcml2
ZXJzLgo+Cj4+IEl0IGxvb2tzIGJpdCBzdHJhbmdlLiBDb3VsZCB5b3UgZWxhYm9yYXRlIG1vcmUg
b24gaXQuIENvdWxkIHlvdSBzaG93IHRoZQo+PiBjb2RlIHBlcmZvcm1pbmcgdGhlIGRldGFjaD8K
Pgo+IEl0IG5vdCBvbmx5IGxvb2tzIHN0cmFuZ2UsIGJ1dCBpdCBpcyBzdHJhbmdlLiBUaGUgY29k
ZSB3YXMgcHJlc2VudCBpbiA0LjQ6Cj4KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92NC40LjEyOC9zb3VyY2UvZHJpdmVycy9iYXNlL3BsYXRmb3JtLmMjTDU1Mwo+Cj4gYnV0IHdh
cyBhcHBhcmVudGx5IHJlbW92ZWQgaW4gNC41Ogo+Cj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9jb21taXQvZHJpdmVy
cy9iYXNlL3BsYXRmb3JtLmM/aD1uZXh0LTIwMTgwNDE2JmlkPTJkMzBiYjBiMzg4OWFkZjA5YjM0
MjcyMmIyY2U1OTZjMDc2M2JjOTMKPgo+IFNvIHdlIG1pZ2h0IG5vdCBuZWVkIHRoaXMgcGF0Y2gg
YW55bW9yZS4KPgoKUmlnaHQsIHNlZW1zIHRoYXQgd2UgZG9uJ3QgbmVlZCB0aGlzIHBhdGNoIGFu
eW1vcmUsIEknbGwgZG8gbW9yZSBmZXcKdGVzdHMgYW5kIGxpa2VseSByZW1vdmUgdGhpcyBwYXRj
aCBmcm9tIHRoaXMgc2VyaWVzLiBUaGFua3MgZm9yCmNhdGNoaW5nIHRoaXMuCgpCZXN0IHJlZ2Fy
ZHMsCiAgRW5yaWMKCj4gQmVzdCByZWdhcmRzLAo+IFRvbWFzego+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
