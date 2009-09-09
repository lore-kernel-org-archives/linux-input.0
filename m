From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2]add analog devices
	AD714Xcaptouch input driver
Date: Wed, 9 Sep 2009 02:05:58 -0400
Message-ID: <8bd0f97a0909082305q632a4b30y3be36ce54ce9d509@mail.gmail.com>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com>
	<200909081149.28942.david-b@pacbell.net>
	<0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com>
	<200909081929.57935.david-b@pacbell.net>
	<0F1B54C89D5F954D8535DB252AF412FA04B118A5@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04B118A5-SGdA1W8gREmuVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: "Song, Barry" <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

T24gVHVlLCBTZXAgOCwgMjAwOSBhdCAyMzozMywgU29uZywgQmFycnkgd3JvdGU6Cj4gK3N0YXRp
YyBpbmxpbmUgaW50IGFkNzE0eF9zcGlfcmVnaXN0ZXJfZHJpdmVyKHN0cnVjdCBzcGlfZHJpdmVy
ICpzcGlfZHJ2KQo+ICt7Cj4gKyDCoCDCoCDCoCByZXR1cm4gc3BpX3JlZ2lzdGVyX2RyaXZlcihz
cGlfZHJ2KTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2b2lkIGFkNzE0eF9zcGlfdW5yZWdp
c3Rlcl9kcml2ZXIoc3RydWN0IHNwaV9kcml2ZXIgKnNwaV9kcnYpCj4gK3sKPiArIMKgIMKgIMKg
IHNwaV91bnJlZ2lzdGVyX2RyaXZlcihzcGlfZHJ2KTsKPiArfQo+ICsKPiArI2Vsc2UKPiArI2Rl
ZmluZSBhZDcxNHhfc3BpX3JlZ2lzdGVyX2RyaXZlcihwKSAwCj4gKyNkZWZpbmUgYWQ3MTR4X3Nw
aV91bnJlZ2lzdGVyX2RyaXZlcihwKQo+IMKgI2VuZGlmCgppIGRvbnQgdGhpbmsgeW91IG5lZWQg
dGhlIGlmZGVmIHByb3RlY3Rpb24gdGhhdCBmYXIgdXAuICB3aGF0IGFib3V0CnVzaW5nIHRoZSBp
ZmRlZiBpbiB0aGlzIG9uZSBwbGFjZToKc3RhdGljIGlubGluZSBpbnQgYWQ3MTR4X3NwaV9yZWdp
c3Rlcl9kcml2ZXIoc3RydWN0IHNwaV9kcml2ZXIgKnNwaV9kcnYpCnsKI2lmIGRlZmluZWQoQ09O
RklHX1NQSSkgfHwgZGVmaW5lZChDT05GSUdfU1BJX01PRFVMRSkKICAgIHJldHVybiBzcGlfcmVn
aXN0ZXJfZHJpdmVyKHNwaV9kcnYpOwojZWxzZQogICAgcmV0dXJuIDA7CiNlbmRpZgp9Cgp0aGVu
IGkgaW1hZ2luZSB5b3UgY2FuIGhhdmUgYWxsIHRoZSBvdGhlciBwaWVjZXMgYWx3YXlzIGVuYWJs
ZWQuICBnY2MKd2lsbCBzZWUgdGhhdCBldmVyeXRoaW5nIGlzIG1hcmtlZCBzdGF0aWMgYW5kIG5v
dCB1c2VkLCBzbyBpdCdsbCBjdWxsCnRoaW5ncy4KLW1pa2UKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVWNsaW51eC1kaXN0LWRldmVsIG1haWxpbmcgbGlz
dApVY2xpbnV4LWRpc3QtZGV2ZWxAYmxhY2tmaW4udWNsaW51eC5vcmcKaHR0cHM6Ly9ibGFja2Zp
bi51Y2xpbnV4Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3VjbGludXgtZGlzdC1kZXZlbA==
