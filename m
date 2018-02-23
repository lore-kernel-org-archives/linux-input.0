From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2 0/3] gpio-keys: Add support for specifying wakeup event
 action
Date: Fri, 23 Feb 2018 17:43:06 +0800
Message-ID: <5A8FE22A.1070709@rock-chips.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <1541427.8RRpDbxO4f@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1541427.8RRpDbxO4f@diego>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Emil Renner Berthing <kernel@esmil.dk>, stephen lu <lumotuwe@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joseph Lo <josephl@nvidia.com>, Brian Norris <briannorris@chromium.org>, linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>, linux-input@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, dtor@google.com, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, dianders@google.com, Rob Herring <robh+dt@kernel.org>, briannorris@google.com, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, Enric Balletbo i Serra <enric.bal>
List-Id: linux-input@vger.kernel.org

SGkgSGVpa28sCgpUaGFua3MgZm9yIHlvdXIgcmVwbHkgOikKCk9uIDAyLzE0LzIwMTggMDk6Mzkg
UE0sIEhlaWtvIFN0w7xibmVyIHdyb3RlOgo+IEhpIEplZmZ5LAo+Cj4gQW0gU2Ftc3RhZywgMTAu
IEZlYnJ1YXIgMjAxOCwgMTI6MDk6MDQgQ0VUIHNjaHJpZWIgSmVmZnkgQ2hlbjoKPj4gT24gY2hy
b21lYm9vayBrZXZpbiwgd2UgYXJlIHVzaW5nIGdwaW8ta2V5cyBmb3IgcGVuIGluc2VydCBldmVu
dC4gQnV0Cj4+IHdlIG9ubHkgd2FudCBpdCB0byB3YWtldXAgdGhlIHN5c3RlbSB3aGVuIGVqZWN0
aW5nIHRoZSBwZW4uCj4+Cj4+IFNvIHdlIG1heSBuZWVkIHRvIGNoYW5nZSB0aGUgaW50ZXJydXB0
IHRyaWdnZXIgdHlwZSBkdXJpbmcgc3VzcGVuZGluZy4KPj4KPj4gQ2hhbmdlcyBpbiB2MjoKPj4g
U3BlY2lmeSB3YWtldXAgZXZlbnQgYWN0aW9uIGluc3RlYWQgb2YgaXJxIHRyaWdnZXIgdHlwZSBh
cyBCcmlhbgo+PiBzdWdnZXN0ZWQuCj4+Cj4+IEplZmZ5IENoZW4gKDMpOgo+PiAgICBJbnB1dDog
Z3Bpby1rZXlzIC0gYWRkIHN1cHBvcnQgZm9yIHdha2V1cCBldmVudCBhY3Rpb24KPj4gICAgSW5w
dXQ6IGdwaW8ta2V5cyAtIGFsbG93IHNldHRpbmcgd2FrZXVwIGV2ZW50IGFjdGlvbiBpbiBEVAo+
PiAgICBhcm02NDogZHRzOiByb2NrY2hpcDogQXZvaWQgd2FrZXVwIHdoZW4gaW5zZXJ0aW5nIHRo
ZSBwZW4KPgo+IFRoZSByZWNpcGllbnQtc2VsZWN0aW9uIGZvciB0aGUgbWFpbCB0aHJlYWQgc2Vl
bXMgdG8gYmUgYSBiaXQgb2ZmIGFuZAo+IEkgb25seSBnb3QgdGhlIGNvdmVyLWxldHRlciBhbmQg
cGF0Y2ggMy8zLgo+IFRoZXJlZm9yZSBJIHdvbid0IHJlYWxseSBzZWUgaWYgYW5kIHdoZW4gdGhl
IElucHV0LWNoYW5nZXMgZ2V0Cj4gYWNjZXB0ZWQuIFNvIHBsZWFzZSBwaW5nIG1lIG9uY2UgdGhh
dCBoYXMgaGFwcGVuZWQgc28gSSBjYW4gcGljayB1cAo+IHRoZSByb2NrY2hpcCBkdHMgY2hhbmdl
IGZvciBpdC4Kb29wcywgc29ycnksIGknbGwgYWRkIHlvdSB0byB0aGUgQ0MgbGlzdCBpbiB0aGUg
bmV4dCB2ZXJzaW9uIDopCgo+Cj4KPiBUaGFua3MKPiBIZWlrbwo+Cj4KPgoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
