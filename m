From: Stanislav Brabec <utx@penguin.cz>
Subject: Re: ads7846: clean up, fix pressure reporting
Date: Sun, 09 Aug 2009 12:21:33 +0200
Message-ID: <1249813293.4334.24.camel@utx.utx.cz>
References: <20090807180941.GF1728@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090807180941.GF1728@ucw.cz>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Pavel Machek <pavel@ucw.cz>
Cc: dtor@mail.ru, linux-input@vger.kernel.org, rpurdie@rpsys.net, lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>, Dirk@Opfer-Online.de, arminlitzel@web.de, Cyril Hrubis <metan@ucw.cz>, thommycheck@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.miao@marvell.comCyril Hrubis <metan@ucw.cz>
List-Id: linux-input@vger.kernel.org

UGF2ZWwgTWFjaGVrIHdyb3RlOgo+IEZpeCBwcmVzc3VyZSByZXBvcnRpbmcsIGFuZCBjbGVhbiB1
cCBkZWJ1ZyBwcmludHMuCgpUaGFua3MuCgpJIHNlZSBtdWNoIGJpZ2dlciBwcm9ibGVtIHdpdGgg
Ym90aCB0aGUgb2xkIGRyaXZlciBhbmQgdGhlIG5ldyBhZHM3ODQ2CmRyaXZlciAoMi42LjMwKTog
VGhleSBhcmUgdmVyeSBub2lzeSBvbiBteSBzcGl0ei4gV2hlbiB5b3UgdGFwIHRvIG9uZQpwbGFj
ZSwga2VlcCBzdHlsdXMgcHJlc3NlZCBhbmQganVzdCByZWFkIHZhbHVlcywgeW91IGdldCAyMC0y
MDAgcGl4ZWxzCmxvbmcgcG9pbnRlciBtb3Rpb24gdHJpcCBlYWNoIHNlY29uZC4KCkFjY29yZGlu
ZyB0byBDeXJpbCBIcnViacWhLCBpdCBpcyBjYXVzZWQgYnkgdGhlIGVsZWN0cmljYWwgbm9pc2Ug
dGhhdApvcmlnaW5hdGVzIGluIHRoZSBMQ0QgZGlzcGxheS4gVGhlIGRyaXZlciBuZWVkcyB0byBy
ZWFkIGRhdGEKc3luY2hyb25vdXNseSB3aXRoIHRoZSBMQ0QgcmVmcmVzaC4gSGUgYWxyZWFkeSBt
YWRlIHRoZSBmaXggZm9yIGNvbGxpZQpzZXZlcmFsIHllYXJzIGFnby4K77u/ClRoZSBwb2ludGVy
IHRlc3QgYXBwbGljYXRpb24gaW4gdGhlIFBST00gZGlhZ25vc3RpYyB1dGlsaXR5IGRvZXMgbm90
CnNlZW0gdG8gZXhoaWJpdCBhbnkgbm9pc2UuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClN0YW5pc2xhdiBC
cmFiZWMKaHR0cDovL3d3dy5wZW5ndWluLmN6L351dHgvemF1cnVzCgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMaXN0
IGFkbWluOiBodHRwOi8vbGlzdHMuYXJtLmxpbnV4Lm9yZy51ay9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwKRkFROiAgICAgICAgaHR0cDovL3d3dy5hcm0ubGludXgub3JnLnVrL21h
aWxpbmdsaXN0cy9mYXEucGhwCkV0aXF1ZXR0ZTogIGh0dHA6Ly93d3cuYXJtLmxpbnV4Lm9yZy51
ay9tYWlsaW5nbGlzdHMvZXRpcXVldHRlLnBocA==
