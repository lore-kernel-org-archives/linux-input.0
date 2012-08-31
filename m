From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 8/8] input: ab8500-ponkey: Rely on MFD core to convert
 IRQs to virtual
Date: Fri, 31 Aug 2012 08:31:33 +0100
Message-ID: <20120831073123.GA13298@gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ-HOGy_sdsCQSNOdYTDzHFszk0OySM88TjO-neSJUz0A@mail.gmail.com>
 <20120821092328.GC26899@gmail.com>
 <20120821164244.GA4672@core.coreip.homeip.net>
 <20120830131202.GG14145@gmail.com>
 <20120830230221.GD21501@core.coreip.homeip.net>
 <20120830230323.GE21501@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120830230323.GE21501@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linus.walleij@stericsson.com, arnd@arndb.de, Linus Walleij <linus.walleij@linaro.org>, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

T24gVGh1LCBBdWcgMzAsIDIwMTIgYXQgMDQ6MDM6MjNQTSAtMDcwMCwgRG1pdHJ5IFRvcm9raG92
IHdyb3RlOgo+IE9uIFRodSwgQXVnIDMwLCAyMDEyIGF0IDA0OjAyOjIxUE0gLTA3MDAsIERtaXRy
eSBUb3Jva2hvdiB3cm90ZToKPiA+IE9uIFRodSwgQXVnIDMwLCAyMDEyIGF0IDAyOjEyOjA0UE0g
KzAxMDAsIExlZSBKb25lcyB3cm90ZToKPiA+ID4gPiBTb3JyeSBmb3IgdGhlIGRlbGF5LiBZZXMs
IHRoaXMgc2hvdWRsIGJlIGZpbmUsIGJ1dCBzaW5jZSBpdCBpcwo+ID4gPiA+IGVzc2VudGlhbGx5
IGEgcmV2ZXJ0IG9mIHRoZSBvcmlnaW5hbCBwYXRjaCBpdCBzaG91bGQgYmUgcHVzaGVkIGluIGFz
Cj4gPiA+ID4gc3VjaC4KPiA+ID4gCj4gPiA+IEhvdydzIHRoaXM/Cj4gPiA+IAo+ID4gCj4gPiBF
eGNlbGxlbnQuCj4gCj4gSSBhc3N1bWUgeW91IHdpbGwgYmUgbWVyZ2luZyBpdCB3aXRoIHRoZSBy
ZXN0IG9mIEFCODUwMCBwYXRjaGVzLCByaWdodD8KClllcywgaWYgdGhhdCdzIG9rYXkgd2l0aCB5
b3Ugb2YgY291cnNlPwoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1QtRXJpY3Nzb24gTGFuZGluZyBU
ZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0Nz
CkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
