From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock
 handling
Date: Tue, 24 Sep 2013 10:50:00 -0300
Message-ID: <CAOMZO5A9LY-oUpjJxWssUCo7w4oPqVxGwX0=VAUzoEu4RhJ37g@mail.gmail.com>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
 <52405A7F.1050801@freescale.com>
 <201309240950.54789.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <201309240950.54789.jbe@pengutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: =?UTF-8?Q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, devel@driverdev.osuosl.org, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>, linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

T24gVHVlLCBTZXAgMjQsIDIwMTMgYXQgNDo1MCBBTSwgSsO8cmdlbiBCZWlzZXJ0IDxqYmVAcGVu
Z3V0cm9uaXguZGU+IHdyb3RlOgo+IEhpIEZhYmlvLAo+Cj4gT24gTW9uZGF5IDIzIFNlcHRlbWJl
ciAyMDEzIDE3OjEzOjAzIEZhYmlvIEVzdGV2YW0gd3JvdGU6Cj4+IE9uIDA5LzIzLzIwMTMgMTE6
MzYgQU0sIEp1ZXJnZW4gQmVpc2VydCB3cm90ZToKPj4gPiArICAgbHJhZGMtPmNsayA9IGRldm1f
Y2xrX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsKPj4gPiArICAgY2xrX3ByZXBhcmVfZW5hYmxlKGxy
YWRjLT5jbGspOwo+Pgo+PiBjbGtfcHJlcGFyZV9lbmFibGUoKSBtYXkgZmFpbCwgc28gYmV0dGVy
IGNoZWNrIGl0cyByZXR1cm4gdmFsdWUuCj4KPiBUaGFua3MgZm9yIHRoZSBjb21tZW50LiBCZXR0
ZXIgdGhpcyB3YXk/CgpZZXMsIGxvb2tzIGJldHRlci4KClRoYW5rcywKCkZhYmlvIEVzdGV2YW0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFp
bGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5s
aW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
