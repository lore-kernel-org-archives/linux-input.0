From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 06/36] drm/rockchip: Only wait for panel ACK on PSR
 entry
Date: Wed, 14 Mar 2018 13:51:20 +0100
Message-ID: <217296292.AN06WKDqZv@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-7-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-7-enric.balletbo@collabora.com>
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, thierry.reding@gmail.com, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, linux-kernel@vger.kernel.org, jeffy.chen@rock-chips.com, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, tfiga@chromium.org, kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

QW0gRnJlaXRhZywgOS4gTcOkcnogMjAxOCwgMjM6MjI6NTcgQ0VUIHNjaHJpZWIgRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYToKPiBGcm9tOiB6YWluIHdhbmcgPHd6ekByb2NrLWNoaXBzLmNvbT4KPiAK
PiBXZSBjdXJyZW50bHkgd2FpdCBmb3IgdGhlIHBhbmVsIHRvIG1pcnJvciBvdXIgaW50ZW5kZWQg
UFNSIHN0YXRlCj4gYmVmb3JlIGNvbnRpbnVpbmcgb24gYm90aCBQU1IgZW50ZXIgYW5kIFBTUiBl
eGl0LiBUaGlzIGlzIHJlYWxseQo+IG9ubHkgaW1wb3J0YW50IHRvIGRvIHdoZW4gd2UncmUgZW50
ZXJpbmcgUFNSLCBzaW5jZSB3ZSB3YW50IHRvCj4gYmUgc3VyZSB0aGUgbGFzdCBmcmFtZSB3ZSBw
dXNoZWQgaXMgYmVpbmcgc2VydmVkIGZyb20gdGhlIHBhbmVsJ3MKPiBpbnRlcm5hbCBmYiBiZWZv
cmUgc2h1dHRpbmcgZG93biB0aGUgc29jIGJsb2NrcyAodm9wL2FuYWxvZ2l4KS4KPiAKPiBUaGlz
IHBhdGNoIGNoYW5nZXMgdGhlIGJlaGF2aW9yIHN1Y2ggdGhhdCB3ZSBvbmx5IHdhaXQgZm9yIHRo
ZQo+IHBhbmVsIHRvIGNvbXBsZXRlIHRoZSBQU1IgdHJhbnNpdGlvbiB3aGVuIHdlJ3JlIGVudGVy
aW5nIFBTUiwgYW5kCj4gdG8gc2tpcCB2ZXJpZmljYXRpb24gd2hlbiB3ZSdyZSBleGl0aW5nLgo+
IAo+IENjOiBTdMOpcGhhbmUgTWFyY2hlc2luIDxtYXJjaGV1QGNocm9taXVtLm9yZz4KPiBDYzog
U29ubnkgUmFvIDxzb25ueXJhb0BjaHJvbWl1bS5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogemFpbiB3
YW5nIDx3enpAcm9jay1jaGlwcy5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2VhbiBQYXVsIDxzZWFu
cGF1bEBjaHJvbWl1bS5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogVGhpZXJyeSBFc2NhbmRlIDx0aGll
cnJ5LmVzY2FuZGVAY29sbGFib3JhLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBFbnJpYyBCYWxsZXRi
byBpIFNlcnJhIDxlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tPgo+IFRlc3RlZC1ieTogTWFy
ZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgoKYXBwbGllZCB0byBkcm0t
bWlzYy1uZXh0IHdpdGggdGhlIHN1YmplY3QgZml4ZWQuCgoKVGhhbmtzCkhlaWtvCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
