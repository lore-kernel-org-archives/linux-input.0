From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 2/4] input: keyboard/mouse/touchscreen/misc: Use
 dev_get_drvdata()
Date: Tue, 2 Jul 2019 14:32:25 +0200
Message-ID: <20190702143225.12b0fe07@karo-electronics.de>
References: <20190701032342.25971-1-huangfq.daxian@gmail.com>
 <20190701075255.GD172968@dtor-ws>
 <CABXRUiSO2Fos1V3hR5t3AviZ9Hit_y+E-Tp3PNOQj6-FKUBJBw@mail.gmail.com>
 <CAHp75VeUo2Au66tETo3zneBpeaVU+Y+-h5zghpo+hPuB=a6-eA@mail.gmail.com>
 <CABXRUiQ77feNzEdQ7GqNxLS9YAMybVG3eAWWSDPFdGvERaxCyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABXRUiQ77feNzEdQ7GqNxLS9YAMybVG3eAWWSDPFdGvERaxCyg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Richard Fontana <rfontana@redhat.com>, Laxman Dewangan <ldewangan@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Anson Huang <anson.huang@nxp.com>, Fabio Estevam <festevam@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Luca Weiss <luca@z3ntu.xyz>, Andy Shevchenko <andy.shevchenko@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-input <linux-input@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Brian Masney <masneyb@onstation.org>, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Alexios Zavras <alexios.zavras@intel.com>, linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-input@vger.kernel.org

SGksCgpPbiBUdWUsIDIgSnVsIDIwMTkgMTk6NDc6MTYgKzA4MDAgRnVxaWFuIEh1YW5nIHdyb3Rl
Ogo+IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4g5pa8IDIwMTnl
ubQ35pyIMuaXpemAseS6jCDkuIvljYg1OjUx5a+r6YGT77yaCj4gPgo+ID4gT24gVHVlLCBKdWwg
MiwgMjAxOSBhdCAxMToyMCBBTSBGdXFpYW4gSHVhbmcgPGh1YW5nZnEuZGF4aWFuQGdtYWlsLmNv
bT4gd3JvdGU6ICAKPiA+ID4KPiA+ID4gSSBhbSBub3QgYW4gZXhwZXJ0IG9uIHRoaXMuIEkganVz
dCB3cml0ZSBhIGNvY2NpbmVsbGUgc2NyaXB0IHRvIHNlYXJjaAo+ID4gPiB0aGlzIGtpbmQgb2Yg
bWlzdXNlIGFuZCBmaXggaXQgaW4gYSBuYWl2ZSB3YXkuCj4gPiA+IENvdWxkIHlvdSB0ZWxsIG1l
IGFib3V0IGhvdyB0byB1c2UgdGhlIHByb3BlciBidXMgYWNjZXNzb3JzPyBUaGVuIEkKPiA+ID4g
d2lsbCBmaXggaXQgdXAgYW5kIHJlc2VuZCBhIHYyIHBhdGNoIHNldC4gIAo+ID4KPiA+IEZpcnN0
LCBkb24ndCB0b3AgcG9zdC4KPiA+IEFuZCBhbnN3ZXJpbmcgdG8gdGhpcywgc2ltcGxlIGRyb3Ag
dGhlIHBhdGNoLgo+ID4gUHJvcGVyIGJ1cyBhY2Nlc3NvcnMgaXMgZXhhY3RseSB3aGF0IGl0J3Mg
dXNlZCBpbiB0aGUgY3VycmVudCBjb2RlLiAgCj4gCj4gQnV0IHdoeSBub3QgdXNlIGRldl9nZXRf
ZHJ2ZGF0YSBkaXJlY3RseS4KPiBJdCBzaW1wbGlmaWVzIGdldHRpbmcgdGhlICdkcml2ZXJfZGF0
YScgZnJvbSAnc3RydWN0IGRldmljZScgZGlyZWN0bHkuCj4gQW5kIHRoZSBwbGF0Zm9ybV9kZXZp
Y2UgaGVyZSBpcyBub3QgcmVxdWlyZWQuCj4gUmVwbGFjZSBpdCBjYW4gcmVtb3ZlIHRoZSB1bm5l
Y2Vzc2FyeSBzdGVwIGJhY2sgYW5kIGZvcnRoLiAoZGV2IC0+IHBkZXYgLT4gZGV2KS4KPiAKRGlk
IHlvdSBjaGVjayB3aGV0aGVyIHRoZSBjb21waWxlciBnZW5lcmF0ZXMgZGlmZmVyZW50IChiZXR0
ZXIpIGNvZGUKd2l0aCBhbmQgd2l0aG91dCB5b3VyIHBhdGNoPyBNeSBndWVzcyBpcyBpdCB3b24n
dC4KCgpMb3RoYXIgV2HDn21hbm4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
