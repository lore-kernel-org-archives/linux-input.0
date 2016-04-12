From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 15/46] pwm: introduce the pwm_state
	concept
Date: Tue, 12 Apr 2016 14:17:18 +0200
Message-ID: <20160412141718.5fe4cf24@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-16-git-send-email-boris.brezillon@free-electrons.com>
 <20160412114904.GM18882@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20160412114904.GM18882@ulmo.ba.sec>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org, Jean-Christophe
List-Id: linux-input@vger.kernel.org

T24gVHVlLCAxMiBBcHIgMjAxNiAxMzo0OTowNCArMDIwMApUaGllcnJ5IFJlZGluZyA8dGhpZXJy
eS5yZWRpbmdAZ21haWwuY29tPiB3cm90ZToKCj4gT24gV2VkLCBNYXIgMzAsIDIwMTYgYXQgMTA6
MDM6MzhQTSArMDIwMCwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOgo+ID4gVGhlIFBXTSBzdGF0ZSwg
cmVwcmVzZW50ZWQgYnkgaXRzIHBlcmlvZCwgZHV0eV9jeWNsZSBhbmQgcG9sYXJpdHksCj4gPiBp
cyBjdXJyZW50bHkgZGlyZWN0bHkgc3RvcmVkIGluIHRoZSBQV00gZGV2aWNlLgo+ID4gRGVjbGFy
ZSBhIHB3bV9zdGF0ZSBzdHJ1Y3R1cmUgZW1iZWRkaW5nIHRob3NlIGZpZWxkIHNvIHRoYXQgd2Ug
Y2FuIGxhdGVyCj4gPiB1c2UgdGhpcyBzdHJ1Y3QgdG8gYXRvbWljYWxseSB1cGRhdGUgYWxsIHRo
ZSBQV00gcGFyYW1ldGVycyBhdCBvbmNlLgo+ID4gCj4gPiBBbGwgcHdtX2dldF94eHgoKSBoZWxw
ZXJzIGFyZSBub3cgaW1wbGVtZW50ZWQgYXMgd3JhcHBlcnMgYXJvdW5kCj4gPiBwd21fZ2V0X3N0
YXRlKCkuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJl
emlsbG9uQGZyZWUtZWxlY3Ryb25zLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvcHdtL2NvcmUu
YyAgfCAgOCArKysrLS0tLQo+ID4gIGluY2x1ZGUvbGludXgvcHdtLmggfCA1NCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3B3bS9jb3JlLmMgYi9kcml2ZXJzL3B3bS9jb3JlLmMKPiA+IGluZGV4
IDY0MzMwNTkuLmYzZjkxZTcgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3B3bS9jb3JlLmMKPiA+
ICsrKyBiL2RyaXZlcnMvcHdtL2NvcmUuYwo+ID4gQEAgLTI2OCw3ICsyNjgsNyBAQCBpbnQgcHdt
Y2hpcF9hZGRfd2l0aF9wb2xhcml0eShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsCj4gPiAgCQlwd20t
PmNoaXAgPSBjaGlwOwo+ID4gIAkJcHdtLT5wd20gPSBjaGlwLT5iYXNlICsgaTsKPiA+ICAJCXB3
bS0+aHdwd20gPSBpOwo+ID4gLQkJcHdtLT5wb2xhcml0eSA9IHBvbGFyaXR5Owo+ID4gKwkJcHdt
LT5zdGF0ZS5wb2xhcml0eSA9IHBvbGFyaXR5Owo+IAo+IFdvdWxkIHRoaXMgbm90IG1vcmUgY29y
cmVjdGx5IGJlIGFzc2lnbmVkIHRvIHB3bS0+YXJncy5wb2xhcml0eT8gQWZ0ZXIKPiBhbGwgdGhp
cyBpcyBzZXR0aW5nIHVwIHRoZSAiaW5pdGlhbCIgc3RhdGUsIG11Y2ggbGlrZSBEVCBvciB0aGUg
bG9va3VwCj4gdGFibGVzIHdvdWxkIGZvciBkdXR5IGN5Y2xlIGFuZCBwZXJpb2QuCgpZZXMsIEkg
d2Fzbid0IHN1cmUgYWJvdXQgdGhlIHB3bV9hZGRfd2l0aF9wb2xhcml0eSgpIG1lYW5pbmcuIFRv
IG1lLAphbGwgdGhlIHJlZmVyZW5jZSBpbmZvIHNob3VsZCBiZSBleHRyYWN0ZWQgZnJvbSBEVCwg
UFdNIGxvb2t1cCB0YWJsZSBvcgpkcml2ZXIgc3BlY2lmaWMgLT5yZXF1ZXN0KCkgaW1wbGVtZW50
YXRpb24sIGJ1dCBJIGNhbiBkZWZpbml0ZWx5CmluaXRpYWxpemUgdGhlIGFyZ3MucG9sYXJpdHkg
aGVyZSB0b28uCgpTaG91bGQgSSBrZWVwIHRoZSBwd20tPnN0YXRlLnBvbGFyaXR5IGFzc2lnbm1l
bnQgKHRvIHNldCB0aGUgaW5pdGlhbApwb2xhcml0eSB3aGVuIHRoZSBkcml2ZXIgZG9lcyBub3Qg
c3VwcG9ydCBoYXJkd2FyZSByZWFkb3V0KT8KCi0tIApCb3JpcyBCcmV6aWxsb24sIEZyZWUgRWxl
Y3Ryb25zCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2ZyZWUt
ZWxlY3Ryb25zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1n
ZngK
