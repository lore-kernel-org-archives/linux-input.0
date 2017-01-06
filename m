From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong
 information of ldo23 and ldo25
Date: Fri, 6 Jan 2017 11:12:44 +0200
Message-ID: <20170106091244.3vgpw7lceqfyb446@kozik-lap>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035913epcas5p20336406863f1029ccf614520f366ddcf@epcas5p2.samsung.com>
 <1483675149-32598-2-git-send-email-jcsing.lee@samsung.com>
 <20170106070539.wd3kfhi77pa5ekcy@kozik-lap>
 <586F4554.6020206@samsung.com>
 <20170106085026.5pfwyxt2qipzbjpy@kozik-lap>
 <73639ec8-028a-56a2-0b47-3465974ec3f3@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <73639ec8-028a-56a2-0b47-3465974ec3f3@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi.shyti@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, beomho.seo@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

T24gRnJpLCBKYW4gMDYsIDIwMTcgYXQgMDY6MDY6NDNQTSArMDkwMCwgQ2hhbndvbyBDaG9pIHdy
b3RlOgo+IE9uIDIwMTfrhYQgMDHsm5QgMDbsnbwgMTc6NTAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6Cj4gPiBPbiBGcmksIEphbiAwNiwgMjAxNyBhdCAwNDoyMDo1MlBNICswOTAwLCBDaGFu
d29vIENob2kgd3JvdGU6Cj4gPj4gT24gMjAxN+uFhCAwMeyblCAwNuydvCAxNjowNSwgS3J6eXN6
dG9mIEtvemxvd3NraSB3cm90ZToKPiA+Pj4gT24gRnJpLCBKYW4gMDYsIDIwMTcgYXQgMTI6NTk6
MDVQTSArMDkwMCwgSmFlY2h1bCBMZWUgd3JvdGU6Cj4gPj4+PiBGcm9tOiBDaGFud29vIENob2kg
PGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPiA+Pj4+Cj4gPj4+PiBUaGlzIHBhdGNoIGZpeGVzIHRo
ZSB3cm9uZyBpbmZvcm1hdGlvbiBvZiBsZG8yMyBhbmQgbGRvMjUgb24gYm90aCBUTTIgYW5kIFRN
MkUuCj4gPj4+Cj4gPj4+IFBsZWFzZSBkZXNjcmliZSB3aGF0IGlzIGV4YWN0bHkgd3JvbmcgYW5k
IGhvdyBpdCBhZmZlY3RzIHRoZQo+ID4+PiBzeXN0ZW0vdXNlci4gVGhpcyBpcyBnb2luZyB0byB0
aGUgZml4ZXMgc28gaXQgbmVlZHMgYSBnb29kIGV4cGxhbmF0aW9uLgo+ID4+Cj4gPj4gV2hlbiBJ
IHBvc3RlZCB0aGUgcGF0Y2hbMV0sIEkgcmVmZXIgdG8gdGhlIG9sZCBzY2hlbWF0aWMgZG9jdW1l
bnQgb2YgYm90aCBUTTIgYW5kIFRNMkUuCj4gPj4gWzFdIDAxZTVkMjM1MjE1MiAoImFybTY0OiBk
dHM6IGV4eW5vczogQWRkIGR0cyBmaWxlIGZvciBFeHlub3M1NDMzLWJhc2VkIFRNMiBib2FyZCIp
Cj4gPj4KPiA+PiBBZnRlciBjaGVja2luZyB0aGUgaGlnaGVzdCB2ZXJzaW9uIG9mIHNjaGVtYXRp
YyBkb2N1bWVudCBvZiBib3RoIFRNMiBhbmQgVE0yRSwKPiA+PiB0aGVyZSBpcyBubyBkaWZmZXJl
bmNlIG9mIGxkbzIzL2xkbzI1IG9uIGJvdGggVE0yIGFuZCBUTTJFLgo+ID4+IC0gbGRvMjMgaXMg
dXNlZCBvbiBUTTIvVE0yRSwgYnV0IHRoZSBuYW1lL21heC1taWNyb3ZvbHQgYXJlIHdyb25nLiAK
PiA+PiAtIGxkbzI1IGlzbid0IHVzZWQgb24gVE0yL1RNMkUuIChub3QgY29ubmVjdGVkKQo+ID4+
Cj4gPj4gQmVjYXVzZSBsZG8yMyBhbmQgbG9kMjUgYXJlIG5vdCB1c2VkIG9uIG90aGVyIGRldmlj
ZSBpbiBFeHlub3M1NDMzIGFuZCBUTTIgYm9hcmQuCj4gPj4gdGhpcyBwYXRjaCBkb2VzIG5vdCBh
ZmZlY3QgdGhlIG9wZXJhdGlvbiB0byBzeXN0ZW0vdXNlci4KPiA+IAo+ID4gSWYgaXQgZG9lcyBu
b3QgYWZmZWN0IGFueW9uZSAoaW5jbHVkaW5nIFRNMi9UTTJFKSB0aGVuIHRoaXMgZG8gbm90IGhh
dmUKPiA+IHRvIGJlIGEgZml4LiBBbSBJIHJpZ2h0Pwo+IAo+IFRoaXMgcGF0Y2ggZG9lcyBub3Qg
YWZmZWN0IHRoZSBUTTIvVE0yRSdzIG9wZXJhdGlvbgo+IGJlY2F1c2UgbGRvMjMvMjUgYXJlIG5v
dCB1c2VkIG9uIFRNMi9UTTJFLiBKdXN0IGZpeCB0aGUgd3JvbmcgaW5mb3JtYXRpb24uCgpBaCwg
b2theSwgdGhhbmtzIGZvciBleHBsYW5hdGlvbi4gUGxlYXNlIGp1c3QgcmViYXNlIG9uIGN1cnJl
bnQKbmV4dC9kdDY0IChvciBmb3ItbmV4dCBvciBqdXN0IG15Cmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvOTUwMDE1My8pIHNvIHRoZSBhbHdheXMtb2ZmIHByb3BlcnR5Cndvbid0
IGJlIGNvcGllZC4KCkknbGwgdGFrZSBpdCB0aGVuIGZvciB2NC4xMS4KCkJlc3QgcmVnYXJkcywK
S3J6eXN6dG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
