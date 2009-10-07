From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: 32-rc1 aka 32-rc2: warning at manage.c:361 (set_irq_wake),
	matrix-keypad related?
Date: Wed, 7 Oct 2009 22:42:08 +0800
Message-ID: <f17812d70910070742y5e27f9c3u38e3299b94f33613@mail.gmail.com>
References: <20090930200746.GA1384@ucw.cz>
	<20091006050649.GH27881@core.coreip.homeip.net>
	<20091006075816.GA1362@ucw.cz>
	<20091007043603.GC10204@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091007043603.GC10204@core.coreip.homeip.net>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, thommycheck@gmail.com, dbaryshkov@gmail.com, Cyril Hrubis <metan@ucw.cz>, arminlitzel@web.de, kernel list <linux-kernel@vger.kernel.org>, Dirk@opfer-online.de, utx@penguin.cz, lenz@cs.wisc.edu, rpurdie@rpsys.net, omegamoon@gmail.com, Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

T24gV2VkLCBPY3QgNywgMjAwOSBhdCAxMjozNiBQTSwgRG1pdHJ5IFRvcm9raG92CjxkbWl0cnku
dG9yb2tob3ZAZ21haWwuY29tPiB3cm90ZToKPiBPbiBUdWUsIE9jdCAwNiwgMjAwOSBhdCAwOTo1
ODoxN0FNICswMjAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6Cj4+IEhpIQo+Pgo+PiBPbiBNb24gMjAw
OS0xMC0wNSAyMjowNjo1MCwgRG1pdHJ5IFRvcm9raG92IHdyb3RlOgo+PiA+IE9uIFdlZCwgU2Vw
IDMwLCAyMDA5IGF0IDEwOjA3OjQ2UE0gKzAyMDAsIFBhdmVsIE1hY2hlayB3cm90ZToKPj4gPiA+
Cj4+ID4gPiBJdCBjb21wbGFpbnMgYWJvdXQgdW5iYWxhbmNlZCBpcnEgMTEzIHdha2UgZGlzYWJs
ZS4gVGhhdCBvbmUgYmVsb25ncwo+PiA+ID4gdG8gbWF0cml4LWtleXBhZC4uLgo+PiA+Cj4+ID4g
SSBndWVzcyBzb21lIG9mIGVuYWJsZV9pcnFfd2FrZSgpcyBmYWlsIG9uIHlvdXIgYm94LiBEbyB5
b3Ugc2VlIGl0IGlmCj4+ID4geW91IGFwcGx5IHRoZSBwYXRjaCBiZWxvdz8KPj4KPj4gSSdsbCBk
byBzaG9ydCB0ZXN0LiBCdXQuLi4gaWYgeW91IGFyZSByaWdodCwgeW91ciBwYXRjaCB3aWxsIGp1
c3QgbWFrZQo+PiB5b3VyIG1hY2hpbmUgcmVmdXNlIHRvIHN1c3BlbmQuLi4gcmlnaHQ/Cj4+Cj4+
IFVuZ29vZC4KPgo+IEl0IHdhcyBqdXN0IGEgZGVidWcgcGF0Y2guCj4KPj4KPj4gQWN0dWFsbHks
IGl0IHNlZW1zIHRvIGJyZWFrIHN1c3BlbmQgKHJldHVybnMgwqAtRUlOVkFMIHdoaWxlIHJlZnVz
aW5nCj4+IHRvIHN1c3BlbmQpLCB3YXJuaW5ncyBhcmUgc3RpbGwgdGhlcmUsIGFuZCBrZXlib2Fy
ZCBpcyBkZWFkIGFmdGVyCj4+IGZhaWxlZCBzdXNwZW5kLi4uIGRvdWJsZSBwbHVzIHVuZ29vZC4K
Pj4KPj4gQWhhLCBzbyB3YXJuaW5nIGlzIHNvbHZlZDogdGhlIG9uZSBpbiB0aGUgbG9nIGlzIGZy
b20gZ3Bpb19idXR0b25zLgo+Pgo+Cj4gT0ssIHNvIGl0IGxvb2tzIGxpa2UgeW91ciBib3ggcmVm
dXNlcyB0byBzZXQgdXAgb25lIG9mIHRoZSBHUElPcyBhcyBhCj4gd2FrZXVwIHNvdXJjZS4uLiBI
bW0sIGVpdGhlciB5b3VyIGJveCBpcyB3cm9uZyA7KSBvciBtYXRyaXhfa2V5cGFkCj4gZHJpdmVy
IG5lZWRzIHRvIG1haW50YWluIGEgc2VwYXJhdGUgbGlzdCBvZiB3YWtldXAgR1BJT3MuCj4KClRo
aXMgaXMgZHVlIHRvIHRoZSBuYXR1cmUgb2YgUFhBIHByb2Nlc3Nvciwgd2hlcmUgbm90IGV2ZXJ5
IEdQSU8gY2FuCmJlIGNvbmZpZ3VyZWQgYXMgYSB3YWtldXAgc291cmNlLiBNbW0uLi4uIHdlIGNh
biBlaXRoZXIgcmV0dXJuIGEKcHNldWRvIHZhbHVlIGluZGljYXRpbmcgc2V0dGluZyB3YWtldXAg
b24gdGhhdCBHUElPIGlzIE9LICh3aGljaApkb2Vzbid0IHNvdW5kIGxpa2UgYSBnb29kIGlkZWEp
LCBvciB3ZSBjYW4ganVzdCBpZ25vcmUgdGhlIGZhaWx1cmUgb2YKZW5hYmxlX2lycV93YWtlKCkg
aW4gbWF0cml4X2tleXBhZD8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
