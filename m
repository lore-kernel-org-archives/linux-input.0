From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong
 information of ldo23 and ldo25
Date: Fri, 06 Jan 2017 18:06:43 +0900
Message-ID: <73639ec8-028a-56a2-0b47-3465974ec3f3@samsung.com>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035913epcas5p20336406863f1029ccf614520f366ddcf@epcas5p2.samsung.com>
 <1483675149-32598-2-git-send-email-jcsing.lee@samsung.com>
 <20170106070539.wd3kfhi77pa5ekcy@kozik-lap> <586F4554.6020206@samsung.com>
 <20170106085026.5pfwyxt2qipzbjpy@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20170106085026.5pfwyxt2qipzbjpy@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, beomho.seo@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

T24gMjAxN+uFhCAwMeyblCAwNuydvCAxNzo1MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToK
PiBPbiBGcmksIEphbiAwNiwgMjAxNyBhdCAwNDoyMDo1MlBNICswOTAwLCBDaGFud29vIENob2kg
d3JvdGU6Cj4+IE9uIDIwMTfrhYQgMDHsm5QgMDbsnbwgMTY6MDUsIEtyenlzenRvZiBLb3psb3dz
a2kgd3JvdGU6Cj4+PiBPbiBGcmksIEphbiAwNiwgMjAxNyBhdCAxMjo1OTowNVBNICswOTAwLCBK
YWVjaHVsIExlZSB3cm90ZToKPj4+PiBGcm9tOiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1z
dW5nLmNvbT4KPj4+Pgo+Pj4+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIHdyb25nIGluZm9ybWF0aW9u
IG9mIGxkbzIzIGFuZCBsZG8yNSBvbiBib3RoIFRNMiBhbmQgVE0yRS4KPj4+Cj4+PiBQbGVhc2Ug
ZGVzY3JpYmUgd2hhdCBpcyBleGFjdGx5IHdyb25nIGFuZCBob3cgaXQgYWZmZWN0cyB0aGUKPj4+
IHN5c3RlbS91c2VyLiBUaGlzIGlzIGdvaW5nIHRvIHRoZSBmaXhlcyBzbyBpdCBuZWVkcyBhIGdv
b2QgZXhwbGFuYXRpb24uCj4+Cj4+IFdoZW4gSSBwb3N0ZWQgdGhlIHBhdGNoWzFdLCBJIHJlZmVy
IHRvIHRoZSBvbGQgc2NoZW1hdGljIGRvY3VtZW50IG9mIGJvdGggVE0yIGFuZCBUTTJFLgo+PiBb
MV0gMDFlNWQyMzUyMTUyICgiYXJtNjQ6IGR0czogZXh5bm9zOiBBZGQgZHRzIGZpbGUgZm9yIEV4
eW5vczU0MzMtYmFzZWQgVE0yIGJvYXJkIikKPj4KPj4gQWZ0ZXIgY2hlY2tpbmcgdGhlIGhpZ2hl
c3QgdmVyc2lvbiBvZiBzY2hlbWF0aWMgZG9jdW1lbnQgb2YgYm90aCBUTTIgYW5kIFRNMkUsCj4+
IHRoZXJlIGlzIG5vIGRpZmZlcmVuY2Ugb2YgbGRvMjMvbGRvMjUgb24gYm90aCBUTTIgYW5kIFRN
MkUuCj4+IC0gbGRvMjMgaXMgdXNlZCBvbiBUTTIvVE0yRSwgYnV0IHRoZSBuYW1lL21heC1taWNy
b3ZvbHQgYXJlIHdyb25nLiAKPj4gLSBsZG8yNSBpc24ndCB1c2VkIG9uIFRNMi9UTTJFLiAobm90
IGNvbm5lY3RlZCkKPj4KPj4gQmVjYXVzZSBsZG8yMyBhbmQgbG9kMjUgYXJlIG5vdCB1c2VkIG9u
IG90aGVyIGRldmljZSBpbiBFeHlub3M1NDMzIGFuZCBUTTIgYm9hcmQuCj4+IHRoaXMgcGF0Y2gg
ZG9lcyBub3QgYWZmZWN0IHRoZSBvcGVyYXRpb24gdG8gc3lzdGVtL3VzZXIuCj4gCj4gSWYgaXQg
ZG9lcyBub3QgYWZmZWN0IGFueW9uZSAoaW5jbHVkaW5nIFRNMi9UTTJFKSB0aGVuIHRoaXMgZG8g
bm90IGhhdmUKPiB0byBiZSBhIGZpeC4gQW0gSSByaWdodD8KClRoaXMgcGF0Y2ggZG9lcyBub3Qg
YWZmZWN0IHRoZSBUTTIvVE0yRSdzIG9wZXJhdGlvbgpiZWNhdXNlIGxkbzIzLzI1IGFyZSBub3Qg
dXNlZCBvbiBUTTIvVE0yRS4gSnVzdCBmaXggdGhlIHdyb25nIGluZm9ybWF0aW9uLgoKLS0gCkJl
c3QgUmVnYXJkcywKQ2hhbndvbyBDaG9pClMvVyBDZW50ZXIsIFNhbXN1bmcgRWxlY3Ryb25pY3MK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
