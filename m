From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
Date: Tue, 11 Dec 2012 09:18:51 +0100
Message-ID: <20678.60523.170336.920677@ipc1.ka-ro>
References: <1354893893-26338-1-git-send-email-marex@denx.de>
 <1354893893-26338-3-git-send-email-marex@denx.de>
 <50C312D8.4050405@kernel.org>
 <20121210222437.GA19008@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121210222437.GA19008@core.coreip.homeip.net>
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
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-input@vger.kernel.org

SGksCgpEbWl0cnkgVG9yb2tob3Ygd3JpdGVzOgo+IEhpIE1hcmVrLCBKb25hdGhhbiwKPiAKPiBP
biBTYXQsIERlYyAwOCwgMjAxMiBhdCAxMDoxMzo0NEFNICswMDAwLCBKb25hdGhhbiBDYW1lcm9u
IHdyb3RlOgo+ID4gT24gMTIvMDcvMjAxMiAwMzoyNCBQTSwgTWFyZWsgVmFzdXQgd3JvdGU6Clsu
Li5dCj4gPiA+ICsJaW50CQkJdXNlX3RvdWNoYnV0dG9uOjE7Cj4gCj4gV2h5IHdvdWxkIHNvbWVv
bmUgbm90IHdhbnQgdG8gdXNlIGl0Pwo+IAo+ID4gPiArCWludAkJCXVzZV90b3VjaHNjcmVlbl80
d2lyZToxOwo+ID4gPiArCWludAkJCXVzZV90b3VjaHNjcmVlbl81d2lyZToxOwo+IApiaXQgZmll
bGRzIHNob3VsZCBiZSBvZiB1bnNpZ25lZCB0eXBlLCBiZWNhdXNlIG90aGVyd2lzZSB0aGUgJ3Ry
dWUnCnZhbHVlIHdpbGwgYmUgJy0xJyByYXRoZXIgdGhhbiAnMScuCgoKTG90aGFyIFdhw59tYW5u
Ci0tIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwoKS2EtUm8gZWxlY3Ryb25pY3MgR21iSCB8IFBhc2NhbHN0cmHDn2UgMjIgfCBEIC0g
NTIwNzYgQWFjaGVuClBob25lOiArNDkgMjQwOCAxNDAyLTAgfCBGYXg6ICs0OSAyNDA4IDE0MDIt
MTAKR2VzY2jDpGZ0c2bDvGhyZXI6IE1hdHRoaWFzIEthdXNzZW4KSGFuZGVsc3JlZ2lzdGVyZWlu
dHJhZzogQW10c2dlcmljaHQgQWFjaGVuLCBIUkIgNDk5NgoKd3d3Lmthcm8tZWxlY3Ryb25pY3Mu
ZGUgfCBpbmZvQGthcm8tZWxlY3Ryb25pY3MuZGUKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
