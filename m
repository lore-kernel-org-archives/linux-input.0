From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input/keyboard: new driver for
	ADP5520 MFD PMICs
Date: Mon, 21 Sep 2009 09:40:46 -0400
Message-ID: <8bd0f97a0909210640q3ead3467gcccac227a9088d76@mail.gmail.com>
References: <1253211850-29309-1-git-send-email-vapier@gentoo.org>
	<20090919233044.8361a912.akpm@linux-foundation.org>
	<8bd0f97a0909201540t25dd2337o15ebe63a2a9ca4ec@mail.gmail.com>
	<20090920210451.60ad1b1f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20090920210451.60ad1b1f.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

T24gTW9uLCBTZXAgMjEsIDIwMDkgYXQgMDA6MDQsIEFuZHJldyBNb3J0b24gd3JvdGU6Cj4gT24g
U3VuLCAyMCBTZXAgMjAwOSAxODo0MDo0MSAtMDQwMCBNaWtlIEZyeXNpbmdlciB3cm90ZToKPj4g
T24gU3VuLCBTZXAgMjAsIDIwMDkgYXQgMDI6MzAsIEFuZHJldyBNb3J0b24gd3JvdGU6Cj4+ID4g
T24gVGh1LCAxNyBTZXAgMjAwOSAxNDoyNDoxMCAtMDQwMCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gPj4gK3N0cnVjdCBhZHA1NTIwX2tleXMgewo+PiA+PiArIF9fIF9fIHN0cnVjdCBpbnB1dF9k
ZXYgKmlucHV0Owo+PiA+PiArIF9fIF9fIHN0cnVjdCBub3RpZmllcl9ibG9jayBub3RpZmllcjsK
Pj4gPj4gKyBfXyBfXyBzdHJ1Y3QgZGV2aWNlICptYXN0ZXI7Cj4+ID4+ICsgX18gX18gdW5zaWdu
ZWQgc2hvcnQga2V5Y29kZVtBRFA1NTIwX0tFWU1BUFNJWkVdOwo+PiA+Cj4+ID4gV2hlcmUgaXMg
QURQNTUyMF9LRVlNQVBTSVpFIGRlZmluZWQ/Cj4+Cj4+IGFsbCB0aGVzZSB0aGluZ3MgYXJlIGlu
IHRoZSBjb21tb24gbWZkIGFkcDU1MjAgcGF0Y2guIMKgaXQgaW50cm9kdWNlcyBhCj4+IGNvbW1v
biBhZHA1NTIwIGhlYWRlci4KPgo+IGVyciwgd2hhdCBjb21tb24gTUZEIHBhdGNoPyDCoFRoZXJl
IHdhcyBub3RoaW5nIGluIGVpdGhlciB0aGUgY2hhbmdlbG9nCj4gbm9yIHRoZSBwYXRjaCB0aXRs
ZSB3aGljaCBpbmRpY2F0ZWQgdGhhdCB0aGlzIHBhdGNoIGhhZCBhIGRlcGVuZGVuY3kgb24KPiBv
dGhlciBwYXRjaGVzLiDCoFRoaXMgbWFrZXMgdGhpbmdzIGhhcmRlciBmb3IgbWVyZ2VycyBhbmQg
cmV2aWV3ZXJzLAo+IGVzcGVjaWFsbHkgd2hlbiB0aGUgcGF0Y2hzZXQgaGl0cyBtdWx0aXBsZSBz
dWJzeXN0ZW1zLCBtYWludGFpbmVkIGJ5Cj4gbXVsdGlwbGUgZGV2ZWxvcGVycy4KPgo+IFByb2Jh
Ymx5IHRoZSBiZXN0IHdheSB0byBoYW5kbGUgdGhpcyBzb3J0IG9mIHRoaW5nIGlzIHRvIHByZXNl
bnQgaXQgYXMgYQo+IHNlcXVlbmNlLW51bWJlcmVkIHBhdGNoIHNlcmllcyB3aXRoIHdlbGwtY2hv
c2VuIGNjJ3MgYW5kIGFuIG92ZXJhbGwKPiBkZXNjcmlwdGlvbiBvZiB0aGUgZGVwZW5kZW5jaWVz
IGFuZCBwZXJoYXBzIHRoZSBtZXJnZSBwbGFuIGluIFtwYXRjaAo+IDAvbl0uCgp0aGUgTUZEIHBh
dGNoIGhhcyBiZWVuIHNlbnQgdG8gdGhlIE1GRCBndXkgYWxyZWFkeSBmb3IgcmV2aWV3LiAgYmVp
bmcKYW4gTUZEIG1lYW5zIGl0IHRvdWNoZXMgbGlrZSA0IG9yIDUgZGlmZmVyZW50IHN1YnN5c3Rl
bXMuICBidXQgdGhlCm9ubHkgZGVwZW5kZW5jeSBpcyBvbiB0aGUgTUZEIGNvcmUuCi1taWtlCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVjbGludXgtZGlz
dC1kZXZlbCBtYWlsaW5nIGxpc3QKVWNsaW51eC1kaXN0LWRldmVsQGJsYWNrZmluLnVjbGludXgu
b3JnCmh0dHBzOi8vYmxhY2tmaW4udWNsaW51eC5vcmcvbWFpbG1hbi9saXN0aW5mby91Y2xpbnV4
LWRpc3QtZGV2ZWw=
