From: Pingbo Wen <pingbo.wen@linaro.org>
Subject: Re: [PATCH] hil_mlc: convert timeval to timespec64
Date: Fri, 23 Oct 2015 20:34:50 +0800
Message-ID: <D1043A13-EDCD-48C7-BA2B-CE4FCFC73338@linaro.org>
References: <1445161519-27000-1-git-send-email-pingbo.wen@linaro.org>
 <46052377.96MapaKFAy@wuerfel> <5629FA06.2060608@linaro.org>
 <5201254.PnVcGHTDmH@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <5201254.PnVcGHTDmH@wuerfel>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Cj4g5ZyoIDIwMTXlubQxMOaciDIz5pel77yMMTc6NDXvvIxBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPiDlhpnpgZPvvJoKPiAKPiBPbiBGcmlkYXkgMjMgT2N0b2JlciAyMDE1IDE3OjEyOjM4
IFBpbmdibyBXZW4gd3JvdGU6Cj4+IE9uIE1vbmRheSwgT2N0b2JlciAxOSwgMjAxNSAwNDo1OCBQ
TSwgQXJuZCBCZXJnbWFubiB3cm90ZToKPj4+PiAtICAgICAgICAgICAgZG9fZ2V0dGltZW9mZGF5
KCZ0dik7Cj4+Pj4gLSAgICAgICAgCj4gSGFuZGxpbmcgdGhlIGppZmZpZXMgb3ZlcmZsb3cgaXMg
dHJpdmlhbGx5IGRvbmUgdGhyb3VnaCB0aGUgdGltZV9iZWZvcmUoKQo+IGFuZCB0aW1lX2FmdGVy
KCkgaGVscGVycywgbGlrZQo+IAo+IAo+IAlzdGFydCA9IGppZmZpZXM7Cj4gCS4uLgo+IAlub3cg
PSBqaWZmaWVzOwo+IAl0aW1lb3V0ID0gc3RhcnQgKyBIWiAqIHRpbWVvdXRfdXNlYyAvIFVTRUNf
UEVSX1NFQzsKPiAJaWYgKHRpbWVfYWZ0ZXIobm93LCBzdGFydCArIHRpbWVvdXRfamlmZmllcykK
PiAJCXRpbWVvdXQoKTsKPiAJZWxzZQo+IAkJbW9kX3RpbWVyKHRpbWVyLCBzdGFydCArIHRpbWVv
dXRfamlmZmllcyk7Cj4gCj4gVGhlIHRpbWVfYWZ0ZXIgZnVuY3Rpb24gd29ya3MgYmVjYXVzZSB1
bnNpZ25lZCBvdmVyZmxvdyBpcyB3ZWxsLWRlZmluZWQKPiBpbiBDICh1bmxpa2Ugc2lnbmVkIG92
ZXJmbG93KS4KPiAKCk1ha2Ugc2Vuc2UsIEkgd2lsbCB0cnkgdGhpcyBpbiBuZXh0IHZlcnNpb24u
CgpUaGFua3MsClBpbmdibwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KWTIwMzggbWFpbGluZyBsaXN0ClkyMDM4QGxpc3RzLmxpbmFyby5vcmcKaHR0cHM6
Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8veTIwMzgK
