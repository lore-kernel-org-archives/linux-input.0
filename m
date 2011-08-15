From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
	SSP/SPI) driver
Date: Mon, 15 Aug 2011 17:53:45 +0800
Message-ID: <CAMPhdO-8QNDKVjLArWVoSUXHHCOgCFMrhbxAyXwvUzvWF4dS+A@mail.gmail.com>
References: <CAMPhdO8WOsnbCvqGGYqnCMiw71esp-OqXryXAS4Xeb0id2DG2g@mail.gmail.com>
	<1313401784.93192.YahooMailClassic@web29015.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1313401784.93192.YahooMailClassic@web29015.mail.ird.yahoo.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: mad_soft@inbox.ru, koen@dominion.thruhere.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, philipp.zabel@gmail.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

T24gTW9uLCBBdWcgMTUsIDIwMTEgYXQgNTo0OSBQTSwgUGF1bCBQYXJzb25zIDxsb3N0LmRpc3Rh
bmNlQHlhaG9vLmNvbT4gd3JvdGU6Cj4gLS0tIE9uIE1vbiwgMTUvOC8xMSwgRXJpYyBNaWFvIDxl
cmljLnkubWlhb0BnbWFpbC5jb20+IHdyb3RlOgo+PiA+IE1GUF9DRkdfT1VUKEdQSU8xMDIsIC4u
LikgaGFkIGFscmVhZHkgbW92ZWQgZnJvbSB0aGUKPj4gcGF0Y2ggdjEgcGxhdGZvcm0gZmlsZSB0
byBwYXRjaCB2MiBtZnAtcHhhMjd4LmggYmVjYXVzZSBpdAo+PiB3YXMgc3VnZ2VzdGVkIHRoYXQg
TUZQIG1hY3JvcyBzaG91bGQgbm90IGJlIHVzZWQgZGlyZWN0bHkuCj4+ID4gQ2hhbmdpbmcgdGhl
IGRpcmVjdGlvbiBpbiB0aGUgcGxhdGZvcm0gZmlsZSB3b3VsZAo+PiBzdXJlbHkgcmVxdWlyZSB1
c2luZyB0aGUgTUZQIG1hY3JvcyBhZ2Fpbiwgc28gaG93IHRvIGtlZXAKPj4gZXZlcnlvbmUgaGFw
cHk/IE1heWJlIEkgc2hvdWxkIGp1c3QgZGVmaW5lIGEgbW9yZSBnZW5lcmljCj4+IG5hbWUgc3Vj
aCBhcyBHUElPMTAyX0dQSU9fT1VUPwo+Pgo+PiBJIGd1ZXNzIHdlIG5lZWQgYSBuZXcgZGVmaW5p
dGlvbiBmb3IgdGhpcyBjb25maWcsIGxvb2tzCj4+IGxpa2UgU0NMSyBoZXJlCj4+IGlzIGRpZmZl
cmVudCBmcm9tIGEgbm9ybWFsIGNvbmZpZ3VyYXRpb24gYmVjYXVzZSB0aGUgcHhhMjd4Cj4+IGlz
IHVzZWQKPj4gYXMgYSBTUEkgc2xhdmUgaGVyZT8KPj4KPj4gQW5kIGNoZWNrZWQgYSBiaXQgd2l0
aCB0aGUgcHhhMjd4IGRldmVsb3BlciBtYW51YWwsIHRoZXJlCj4+IGlzIG5vIFNDTEsKPj4gZm9y
IHRoaXMgR1BJTzEwMj8/Pz8KPgo+IEdQSU8xMDIgaXMgYXBwYXJlbnRseSBhIG5hdnBvaW50IHBv
d2VyIGVuYWJsZTsgdGhlIG9sZCBsaW51eC0yLjYuMjEtaGgyMCBrZXJuZWwgZnJvbSBoYW5kaGVs
ZHMub3JnIGRlZmluZXMgaXQgdGh1czoKPgo+ICNkZWZpbmUgR1BJT19OUl9IWDQ3MDBfU1lOQVBU
SUNTX1BPV0VSX09OIMKgIMKgIMKgIMKgMTAyCj4KPiBJIHZlcmlmaWVkIHRoYXQgaXQgZG9lcyBu
ZWVkIHRvIGJlIGFzc2VydGVkIGJlZm9yZSB0aGUgbmF2cG9pbnQgd2lsbCB3b3JrLiBJIGRvbid0
IHBvc3Nlc3MgYW55IGh4NDcwMCBkZXZlbG9wZXIgZG9jdW1lbnRhdGlvbjsgcGVyaGFwcyBQaGls
aXBwIGNhbiBzaGVkIHNvbWUgbGlnaHQgb24gR1BJTzEwMi4KPgoKQWgsIHRoYXQgY2FzZSBpdCdz
IHNpbXBseSBhIEdQSU8gdGhlbi4gWW91IGNvdWxkIHNpbXBseSB1c2UgR1BJTzEwMl9HUElPCnRv
IGNvbmZpZ3VyZSB0aGUgcGluLiBBbmQgZGlyZWN0aW9uIGlzIGNvbnRyb2xsZWQgYnkgZ3Bpb19k
aXJlY3Rpb25fKigpLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
