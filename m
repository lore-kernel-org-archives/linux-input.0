From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v5 03/46] backlight: lm3630a_bl: stop messing
	with the pwm->period field
Date: Wed, 30 Mar 2016 22:03:26 +0200
Message-ID: <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
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

cHdtLT5wZXJpb2QgZmllbGQgaXMgbm90IHN1cHBvc2VkIHRvIGJlIGNoYW5nZWQgYnkgUFdNIHVz
ZXJzLiBUaGUgb25seQpvbmVzIGF1dGhvcml6ZWQgdG8gY2hhbmdlIGl0IGFyZSB0aGUgUFdNIGNv
cmUgYW5kIFBXTSBkcml2ZXJzLgoKU2lnbmVkLW9mZi1ieTogQm9yaXMgQnJlemlsbG9uIDxib3Jp
cy5icmV6aWxsb25AZnJlZS1lbGVjdHJvbnMuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vYmFja2xp
Z2h0L2xtMzYzMGFfYmwuYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvbG0z
NjMwYV9ibC5jIGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvbG0zNjMwYV9ibC5jCmluZGV4IDM1
ZmU0ODIuLjNkMTZiZDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2xtMzYz
MGFfYmwuYworKysgYi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9sbTM2MzBhX2JsLmMKQEAgLTE2
Miw3ICsxNjIsNyBAQCBzdGF0aWMgaW50IGxtMzYzMGFfaW50cl9jb25maWcoc3RydWN0IGxtMzYz
MGFfY2hpcCAqcGNoaXApCiAKIHN0YXRpYyB2b2lkIGxtMzYzMGFfcHdtX2N0cmwoc3RydWN0IGxt
MzYzMGFfY2hpcCAqcGNoaXAsIGludCBiciwgaW50IGJyX21heCkKIHsKLQl1bnNpZ25lZCBpbnQg
cGVyaW9kID0gcHdtX2dldF9wZXJpb2QocGNoaXAtPnB3bWQpOworCXVuc2lnbmVkIGludCBwZXJp
b2QgPSBwY2hpcC0+cGRhdGEtPnB3bV9wZXJpb2Q7CiAJdW5zaWduZWQgaW50IGR1dHkgPSBiciAq
IHBlcmlvZCAvIGJyX21heDsKIAogCXB3bV9jb25maWcocGNoaXAtPnB3bWQsIGR1dHksIHBlcmlv
ZCk7CkBAIC00MjUsNyArNDI1LDYgQEAgc3RhdGljIGludCBsbTM2MzBhX3Byb2JlKHN0cnVjdCBp
MmNfY2xpZW50ICpjbGllbnQsCiAJCQlyZXR1cm4gUFRSX0VSUihwY2hpcC0+cHdtZCk7CiAJCX0K
IAl9Ci0JcGNoaXAtPnB3bWQtPnBlcmlvZCA9IHBkYXRhLT5wd21fcGVyaW9kOwogCiAJLyogaW50
ZXJydXB0IGVuYWJsZSAgOiBpcnEgMCBpcyBub3QgYWxsb3dlZCAqLwogCXBjaGlwLT5pcnEgPSBj
bGllbnQtPmlycTsKLS0gCjIuNS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9pbnRlbC1nZngK
