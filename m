From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCHv16 10/13] cec: adv7842: add cec support
Date: Fri, 17 Jun 2016 10:06:31 +0200
Message-ID: <5763AF87.2030700@xs4all.nl>
References: <1461937948-22936-1-git-send-email-hverkuil@xs4all.nl>
 <1461937948-22936-11-git-send-email-hverkuil@xs4all.nl>
 <20160616182228.1bd755d5@recife.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160616182228.1bd755d5@recife.lan>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, dri-devel@lists.freedesktop.org, lars@opdenkamp.eu, Hans Verkuil <hans.verkuil@cisco.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

T24gMDYvMTYvMjAxNiAxMToyMiBQTSwgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIHdyb3RlOgo+IEVt
IEZyaSwgMjkgQXByIDIwMTYgMTU6NTI6MjUgKzAyMDAKPiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWls
QHhzNGFsbC5ubD4gZXNjcmV2ZXU6Cj4gCj4+IEZyb206IEhhbnMgVmVya3VpbCA8aGFucy52ZXJr
dWlsQGNpc2NvLmNvbT4KPj4KPj4gQWRkIENFQyBzdXBwb3J0IHRvIHRoZSBhZHY3ODQyIGRyaXZl
ci4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSGFucyBWZXJrdWlsIDxoYW5zLnZlcmt1aWxAY2lzY28u
Y29tPgo+IAo+IFdvbid0IHJldmlldyBwYXRjaGVzIDEwLTEzLCBhcyB0aGUgc2FtZSByZXZpZXdz
IEkgbWFkZSBmb3IgcGF0Y2ggOQo+IHZlcnkgbGlrZWx5IGFwcGxpZXMuCj4gCj4gQXMgdGhpcyBz
ZXJpZXMgaXMgY2F1c2luZyBub24tc3RhZ2luZyBkcml2ZXJzIHRvIGJlIGRlcGVuZGVudCBvZiBh
Cj4gc3RhZ2luZyBkcml2ZXIsIEknbGwgd2FpdCBmb3IgdGhlIG5leHQgdmVyc2lvbiB0aGF0IHNo
b3VsZCBiZQo+IHNvbHZpbmcgdGhpcyBpc3N1ZS4KPiAKPiBGb3IgdGhlIG5ldyA5LTEzIHBhdGNo
ZXMsIHBsZWFzZSBiZSBzdXJlIHRoYXQgY2hlY2twYXRjaCB3aWxsIGJlCj4gaGFwcHkuIEZvciB0
aGUgc3RhZ2luZyBzdHVmZiwgdGhlIGNoZWNrcGF0Y2ggaXNzdWVzIGNhbiBiZSBzb2x2ZWQKPiBs
YXRlciwgYXMgSSdsbCByZS1jaGVjayBhZ2FpbnN0IGNoZWNrcGF0Y2ggd2hlbiBpdCBtb3ZlcyBm
cm9tIHN0YWdpbmcKPiB0byBtYWluc3RyZWFtLgoKSSBoYXZlIHRvIG1ha2UgY2hhbmdlcyBhbnl3
YXkgc28gSSdsbCBtYWtlIGEgbmV3IHB1bGwgcmVxdWVzdCBsYXRlcgp0b2RheSBmaXhpbmcgYWxs
IHRoZSBjb21tZW50cyBhbmQgcmVwbGFjaW5nIHVuc2lnbmVkIHdpdGggdW5zaWduZWQgaW50Cih3
aGljaCBpcyBhIG1ham9yaXR5IG9mIGFsbCB0aGUgY2hlY2twYXRjaCB3YXJuaW5ncykuCgpEaWQg
SSBtZW50aW9uIHlldCBob3cgbXVjaCBJIGhhdGUgdGhpcyBuZXcgY2hlY2twYXRjaCB3YXJuaW5n
PyBJbiBhbG1vc3QgYWxsCmNhc2VzIEkgYWdyZWUgd2l0aCB0aGUgY2hlY2twYXRjaCBydWxlcywg
YnV0IHRoaXMgb25lIGlzIGp1c3Qgc3R1cGlkIElNSE8uCgpPaCB3ZWxsLCBJJ2xsIG1ha2UgdGhl
IGNoYW5nZS4gUGVyaGFwcyBpdCB3aWxsIGdyb3cgb24gbWUgb3ZlciB0aW1lLgoKUmVnYXJkcywK
CglIYW5zCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
