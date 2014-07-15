From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Tue, 15 Jul 2014 22:38:25 +0800
Message-ID: <53C53CE1.4090803@gmail.com>
References: <201407130545.23004.marex@denx.de>
 <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
 <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de>
 <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de>
 <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de>
 <20140713192202.GA19090@kroah.com> <53C2DF12.6040507@nod.at>
 <20140713201753.GA29955@kroah.com> <53C39569.9020802@nod.at>
 <53C3994C.1010309@metafoo.de> <53C39B66.4060500@nod.at>
 <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC@gmail.com> <53C47725.8000005@gmail.com>
 <53C47B76.4080306@roeck-us.net> <53C47FB7.6080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C47FB7.6080304@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Guenter Roeck <linux@roeck-us.net>, Richard Weinberger <richard@nod.at>
Cc: linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, Thierry Reding <thierry.reding@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Geert Uytterhoeven <geert@linux-m68k.org>, msalter@redhat.com, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, arnd@arndb.de, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org

T24gMDcvMTUvMjAxNCAwOToxMSBBTSwgQ2hlbiBHYW5nIHdyb3RlOgo+IAo+IAo+IE9uIDA3LzE1
LzIwMTQgMDg6NTMgQU0sIEd1ZW50ZXIgUm9lY2sgd3JvdGU6Cj4+IE9uIDA3LzE0LzIwMTQgMDU6
MzQgUE0sIENoZW4gR2FuZyB3cm90ZToKPj4+IE9uIDA3LzE0LzIwMTQgMDU6MjIgUE0sIENoZW4g
R2FuZyB3cm90ZToKPj4+Pgo+Pj4+IOWcqCAyMDE05bm0N+aciDE05pel77yM5LiL5Y2INDo1N++8
jFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+IOWGmemBk++8mgo+Pj4+Cj4+Pj4+
IEFtIDE0LjA3LjIwMTQgMTA6NDgsIHNjaHJpZWIgTGFycy1QZXRlciBDbGF1c2VuOgo+Pj4+Pj4g
T24gMDcvMTQvMjAxNCAxMDozMSBBTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+Pj4+Pj4+
IEFtIDEzLjA3LjIwMTQgMjI6MTcsIHNjaHJpZWIgR3JlZyBLcm9haC1IYXJ0bWFuOgo+Pj4+Pj4+
PiBPbiBTdW4sIEp1bCAxMywgMjAxNCBhdCAwOTozMzozOFBNICswMjAwLCBSaWNoYXJkIFdlaW5i
ZXJnZXIgd3JvdGU6Cj4+Pj4+Pj4+PiBNYXliZSB3ZSBjb3VsZCBhZGQgQ09NUElMRV9URVNUIHRv
IHRoZSB2ZXJzaW9uIHN0cmluZyB0b28/Cj4+Pj4+Pj4+PiBKdXN0IHRvIGRldGVjdCBzdWNoIGtl
cm5lbHMgZmFzdCBpbiB1c2VyIGJ1ZyByZXBvcnRzLi4uCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFdoYXQg
a2luZCBvZiBidWcgcmVwb3J0IGFyZSB5b3UgZ29pbmcgdG8gZ2V0Pwo+Pj4+Pj4+Cj4+Pj4+Pj4g
VXNlciBtYW5hZ2VzIHRvIGVuYWJsZSBDT05GSUdfRk9PIGJ5IHNlbGVjdGluZyBDT01QSUxFX1RF
U1QgYW5kCj4+Pj4+Pj4gY29tcGxhaW5zIHRoYXQgaXQgZG9lcyBub3Qgd29yay4gOikKPj4+Pj4+
Cj4+Pj4+PiBUaGVzZSBkcml2ZXJzIGFyZSB0eXBpY2FsbHkgZHJpdmVycyBmb3Igc29tZSBTb0Mg
cGVyaXBoZXJhbCBhbmQgdGhlCj4+Pj4+PiBkZXZpY2Ugd2lsbCBzaW1wbHkgcGh5c2ljYWxseSBu
b3QgZXhpc3Qgb24gYSBwbGF0Zm9ybSB0aGF0IGRvZXMgbm90Cj4+Pj4+PiBwcm92aWRlIEhBU19J
T01FTS4gVGhpcyBpcyBub3QgcmVhbGx5IGFueQo+Pj4+Pj4gZGlmZmVyZW50IGZyb20gbWFraW5n
IHRoZSBkcml2ZXIgc2VsZWN0YWJsZSB2aWEgQ09NUElMRV9URVNUIGZvcgo+Pj4+Pj4gYW55IG90
aGVyIHBsYXRmb3JtLiBUbyBoaXQgdGhlIGlzc3VlIHlvdSdkIGhhdmUgdG8gaW5zdGFudGlhdGUg
YQo+Pj4+Pj4gZGV2aWNlIGRyaXZlciBpbnN0YW5jZSBmb3IgYSBkZXZpY2UgdGhhdAo+Pj4+Pj4g
cGh5c2ljYWxseSBkb2VzIG5vdCBleGlzdC4gVGhpcyB3aWxsIGFsd2F5cyByZXN1bHQgaW4gYSBm
YWlsdXJlLgo+Pj4+Pgo+Pj4+PiBPa2F5LCB5b3UgaGF2ZSBjb252aW5jZWQgbWUuIDopCj4+Pj4+
Cj4+Pgo+Pj4gQWZ0ZXIgc2VhcmNoIHRoZSBoaXN0b3J5IHBhdGNoZXMsIEkgZm91bmQgb25lIHJl
bGF0ZWQgcGF0Y2ggd2hpY2ggbWFkZQo+Pj4gYnkgbXlzZWxmICh3aGVuIEkgYW0gaW4gQXNpYW51
eCk6Cj4+Pgo+Pj4gICAgImh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDEzLzcvMS82NDEiCj4+Pgo+
Pj4gRm9yIG1lLCBpdCBpcyBhIGxvbmcgZGlzY3Vzc2lvbiwgYW5kIGZvcmNlZCBtYW55IG1lbWJl
cnMgaGF2ZSB0byBqb2luCj4+PiBpbi4gUGxlYXNlIGhlbHAgY2hlY2sgYWdhaW4uCj4+Pgo+Pgo+
PiBPbmUgdGhpbmcgeW91IGNvdWxkIHRyeSB3b3VsZCBiZSB0byByZXR1cm4gTlVMTCAob3Igd2hl
cmUgYXBwcm9wcmlhdGUKPj4gYW4gZXJyb3IpIGluIHRoZSAjZWxzZSBjYXNlIG9mIENPTkZJR19I
QVNfSU9NRU0gYW5kIENPTkZJR19IQVNfSU9QT1JULAo+PiBpZSBkb250IHRha2UgQ09NUElMRV9U
RVNUIGludG8gYWNjb3VudCBhdCBhbGwuIE9idmlvdXNseSB0aGF0IG1lYW5zCj4+IHlvdSB3b24n
dCBiZSBhYmxlIHRvIGR1bXAgYSB3YXJuaW5nIG1lc3NhZ2UgaW4gdGhlIENPTVBJTEVfVEVTVAo+
PiBjYXNlLCBidXQgYXQgbGVhc3QgdGhlIGNvZGUgd291bGQgY29tcGlsZS4gVGhlIHJlamVjdGlv
biBvZiBhYm92ZSBwYXRjaAo+PiB3b3VsZCBtYWtlIGEgZ29vZCBjYXNlIGZvciB0aGlzIGFwcHJv
YWNoLgo+Pgo+IAo+IE9LLCB0aGFua3M6IGF0IGxlYXN0LCBpdCBjYW4gYmUgaW1wcm92ZWQuICBC
dXQgc3RpbGwgd2VsY29tZSBhbnkgb3RoZXIKPiBvcGluaW9ucyBvZiBhbm90aGVyIHJlbGF0ZWQg
bWVtYmVycy4KPiAKCklmIG5vIHJlcGx5IHdpdGhpbiAzIGRheXMgKDIwMTQtMDctMTgpLCBJIHNo
YWxsIHRyeSB0byBzZW5kIHJlbGF0ZWQKcGF0Y2ggZm9yIGl0IHdpdGhpbiB0aGlzIHdlZWsgZW5k
ICgyMDE0LTA3LTIwKS4KClRoYW5rcy4KLS0gCkNoZW4gR2FuZwoKT3BlbiBzaGFyZSBhbmQgYXR0
aXR1ZGUgbGlrZSBhaXIgd2F0ZXIgYW5kIGxpZmUgd2hpY2ggR29kIGJsZXNzZWQKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0
CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZl
cnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
