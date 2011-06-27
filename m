From: daoguang wu <wdgvip@gmail.com>
Subject: Re: [PATCH] INPUT:Add ABS_PRESSURE input event support for
	touchscreen driver
Date: Mon, 27 Jun 2011 16:57:48 +0800
Message-ID: <BANLkTi=wU04jiOE-5GDDG9Pd4PgVnN61bTkqGfnkShHKo7iVFg@mail.gmail.com>
References: <1308881738-6392-1-git-send-email-wdgvip@gmail.com>
	<20110624124154.GC19804@sirena.org.uk>
	<BANLkTi=O44wyaFB_B83LGiQhAVtFOp64pyhMaCKCf_YZz6b1GA@mail.gmail.com>
	<5EB3BFCD089AD643B9BB63439F5FD5E937BB882D@SHAASIEXM01.ASIA.ROOT.PRI>
	<a8885a55-bf77-43d7-8491-045137aa38ee@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a8885a55-bf77-43d7-8491-045137aa38ee@email.android.com>
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
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wdgvip@gamil.com" <wdgvip@gamil.com>, Baohua Song <Baohua.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

MjAxMS82LzI3IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT46Cj4K
Pgo+IEJhb2h1YSBTb25nIDxCYW9odWEuU29uZ0Bjc3IuY29tPiB3cm90ZToKPgo+Pgo+Pgo+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+IEZyb206IGxpbnV4LWFybS1rZXJuZWwtYm91
bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnCj4+PiBbbWFpbHRvOmxpbnV4LWFybS1rZXJuZWwtYm91
bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnXSBPbiBCZWhhbGYgT2YKPj5kYW9ndWFuZwo+Pj4gd3UK
Pj4+IFNlbnQ6IDIwMTHE6jbUwjI3yNUgMTA6MTUKPj4+IFRvOiBNYXJrIEJyb3duCj4+PiBDYzog
a2dlbmUua2ltQHNhbXN1bmcuY29tOyBiZW4tbGludXhAZmx1ZmYub3JnOwo+Pj4gZG1pdHJ5LnRv
cm9raG92QGdtYWlsLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsKPj4+IHdkZ3Zp
cEBnYW1pbC5jb207IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsKPj4+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gSU5QVVQ6
QWRkIEFCU19QUkVTU1VSRSBpbnB1dCBldmVudCBzdXBwb3J0IGZvcgo+Pj4gdG91Y2hzY3JlZW4g
ZHJpdmVyCj4+Pgo+Pj4gMjAxMS82LzI0IE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53
b2xmc29ubWljcm8uY29tPjoKPj4+ID4gT24gRnJpLCBKdW4gMjQsIDIwMTEgYXQgMTA6MTU6MzhB
TSArMDgwMCwgV3UgRGFvR3Vhbmcgd3JvdGU6Cj4+PiA+PiBUaGUgdG91Y2hzY3JlZW4gZHJpdmVy
IHMzYzI0MTBfdHMuYyBkb2Vzbid0IHdvcmsgd2VsbCB3aGVuIHVzaW5nCj4+PiA+PiB0aGUgdHNs
aWIsIGFuIGFic3RyYWN0aW9uIGxheWVyIGZvciB0b3VjaHNjcmVlbiBwYW5lbCBldmVudHMuCj4+
PiA+PiBUc2xpYiBuZWVkcyBBQlNfWCBBQlNfWSBhbmQgQUJTX1BSRVNTVVJFIGV2ZW50cyB0byBy
ZXBvcnQsIGJ1dAo+Pm9ubHkKPj4+ID4+IHRoZSBmb3JtZXIgdHdvIHRoZSBkcml2ZXIgY2FuIHBy
b3ZpZGUuCj4+PiA+Cj4+PiA+IEl0IHNlZW1zIG11Y2ggbW9yZSBzYW5lIHRvIGZpeCB0aGlzIGlu
IHRzbGliLCB0aGUga2VybmVsIGlzIG5vdAo+PmFjdHVhbGx5Cj4+PiA+IHJlcG9ydGluZyBwcmVz
c3VyZSBtZWFuaW5nZnVsbHkgaGVyZSBhbmQgdGhlcmUncyBhbHJlYWR5IEJUTl9UT1VDSAo+PnRv
Cj4+PiA+IHJlcG9ydCBpZiB0aGUgcGVuIGlzIGRvd24uCj4+PiA+Cj4+PiB5ZWFoLEkgd2lsbCB0
cnkgdG8gZml4IGl0IGluIHRzbGliLgo+Pgo+PllvdSBtYXkgc2VuZCBhIHBhdGNoIHRvIHRzbGli
Lgo+Pgo+Cj4gVGhpcyBoYXMgYWxyZWFkeSBiZWVuIGZpeGVkIGluIHRzbGliIGEgY291cGxlIHll
YXJzIGFnby4gSSdtIG5vdCBzdXJlIGlmIGEKPiBuZXcgdmVyc2lvbiB3YXMgY3V0IG9yIG5vdC4K
PiAtLQo+IERtaXRyeQoKSSB0cnkgdGhlIGxhdGVzdCB0c2xpYiAsYW5kIGZpbmQgdGhlcmUgaXMg
bm8gc3VjaCBwcm9ibGVtIGFuZCB0aGUKbGF0ZXN0IHZlcnNpb24gb2YgdHNsaWIgIGNhbiBiZSBk
b3dubG9hZGVkIGZyb20KZ2l0Oi8vZ2l0aHViLmNvbS9rZXJnb3RoL3RzbGliLmdpdC4KClRoYW5r
cyBhIGxvdC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
