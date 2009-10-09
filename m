From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] add analog devices AD714X
	captouchinput driver
Date: Fri, 9 Oct 2009 17:36:32 -0400
Message-ID: <8bd0f97a0910091436na026660x5540dc4466483614@mail.gmail.com>
References: <1252652006-5270-1-git-send-email-21cnbao@gmail.com>
	<8A42379416420646B9BFAC9682273B6D0DC3BD95@limkexm3.ad.analog.com>
	<8bd0f97a0910090156g2a8fba58r4085422f3a79c892@mail.gmail.com>
	<1255079007.8362.70.camel@macbook.infradead.org>
	<8bd0f97a0910090218j6a2aa6aaq497fba3f04d7b19f@mail.gmail.com>
	<alpine.LRH.2.00.0910092331040.12171@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <alpine.LRH.2.00.0910092331040.12171-1ReQVI26iDCaZKY3DrU6dA@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

T24gRnJpLCBPY3QgOSwgMjAwOSBhdCAxNzozMywgSmlyaSBLb3NpbmEgd3JvdGU6Cj4gT24gRnJp
LCA5IE9jdCAyMDA5LCBNaWtlIEZyeXNpbmdlciB3cm90ZToKPj4gPiBIb3cgZGlkIEkgZ2V0IHN1
YnNjcmliZWQgdG8gdGhpcyBsaXN0LCBhbnl3YXk/Cj4+Cj4+IGkgdGhpbmsgaSBtaWdodCBoYXZl
IGFjY2lkZW50YWxseSBhZGRlZCB5b3UgdG8gdGhlIHN1YnNjcmliZWQgbGlzdAo+PiB3aGlsZSBw
cm9jZXNzaW5nIG1vZGVyYXRpb24gcmVxdWVzdHMgd2hlbiBpIG1lYW50IHRvIGFkZCB5b3UgdG8g
anVzdAo+PiB0aGUgYXBwcm92ZWQgbGlzdC4gwqBpJ2xsIGZpeCBpdCB1cCBvZiBjb3Vyc2UsIHNv
cnJ5IGFib3V0IHRoYXQuCj4KPiBCVFcgeW91IHNob3VsZCByYXRoZXIgY2hlY2sgeW91ciBwcm9j
ZXNzZXNzLCB0aGlzIGhhcHBlbmVkIHRvIG1lIGEgZmV3Cj4gd2Vla3MgYWdvIGFzIHdlbGwgLS0g
SSBoYWQgdG8gdW5zdWJzY3JpYmUgbWFudWFsbHkgYWZ0ZXIgc2VuZGluZyBzb21lCj4gbWVzc2Fn
ZSB0byB1Y2xpbnV4IGxpc3QgYW5kIGdldHRpbmcgYXV0b21hdGljYWxseSBzdWJzY3JpYmVkIGFm
dGVyd2FyZHMuCgppIHRoaW5rIGl0J3MgYmVjYXVzZSBvZiBhIG5ldyBzY3JpcHQgdGhhdCB3ZSd2
ZSBzdGFydGVkIHVzaW5nIHJlY2VudGx5CnRoYXQgbWFuYWdlcyBtb2RlcmF0aW9ucyB2aWEgdGhl
IGNvbW1hbmQgbGluZSByYXRoZXIgdGhhbiB3ZWIKaW50ZXJmYWNlLiAgaXQgc3Vic2NyaWJlcyBw
ZW9wbGUgaW5zdGVhZCBvZiBhZGRpbmcgdGhlbSB0byB0aGUKYXBwcm92ZWQgbGlzdC4gIGkgdmFn
dWVseSByZWNhbGwgdGhpcyBhcHBseWluZyB0byBhYm91dCAzIG9yIDQgcGVvcGxlLgotbWlrZQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVY2xpbnV4LWRp
c3QtZGV2ZWwgbWFpbGluZyBsaXN0ClVjbGludXgtZGlzdC1kZXZlbEBibGFja2Zpbi51Y2xpbnV4
Lm9yZwpodHRwczovL2JsYWNrZmluLnVjbGludXgub3JnL21haWxtYW4vbGlzdGluZm8vdWNsaW51
eC1kaXN0LWRldmVs
