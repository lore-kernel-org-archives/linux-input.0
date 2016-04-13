From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 03/46] backlight: lm3630a_bl: stop
 messing with the pwm->period field
Date: Wed, 13 Apr 2016 09:25:11 +0100
Message-ID: <20160413082511.GL8094@x1>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110809.GI18882@ulmo.ba.sec> <20160412141613.GI8094@x1>
 <20160412142608.GB25006@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20160412142608.GB25006@ulmo.ba.sec>
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
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.
List-Id: linux-input@vger.kernel.org

T24gVHVlLCAxMiBBcHIgMjAxNiwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6Cgo+IE9uIFR1ZSwgQXBy
IDEyLCAyMDE2IGF0IDAzOjE2OjEzUE0gKzAxMDAsIExlZSBKb25lcyB3cm90ZToKPiA+IE9uIFR1
ZSwgMTIgQXByIDIwMTYsIFRoaWVycnkgUmVkaW5nIHdyb3RlOgo+ID4gCj4gPiA+IE9uIFdlZCwg
TWFyIDMwLCAyMDE2IGF0IDEwOjAzOjI2UE0gKzAyMDAsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToK
PiA+ID4gPiBwd20tPnBlcmlvZCBmaWVsZCBpcyBub3Qgc3VwcG9zZWQgdG8gYmUgY2hhbmdlZCBi
eSBQV00gdXNlcnMuIFRoZSBvbmx5Cj4gPiA+ID4gb25lcyBhdXRob3JpemVkIHRvIGNoYW5nZSBp
dCBhcmUgdGhlIFBXTSBjb3JlIGFuZCBQV00gZHJpdmVycy4KPiA+ID4gPiAKPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBmcmVlLWVsZWN0cm9u
cy5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2xtMzYz
MGFfYmwuYyB8IDMgKy0tCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MiBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IEFwcGxpZWQsIHRoYW5rcy4KPiA+IAo+ID4gQXBw
bGllZD8KPiAKPiBZb3UgZGlkbid0IHNwZWNpZmljYWxseSBBY2sgdGhpcyBvbmUsIGJ1dCBJIHBy
ZXN1bWVkIHRoYXQgc2luY2UgdGhlCj4gY2hhbmdlIGlzIGVzc2VudGlhbGx5IHRoZSBzYW1lIGFz
IGZvciBwd20tYmFja2xpZ2h0LCBhbmQgdGhpcyBpcyBhbm90aGVyCj4gcHJlcmVxdWlzaXRlIGZv
ciB0aGUgcmVtYWluZGVyIG9mIHRoZSBzZXJpZXMgaXQgc2hvdWxkIGdvIGluIHRocm91Z2ggdGhl
Cj4gUFdNIHRyZWUgYXMgd2VsbC4KCklmIHlvdSdyZSB0YWtpbmcgQmFja2xpZ2h0IHBhdGNoZXMg
dGhyb3VnaCBhICFCYWNrbGlnaHQgdHJlZSwgeW91J3JlCmdvaW5nIHRvIGhhdmUgdG8gc2VuZCBv
dXQgYSBwdWxsLXJlcXVlc3QuICBUaGVyZSBhcmUgbm8gY29uZmxpY3RzCmN1cnJlbnRseSwgc28g
SSB3b24ndCB1c2UgaXQgcmlnaHQgYXdheSwgYnV0IEkgbmVlZCBpdCBpbiBteSBhcnNlbmFsCmlm
IHRoZXkgZG8gb2NjdXIuCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3Mg
TGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9y
IEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxp
bmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
