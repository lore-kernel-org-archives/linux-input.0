From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v5 24/24] pwm: add information about polarity,
	duty cycle and period to debugfs
Date: Thu, 14 Apr 2016 21:17:44 +0200
Message-ID: <1460661464-11216-25-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
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
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Stephen Barber <smbarber@chromium.org>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger
List-Id: linux-input@vger.kernel.org

RnJvbTogSGVpa28gU3TDvGJuZXIgPGhlaWtvQHNudGVjaC5kZT4KClRoZSBwd20tc3RhdGVzIG1h
a2UgaXQgcG9zc2libGUgdG8gYWxzbyBvdXRwdXQgdGhlIHBvbGFyaXR5LCBkdXR5IGN5Y2xlCmFu
ZCBwZXJpb2QgaW5mb3JtYXRpb24gaW4gdGhlIGRlYnVnZnMgcHdtIHN1bW1hcnktb3V0b3V0LgpU
aGlzIG1ha2VzIGl0IGVhc2llciB0byBnYXRoZXIgb3ZlcnZpZXcgaW5mb3JtYXRpb24gYWJvdXQg
cHdtcyB3aXRob3V0Cm5lZWRpbmcgdG8gd2FsayB0aHJvdWdoIHRoZSBzeXNmcyBhdHRyaWJ1dGVz
IG9mIGV2ZXJ5IHB3bS4KClNpZ25lZC1vZmYtYnk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRl
Y2guZGU+ClNpZ25lZC1vZmYtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGZy
ZWUtZWxlY3Ryb25zLmNvbT4KLS0tCiBkcml2ZXJzL3B3bS9jb3JlLmMgfCA1ICsrKysrCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vY29y
ZS5jIGIvZHJpdmVycy9wd20vY29yZS5jCmluZGV4IGFlZmZmY2YuLjlmNGU5N2UgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvcHdtL2NvcmUuYworKysgYi9kcml2ZXJzL3B3bS9jb3JlLmMKQEAgLTk1OSw2
ICs5NTksMTEgQEAgc3RhdGljIHZvaWQgcHdtX2RiZ19zaG93KHN0cnVjdCBwd21fY2hpcCAqY2hp
cCwgc3RydWN0IHNlcV9maWxlICpzKQogCQlpZiAoc3RhdGUuZW5hYmxlZCkKIAkJCXNlcV9wdXRz
KHMsICIgZW5hYmxlZCIpOwogCisJCXNlcV9wcmludGYocywgIiBwZXJpb2Q6JXVucyIsIHN0YXRl
LnBlcmlvZCk7CisJCXNlcV9wcmludGYocywgIiBkdXR5OiV1bnMiLCBzdGF0ZS5kdXR5X2N5Y2xl
KTsKKwkJc2VxX3ByaW50ZihzLCAiIHBvbGFyaXR5OiVzIiwKKwkJCSAgIHN0YXRlLnBvbGFyaXR5
ID8gImludmVyc2UiIDogIm5vcm1hbCIpOworCiAJCXNlcV9wdXRzKHMsICJcbiIpOwogCX0KIH0K
LS0gCjIuNS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
