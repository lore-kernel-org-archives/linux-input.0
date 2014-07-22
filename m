From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of
 gpio_remove retval in driver
Date: Tue, 22 Jul 2014 17:01:58 +0100
Message-ID: <20140722160158.GE23210@lee--X1>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Samuel Ortiz <sameo@linux.intel.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, abdoulaye berthe <berthe.ab@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, "arm@kernel.org" <arm@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Michael Buesch <m@bues.ch>, Greg KH <gregkh>
List-Id: linux-input@vger.kernel.org

T24gVHVlLCAyMiBKdWwgMjAxNCwgTGludXMgV2FsbGVpaiB3cm90ZToKCj4gT24gU2F0LCBKdWwg
MTIsIDIwMTQgYXQgMTA6MzAgUE0sIGFiZG91bGF5ZSBiZXJ0aGUgPGJlcnRoZS5hYkBnbWFpbC5j
b20+IHdyb3RlOgo+IAo+IEhlYWRzIHVwLiBSZXF1ZXN0aW5nIEFDS3MgZm9yIHRoaXMgcGF0Y2gg
b3IgSSdtIGF0bGVhc3Qgd2FybmluZyB0aGF0IGl0IHdpbGwgYmUKPiBhcHBsaWVkLiBXZSdyZSBn
ZXR0aW5nIHJpZCBvZiB0aGUgcmV0dXJuIHZhbHVlIGZyb20gZ3Bpb2NoaXBfcmVtb3ZlKCkuCj4g
Cj4gPiB0aGlzIHJlbW92ZSBhbGwgcmVmZXJlbmNlIHRvIGdwaW9fcmVtb3ZlIHJldHZhbCBpbiBh
bGwgZHJpdmVyCj4gPiBleGNlcHQgcGluY3RybCBhbmQgZ3Bpby4gdGhlIHNhbWUgdGhpbmcgaXMg
ZG9uZSBmb3IgZ3BpbyBhbmQKPiA+IHBpbmN0cmwgaW4gdHdvIGRpZmZlcmVudCBwYXRjaGVzLgo+
ID4KPiA+IFNpZ25lZC1vZmYtYnk6IGFiZG91bGF5ZSBiZXJ0aGUgPGJlcnRoZS5hYkBnbWFpbC5j
b20+Cj4gKC4uLikKPiAKPiBJIHRoaW5rIHRoaXMgcGF0Y2ggcHJvYmFibHkgbmVlZHMgdG8gYmUg
YnJva2VuIGRvd24gcGVyLXN1YnN5c3RlbSBhcyBpdAo+IGhpdHMgYWxsIG92ZXIgdGhlIG1hcC4g
QnV0IGxldCdzIHN0YXJ0IHJlcXVlc3RpbmcgQUNLcyBmb3IgdGhlCj4gaW5kaXZpZHVhbCBwaWVj
ZXMuCj4gQWN0dWFsbHkgSSB0aGluayBpdCB3aWxsIGJlIE9LIHRvIG1lcmdlIGJlY2F1c2UgdGhl
cmUgaXMgbGlrZWx5IG5vdCBtdWNoIGNodXJuCj4gYXJvdW5kIHRoZXNlIGNvZGUgc2l0ZXMuCj4g
Cj4gSSdtIGEgYml0IHRvcm4gYmV0d2VlbiBqdXN0IHdhbnRpbmcgYSBiaWcgcGF0Y2ggZm9yIHRo
aXMgaGl0dGluZyBkcml2ZXJzL2dwaW8KPiBhbmQgc21hbGxlciBwYXRjaGVzIGhpdHRpbmcgb25l
IHN1YnN5c3RlbSBhdCBhIHRpbWUuIFdlIHNob3VsZCBiZSBhYmxlCj4gdG8gaGFtbWVyIHRoaXMg
aW4gb25lIHN3aXRjaCBzdHJpa2UuCgpJdCB3b3VsZCBiZSBiZXR0ZXIgaWYgeW91IGNvdWxkIGRl
dmlzZSBhIHBsYW4gdG8gbWFrZSB0aGUgc3dpdGNoIGEKc3Vic3lzdGVtIGF0IGEgdGltZS4KClsu
Li5dCgo+ID4gIGRyaXZlcnMvbWZkL2FzaWMzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMyArKy0KPiA+ICBkcml2ZXJzL21mZC9odGMtaTJjcGxkLmMgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDggKy0tLS0tLS0KPiA+ICBkcml2ZXJzL21mZC9zbTUwMS5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTcgKysrLS0tLS0tLS0tLS0tLS0KPiA+ICBkcml2ZXJzL21mZC90YzYz
OTN4Yi5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTMgKysrKy0tLS0tLS0tLQo+ID4gIGRy
aXZlcnMvbWZkL3VjYjF4MDAtY29yZS5jICAgICAgICAgICAgICAgICAgICAgfCAgOCArKy0tLS0t
LQo+IAo+IExlZS9TYW0gY2FuIGVpdGhlciBvZiB5b3UgQUNLIHRoaXM/CgpJIGRvbid0IHNlZSBh
bnkgY29kZT8KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5n
IFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNv
Q3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
