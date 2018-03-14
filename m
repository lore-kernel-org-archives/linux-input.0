From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 02/36] drm/rockchip: Remove analogix psr worker
Date: Wed, 14 Mar 2018 11:32:42 +0100
Message-ID: <3214934.ZBQRvzMx2H@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-3-enric.balletbo@collabora.com>
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, thierry.reding@gmail.com, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, linux-kernel@vger.kernel.org, jeffy.chen@rock-chips.com, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, tfiga@chromium.org, kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

QW0gRnJlaXRhZywgOS4gTcOkcnogMjAxOCwgMjM6MjI6NTMgQ0VUIHNjaHJpZWIgRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYToKPiBGcm9tOiBTZWFuIFBhdWwgPHNlYW5wYXVsQGNocm9taXVtLm9yZz4K
PiAKPiBOb3cgdGhhdCB0aGUgc3BpbmxvY2tzIGFuZCB0aW1lcnMgYXJlIGdvbmUsIHdlIGNhbiBy
ZW1vdmUgdGhlIHBzcgo+IHdvcmtlciBsb2NhdGVkIGluIHJvY2tjaGlwJ3MgYW5hbG9naXggZHJp
dmVyIGFuZCBkbyB0aGUgZW5hYmxlL2Rpc2FibGUKPiBkaXJlY3RseS4gVGhpcyBzaG91bGQgc2lt
cGxpZnkgdGhlIGNvZGUgYW5kIHJlbW92ZSByYWNlcyBvbiBkaXNhYmxlLgo+IAo+IENjOiDlvoHl
op4g546LIDx3enpAcm9jay1jaGlwcy5jb20+Cj4gQ2M6IFN0w6lwaGFuZSBNYXJjaGVzaW4gPG1h
cmNoZXVAY2hyb21pdW0ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gUGF1bCA8c2VhbnBhdWxA
Y2hyb21pdW0ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFRoaWVycnkgRXNjYW5kZSA8dGhpZXJyeS5l
c2NhbmRlQGNvbGxhYm9yYS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRW5yaWMgQmFsbGV0Ym8gaSBT
ZXJyYSA8ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbT4KPiBUZXN0ZWQtYnk6IE1hcmVrIFN6
eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KCgphcHBsaWVkIHRvIGRybS1taXNj
LW5leHQKClRoYW5rcwpIZWlrbwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9k
cmktZGV2ZWwK
