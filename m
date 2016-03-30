From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v5 02/46] backlight: pwm_bl: remove useless call
	to pwm_set_period()
Date: Wed, 30 Mar 2016 22:03:25 +0200
Message-ID: <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@>
List-Id: linux-input@vger.kernel.org

VGhlIFBXTSBwZXJpb2Qgd2lsbCBiZSBzZXQgd2hlbiBjYWxsaW5nIHB3bV9jb25maWcuIFJlbW92
ZSB0aGlzIHVzZWxlc3MKY2FsbCB0byBwd21fc2V0X3BlcmlvZCgpLCB3aGljaCBtaWdodCBtZXNz
IHVwIHdpdGggdGhlIGludGVybmFsIFBXTSBzdGF0ZS4KClNpZ25lZC1vZmYtYnk6IEJvcmlzIEJy
ZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGZyZWUtZWxlY3Ryb25zLmNvbT4KQWNrZWQtYnk6IExl
ZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy92aWRlby9iYWNrbGln
aHQvcHdtX2JsLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21fYmwu
YyBiL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jCmluZGV4IDY0ZjllMWIuLmEzM2Ey
OTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jCisrKyBiL2Ry
aXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jCkBAIC0zMTMsMTAgKzMxMyw4IEBAIHN0YXRp
YyBpbnQgcHdtX2JhY2tsaWdodF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQog
CSAqIHZpYSB0aGUgUFdNIGxvb2t1cCB0YWJsZS4KIAkgKi8KIAlwYi0+cGVyaW9kID0gcHdtX2dl
dF9wZXJpb2QocGItPnB3bSk7Ci0JaWYgKCFwYi0+cGVyaW9kICYmIChkYXRhLT5wd21fcGVyaW9k
X25zID4gMCkpIHsKKwlpZiAoIXBiLT5wZXJpb2QgJiYgKGRhdGEtPnB3bV9wZXJpb2RfbnMgPiAw
KSkKIAkJcGItPnBlcmlvZCA9IGRhdGEtPnB3bV9wZXJpb2RfbnM7Ci0JCXB3bV9zZXRfcGVyaW9k
KHBiLT5wd20sIGRhdGEtPnB3bV9wZXJpb2RfbnMpOwotCX0KIAogCXBiLT5sdGhfYnJpZ2h0bmVz
cyA9IGRhdGEtPmx0aF9icmlnaHRuZXNzICogKHBiLT5wZXJpb2QgLyBwYi0+c2NhbGUpOwogCi0t
IAoyLjUuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
SW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
