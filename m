From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 2/8] mfd: wm97xx-core: core support for
	wm97xx Codec
Date: Tue, 19 Sep 2017 16:23:49 +0100
Message-ID: <20170919152349.2dks77acrnv27mto@dell>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
 <20170913193723.16234-3-robert.jarzmik@free.fr>
 <20170914074146.dnibkvom4yuzejf3@dell>
 <20170914074300.iobuwn2hrmnf6sen@dell>
 <20170914160453.gys3imt4eobckcrq@sirena.org.uk>
 <20170918085236.z6gmgrwvsjvvc4cd@dell>
 <20170919121539.mz2mettkefxf3oer@sirena.co.uk>
 <20170919152253.tvj3hheggrx4lgig@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170919152253.tvj3hheggrx4lgig@dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

T24gVHVlLCAxOSBTZXAgMjAxNywgTGVlIEpvbmVzIHdyb3RlOgoKPiBPbiBUdWUsIDE5IFNlcCAy
MDE3LCBNYXJrIEJyb3duIHdyb3RlOgo+IAo+ID4gT24gTW9uLCBTZXAgMTgsIDIwMTcgYXQgMDk6
NTI6MzZBTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gPiBPbiBUaHUsIDE0IFNlcCAyMDE3
LCBNYXJrIEJyb3duIHdyb3RlOgo+ID4gCj4gPiA+ID4gT24gVGh1LCBTZXAgMTQsIDIwMTcgYXQg
MDg6NDM6MDBBTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gCj4gPiA+ID4gPiBDaGFuZ2Ug
b2YgcGxhbi4gIEl0IGxvb2tzIGxpa2UgdGhlcmUgYXJlIGRlcHMuCj4gPiAKPiA+ID4gPiA+IFVu
YXBwbGllZC4KPiA+IAo+ID4gPiA+IFRoZSBjb3JlIHN0dWZmIHdlbnQgaW4gZHVyaW5nIHRoZSBt
ZXJnZSB3aW5kb3csIHlvdSBzaG91bGQgYmUgYWJsZSB0bwo+ID4gPiA+IHdhaXQgZm9yIC1yYzEg
b3IgcGljayB1cCB0aGUgYXNvYy12NC4xNCB0YWcuCj4gPiAKPiA+ID4gTm8sIEkgbWVhbiBwYXRj
aGVzOyAzLCA0LCA1IGFuZCA3IGRlcGVuZCBvbiB0aGlzIGZpbGUuCj4gPiAKPiA+IFJpZ2h0LCBi
dXQgSSdkIGhhdmUgZXhwZWN0ZWQgYSBwdWxsIHJlcXVlc3QgbW9yZSB0aGFuIHRoZSBwYXRjaCBi
ZWluZwo+ID4gdW5hcHBsaWVkPwo+IAo+IE5vcm1hbGx5IEkgd2FpdCB1bnRpbCBhbGwgcGF0Y2hl
cyBwYXRjaGVzIGluIHRoZSBzZXQgaGF2ZSBiZWVuCj4gcmV2aWV3ZWQgKHRoZSBBU09DIG9uZXMg
c3RpbGwgaGF2ZSBub3QpLCB0aGVuIGFzayB0aGUgT1AgYW5kIHRoZQo+IG90aGVyIGFmZmVjdGVk
IE1haW50YWluZXJzIGhvdyB0aGV5IHdhbnQgdG8gZGVhbCB3aXRoIHRoZSBwYXRjaC4KPiBGYXIg
bW9yZSBvZnRlbiB0aGFuIG5vdCwgdGhlIHRoZSBzb2x1dGlvbiBpcyBqdXN0IHRvIHRha2UgdGhl
IHNldAo+IHRocm91Z2ggdGhlIE1GRCB0cmVlLgo+IAo+IEhvd2V2ZXIsIHNpbmNlIHRoaXMgaXMg
YSBuZXcgZHJpdmVyLCB5b3UgY2FuIGp1c3QgdGFrZSBpdCB3aXRoIG15Ogo+IAo+IEFja2VkLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKLi4uIGFsdGhvdWdoIHRoYXQgZG9l
cyBtZWFuIHRoYXQgeW91J2xsIGhhdmUgdG8gaGFuZGxlIG9uZSBvZiB0aGUKSW5wdXQgcGF0Y2hl
cyB0b28uCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBU
ZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0Nz
CkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
