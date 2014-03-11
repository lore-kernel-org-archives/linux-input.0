From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Qualcomm PMIC8XXX keypad never worked?
Date: Tue, 11 Mar 2014 12:00:56 +0000
Message-ID: <20140311120056.GH21216@lee--X1>
References: <5887114.1jrNo21sGX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5887114.1jrNo21sGX@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Anirudh Ghayal <aghayal@codeaurora.org>
List-Id: linux-input@vger.kernel.org

PiBTb21ldGhpbmcgaW4gdGhlIE1GRF9QTThYWFggZHJpdmVyIG11c3QgaGF2ZSBjaGFuZ2VkIHJl
Y2VudGx5IHRoYXQgbm93IGFsbG93cwo+IHRoZSBLRVlCT0FSRF9QTUlDOFhYWCBkcml2ZXIgdG8g
YmUgZW5hYmxlZC4gVW5mb3J0dW5hdGVseSwgaXQgZG9lcyBub3QgYnVpbGQKPiBiZWNhdXNlIG9m
IGEgZGVwZW5kZW5jeSBvbiB0aGUgPGxpbnV4L21mZC9wbTh4eHgvZ3Bpby5oPiBoZWFkZXIgZmls
ZSB0aGF0Cj4gZG9lcyBub3QgZXhpc3QuCgpJIGhhdmUgaXQ/Cgotcnctci0tci0tIDEgbGVlIGxl
ZSAyMTQ3IERlYyAxOCAxMTo1MiBpbmNsdWRlL2xpbnV4L21mZC9wbTh4eHgvY29yZS5oCgo+IElu
IG9yZGVyIHRvIGtlZXAgJ21ha2UgcmFuZGNvbmZpZycgd29ya2luZyBvbiBteSB0ZXN0IGJveCwg
SSBoYXZlIGRpc2FibGVkCj4gdGhpcyBkcml2ZXIsIGJ1dCBpdCB3b3VsZCBiZSBuaWNlIG9mIHNv
bWVvbmUgY291bGQgaGF2ZSBhIGxvb2sgaW50byBmaXhpbmcgaXQuCgpDYW4geW91IHNlbmQgbWUg
dGhlIGNvbmZpZyB0aGF0IGJyZWFrcyBwbGVhc2U/Cgo+IC0tLSBhL2RyaXZlcnMvaW5wdXQva2V5
Ym9hcmQvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvS2NvbmZpZwo+IEBA
IC00NzAsNyArNDcwLDcgQEAgY29uZmlnIEtFWUJPQVJEX1BYQTkzMF9ST1RBUlkKPiAgCj4gIGNv
bmZpZyBLRVlCT0FSRF9QTUlDOFhYWAo+ICAgICAgICAgdHJpc3RhdGUgIlF1YWxjb21tIFBNSUM4
WFhYIGtleXBhZCBzdXBwb3J0Igo+IC0gICAgICAgZGVwZW5kcyBvbiBNRkRfUE04WFhYCj4gKyAg
ICAgICBkZXBlbmRzIG9uIE1GRF9QTThYWFggJiYgQlJPS0VOCj4gICAgICAgICBzZWxlY3QgSU5Q
VVRfTUFUUklYS01BUAo+ICAgICAgICAgaGVscAo+ICAgICAgICAgICBTYXkgWSBoZXJlIGlmIHlv
dSB3YW50IHRvIGVuYWJsZSB0aGUgZHJpdmVyIGZvciB0aGUgUE1JQzhYWFgKPiAKCi0tIApMZWUg
Sm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8u
b3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzog
RmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
