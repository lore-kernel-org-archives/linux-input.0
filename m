From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
Date: Fri, 6 Feb 2015 15:59:05 +0100
Message-ID: <20150206145904.GA7872@amd>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
 <20150206134953.GA25683@amd> <1423233788.31516.5.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1423233788.31516.5.camel@AMDC1943>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Milo Kim <milo.kim@ti.com>, x86@kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, platform-driver-x86@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Lee Jones <lee.jones@linaro.org>, ac100@lists.launchpad.net, devel@driverdev.osuosl.org, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, patches@opensource.wolfsonmicro.com, linux-acpi@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Julian Andres Klode <jak@jak-linux.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-tegra@vger.k
List-Id: linux-input@vger.kernel.org

T24gRnJpIDIwMTUtMDItMDYgMTU6NDM6MDgsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6Cj4g
T24gcGnEhSwgMjAxNS0wMi0wNiBhdCAxNDo0OSArMDEwMCwgUGF2ZWwgTWFjaGVrIHdyb3RlOgo+
ID4gT24gRnJpIDIwMTUtMDEtMzAgMTU6NDc6NTgsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6
Cj4gPiA+IFVzZSBwb3dlcl9zdXBwbHlfcHV0KCkgdG8gZGVjcmVtZW50IHRoZSBwb3dlciBzdXBw
bHkncyBkZXZpY2UgcmVmZXJlbmNlCj4gPiA+IGNvdW50ZXIuCj4gPiA+IAo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrLmtvemxvd3NraUBzYW1zdW5nLmNvbT4KPiA+
ID4gUmV2aWV3ZWQtYnk6IEJhcnRsb21pZWogWm9sbmllcmtpZXdpY3ogPGIuem9sbmllcmtpZUBz
YW1zdW5nLmNvbT4KPiA+ID4gUmV2aWV3ZWQtYnk6IFNlYmFzdGlhbiBSZWljaGVsIDxzcmVAa2Vy
bmVsLm9yZz4KPiA+IAo+ID4gMTEsMTMsMjAgbm90aGluZyBvYnZpb3VzbHkgd3JvbmcuIEJ1dCBJ
J20gbm90IHN1cmUgaWYgSSBzdHVkaWVkIHRoZW0KPiA+IGNsb3NlbHkgZW5vdWdoIHRvIHdhcnJh
bnQgYW4gQUNLLgo+ID4gCj4gPiBJdCB3b3VsZCBiZSBnb29kIHRvIGdldCB0aGlzIGludG8ga2Vy
bmVsIC0tIEkgc2VlbiBubyBiYWQgY29tbWVudHMsCj4gPiBhbmQgaXQgaXMgbm90IGdvaW5nIHRv
IGltcHJvdmUgd2l0aG91dCBtZXJnZSBpbnRvIG1haW5saW5lLgo+IAo+IFRoYW5rcyBmb3IgbG9v
a2luZyBhdCBwYXRjaHNldC4gSXQgd291bGQgYmUgcmVhbGx5IG5pY2UgaWYgdGhpcyBjb3VsZCBi
ZQo+IHRlc3RlZCBmb3Igc29tZSB0aW1lIGluIGxpbnV4LW5leHQuIFN1Y2ggdGVzdGluZyB3b3Vs
ZCBoZWxwIGEgbG90LiBCdXQgSQo+IG5lZWQgYWNrcyBmcm9tIHZhcmlvdXMgbWFpbnRhaW5lcnMg
Zm9yIHRoYXQuCgpBY3R1YWxseSwgeW91IGRvbid0LiBUaGUgdmFyaW91cyBtYWludGFpbmVycyBj
bGVhcmx5IGRvbid0IGNhcmUgYXQKdGhpcyBwb2ludC4gVGhleSBoYWQgZW5vdWdoIHRpbWUuIFNv
IHlvdSBzZWxlY3Qgb25lIG1haW50YWluZXIgeW91CndhbnQgdG8gcHVzaCB0aGlzIHRocm91Z2gs
IGFuZCB5b3UgcHVzaCBpdC4KClNvbWVvbmUgbWF5IGNvbXBsYWluLCBzbyB5b3UnbGwgc29sdmUg
dGhlIGZlZWRiYWNrLi4uCgpHb29kIGx1Y2ssCgkJCQkJCQkJCVBhdmVsCgo+IE9mIGNvdXJzZSB0
aGUgcGF0Y2hzZXQgdG8gYmlnIGVub3VnaCB0byBnbyBpbnRvIDMuMjAuIElmIG5lZWRlZCB0aGlz
Cj4gY291bGQgYmUgdGFrZW4gZ3JhZHVhbGx5IGluIGZvbGxvd2luZyBzdGVwczoKPiAxLiBQYXRj
aGVzIDEtMiAocGF0Y2ggMiB0b3VjaGVzICphbGwgZHJpdmVycyopLAo+IDIuIFBhdGNoZXMgMy0x
MCAodG91Y2ggb25seSBpbmRpdmlkdWFsIGRyaXZlcnMpLAo+IDMuIFBhdGNoIDExIChhZ2FpbiAq
ZXZlcnl0aGluZyogY2hhbmdlZCksCj4gNC4gUGF0Y2hlcyAxMi0yMCAoaW5kaXZpZHVhbCBjaGFu
Z2VzKS4KPiAKPiBJbiBzdWNoIGNhc2UgSSB3aWxsIHJlZnJlc2ggZXZlcnl0aGluZyBhZnRlciBl
YWNoIHN0ZXAgc28gbmV3IGRyaXZlcnMKPiB3b3VsZCBiZSBhbHNvIHVwZGF0ZWQuCj4gCj4gVGhh
bmtzIGFnYWluIFBhdmVsIGZvciBwcm9tcHQgcmVwbGllcy4KCi0tIAooZW5nbGlzaCkgaHR0cDov
L3d3dy5saXZlam91cm5hbC5jb20vfnBhdmVsbWFjaGVrCihjZXNreSwgcGljdHVyZXMpIGh0dHA6
Ly9hdHJleS5rYXJsaW4ubWZmLmN1bmkuY3ovfnBhdmVsL3BpY3R1cmUvaG9yc2VzL2Jsb2cuaHRt
bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBt
YWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2
LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
