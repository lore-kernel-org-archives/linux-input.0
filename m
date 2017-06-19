From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [WIP PATCH 0/4] Rework the unreliable LID
 switch exported by ACPI
Date: Tue, 20 Jun 2017 00:08:47 +0200
Message-ID: <1497910127.2559.1.camel@hadess.net>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
 <20170607074848.GE27006@gardel-login>
 <20170613100617.GD29589@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CED0386@SHSMSX101.ccr.corp.intel.com>
 <20170615064715.GA6195@jelly>
 <1AE640813FDE7649BE1B193DEA596E886CED047B@SHSMSX101.ccr.corp.intel.com>
 <20170615075755.GA10001@jelly>
 <1AE640813FDE7649BE1B193DEA596E886CED0A03@SHSMSX101.ccr.corp.intel.com>
 <20170616072322.GL5085@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CED0AC1@SHSMSX101.ccr.corp.intel.com>
 <20170616080950.GM5085@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CED0C5E@SHSMSX101.ccr.corp.intel.com>
 <33C872C7-EFB2-4CA0-8CAD-8B6E8916180C@hadess.net>
 <1AE640813FDE7649BE1B193DEA596E886CED1419@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CED1419@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/systemd-devel>,
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/systemd-devel>,
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: systemd-devel-bounces@lists.freedesktop.org
Sender: "systemd-devel" <systemd-devel-bounces@lists.freedesktop.org>
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lv Zheng <zetalog@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

T24gTW9uLCAyMDE3LTA2LTE5IGF0IDAxOjQzICswMDAwLCBaaGVuZywgTHYgd3JvdGU6Cj4gPHNu
aXA+Cj4gPiAKPiA+IElmIHlvdSBpbXBsZW1lbnQgaXQgaW4gc3VjaCBhIHdheSB0aGF0IEdOT01F
IHNldHRpbmdzIGRhZW1vbgo+ID4gYmVoYXZlcyB3ZWlyZGx5LCB5b3UnbGwgZ2V0IG15IHJldmVy
dAo+ID4gcmVxdWVzdCBpbiB0aGUgbWFpbC4gRG8uIE5vdC4gRXZlci4gTGllLgo+IAo+IEZpcnN0
LCBJIGRvbid0IGtub3cgd2hhdCBzaG91bGQgYmUgcmV2ZXJ0ZWQuLi4KPiBJIGhhdmUgMiBzb2x1
dGlvbnMgaGVyZSBmb3IgcmV2aWV3LCBhbmQgQmVuamFtaW4gaGFzIDEuCj4gQW5kIG5vbmUgb2Yg
dGhlbSBoYXMgYmVlbiB1cHN0cmVhbWVkLgo+IFdlIGFyZSBqdXN0IGRpc2N1c3NpbmcuCgpUaGUg
ZGlzY3Vzc2lvbiBpcyBnZXR0aW5nIHRpcmluZyBxdWl0ZSBmcmFua2x5LiBXZSd2ZSBiZWVuIG92
ZXIgdGhpcwpmb3IgbmVhcmx5IGEgeWVhciBub3csIGFuZCB3aXRoIG5vIGVuZCBpbiBzaWdodC4K
Cj4gSG93ZXZlciB3ZSBuZWVkIHRvIGdldCAxIG9mIHRoZW0gdXBzdHJlYW1lZCBpbiBuZXh0IGN5
Y2xlLgo+IAo+IEkgdGhpbmsgdXNlcnMgd29uJ3Qgc3RhcnR1cCBnbm9tZS1zZXR0aW5nLWRhZW1v
biByaWdodCBhZnRlciByZXN1bWUuCj4gSXQgc2hvdWxkIGhhdmUgYWxyZWFkeSBiZWVuIHN0YXJ0
ZWQuCj4gCj4gVGhlcmUgaXMgb25seSAxIHBsYXRmb3JtIG1heSBzZWUgZGVsYXllZCBzdGF0ZSB1
cGRhdGUgYWZ0ZXIgcmVzdW1lLgo+IExldCdzIHNlZSBpZiB0aGVyZSBpcyBhIHByYWN0aWNhbCBp
c3N1ZS4KPiAxLiBCZWZvcmUgc3VzcGVuZCwgdGhlICJsaWQgc3RhdGUiIGlzICJjbG9zZSIsIGFu
ZAo+IDIuIEFmdGVyIHJlc3VtZSwgdGhlIHN0YXRlIG1pZ2h0IHJlbWFpbiAiY2xvc2UiIGZvciBh
IHdoaWxlCj4gICAgU2luY2UgbGliaW5wdXQgd29uJ3QgZGVsaXZlciBjbG9zZSB0byB1c2Vyc3Bh
Y2UsCj4gICAgYW5kIGdub21lLXNldHRpbmctZGFlbW9uIGxpc3RlbnMgdG8ga2V5IHN3aXRjaGVz
LCB0aGVyZSBpcyBubwo+IHdyb25nIGJlaGF2aW9yLgoKSXQgZG9lc24ndC4gSXQgbGlzdGVucyB0
byBVUG93ZXIsIHdoaWNoIHRlbGxzIHVzZXItc3BhY2Ugd2hldGhlciB0aGVyZQppcyBhIGxpZCBz
d2l0Y2gsIGFuZCB3aGV0aGVyIGl0J3Mgb3BlbmVkIG9yIGNsb3NlZC4KCj4gMy4gVGhlbiBhZnRl
ciBzZXZlcmFsIHNlY29uZHMsICJvcGVuIiBhcnJpdmVzLgo+ICAgIGdub21lLXNldHRpbmctZGFl
bW9uIHJlLWFycmFuZ2UgbW9uaXRvcnMgYW5kIHNjcmVlbiBsYXlvdXRzIGluCj4gcmVzcG9uc2Ug
dG8gdGhlIG5ldyBldmVudC4KCkp1c3QgaG93IGlzIGFueW9uZSBzdXBwb3NlZCB0byBrbm93IHRo
YXQgdGhlcmUgaXMgYW4gZXZlbnQgY29taW5nPwoKPiBTbyB0aGVyZSBpcyBubyBwcm9ibGVtLiBJ
TU8sIHRoZXJlIGlzIG5vIG5lZWQgdG8gaW1wcm92ZSBmb3IgcG9zdC0KPiByZXN1bWUgY2FzZS4K
PiAKPiBVc2VycyB3aWxsIGp1c3Qgc3RhcnR1cCBnbm9tZS1zZXR0aW5nLWRhZW1vbiBvbmNlIGFm
dGVyIGJvb3QuCj4gQW5kIGl0J3MgbGlrZWx5IHRoYXQgd2hlbiBpdCBpcyBzdGFydGVkLCB0aGUg
c3RhdGUgaXMgY29ycmVjdC4KCllvdSBjYW5ub3QgcmVseSBvbiB3aGVuIGdub21lLXNldHRpbmdz
LWRhZW1vbiB3aWxsIGJlIHN0YXJ0ZWQgdG8gbWFrZQoqYW55KiBkZWNpc2lvbi4gQ2VydGFpbmx5
IG5vdCBkZWNpc2lvbnMgb24gaG93IHRoZSBrZXJuZWwgc2hvdWxkCmJlaGF2ZS4KCj4gSU1PLCB0
aGVyZSBtaWdodCBiZSBhIGNoYW5jZSB0byBpbXByb3ZlIGZvciBwb3N0LWJvb3QgY2FzZSB1c2lu
Zwo+IEJlbmphbWluJ3MgYXBwcm9hY2guCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCnN5c3RlbWQtZGV2ZWwgbWFpbGluZyBsaXN0CnN5c3RlbWQtZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vc3lzdGVtZC1kZXZlbAo=
