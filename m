From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH v4 1/2] xen/kbdif: Add string constants for
 raw pointer
Date: Thu, 17 May 2018 08:29:57 +0300
Message-ID: <66fe661f-8d1a-aefe-de50-02f37f756d94@gmail.com>
References: <20180502144919.16780-1-andr2000@gmail.com>
 <20180511133757.GG19972@char.us.oracle.com>
 <20180511133848.GA20566@char.us.oracle.com>
 <86b7b3be-6e49-46b7-beb4-759ee05f90fb@suse.com>
 <6cd29db8-e931-fe8a-7857-8d9d8cdace9a@gmail.com>
 <2f77fa72-c0bd-7086-1197-23007ce91cb7@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <2f77fa72-c0bd-7086-1197-23007ce91cb7@suse.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xenproject.org, dmitry.torokhov@gmail.com, jandryuk@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

T24gMDUvMTcvMjAxOCAwNzoyOCBBTSwgSnVlcmdlbiBHcm9zcyB3cm90ZToKPiBPbiAxNi8wNS8x
OCAwNjo1OSwgT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gd3JvdGU6Cj4+IE9uIDA1LzExLzIwMTgg
MDY6MTUgUE0sIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6Cj4+PiBPbiAxMS8wNS8xOCAxNTozOCwgS29u
cmFkIFJ6ZXN6dXRlayBXaWxrIHdyb3RlOgo+Pj4+IE9uIEZyaSwgTWF5IDExLCAyMDE4IGF0IDA5
OjM3OjU3QU0gLTA0MDAsIEtvbnJhZCBSemVzenV0ZWsgV2lsayB3cm90ZToKPj4+Pj4gT24gV2Vk
LCBNYXkgMDIsIDIwMTggYXQgMDU6NDk6MThQTSArMDMwMCwgT2xla3NhbmRyIEFuZHJ1c2hjaGVu
a28KPj4+Pj4gd3JvdGU6Cj4+Pj4+PiBGcm9tOiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xl
a3NhbmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+Cj4+Pj4+Pgo+Pj4+Pj4gQWRkIG1pc3Npbmcg
c3RyaW5nIGNvbnN0YW50cyBmb3Ige2ZlYXR1cmV8cmVxdWVzdH0tcmF3LXBvaW50ZXIKPj4+Pj4+
IHRvIGFsaWduIHdpdGggdGhlIHJlc3Qgb2YgdGhlIGludGVyZmFjZSBmaWxlLgo+Pj4+Pj4KPj4+
Pj4+IEZpeGVzIDc4Njg2NTRmZjdmZSAoImtiZGlmOiBEZWZpbmUgImZlYXR1cmUtcmF3LXBvaW50
ZXIiIGFuZAo+Pj4+Pj4gInJlcXVlc3QtcmF3LXBvaW50ZXIiKQo+Pj4+Pj4KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IE9sZWtzYW5kciBBbmRydXNoY2hlbmtvCj4+Pj4+PiA8b2xla3NhbmRyX2FuZHJ1
c2hjaGVua29AZXBhbS5jb20+Cj4+Pj4+IFJldmlld2VkLWJ5OiBLb25yYWQgUnplc3p1dGVrIFdp
bGsgPGtvbnJhZC53aWxrQG9yYWNsZS5jb20+Cj4+Pj4gSnVlcmdlbiwgeW91IE9LIHdpdGggYW4g
cmVsZWFzZS1hY2s/Cj4+PiBZZXM6Cj4+Pgo+Pj4gUmVsZWFzZS1hY2tlZC1ieTogSnVlcmdlbiBH
cm9zcyA8amdyb3NzQHN1c2UuY29tPgo+PiBJcyB0aGlzIGFjayBmb3IgYm90aCBwYXRjaGVzIG9y
IHRoaXMgb25lIG9ubHk/Cj4gSXQgd2FzIG1lYW50IGZvciBwYXRjaCAxIG9ubHkuCkNsZWFyCj4+
IEkgc2VlIEtvbnJhZCBoYXMgYXBwbGllZCB0aGlzIHBhdGNoLCBidXQKPj4gIltYZW4tZGV2ZWxd
W1BBVENIIHY0IDIvMl0geGVuL2tiZGlmOiBBZGQgZmVhdHVyZXMgdG8gZGlzYWJsZSBrZXlib2Fy
ZAo+PiBhbmQgcG9pbnRlciIKPj4gaXMgc3RpbGwgZmxvYXRpbmcuCj4gSW4gcHJpbmNpcGxlIEkn
bSBmaW5lIHdpdGggdGFraW5nIGl0IGZvciA0LjExLCBidXQgSSB0aGluayBhdCB0aGlzIHN0YWdl
Cj4gb2YgdGhlIHJlbGVhc2UgdGhlcmUgc2hvdWxkIGJlIGEgZm9ybWFsIHJlcXVlc3QgdG8gaW5j
bHVkZSBpdC4KLi4uYW5kIHRoZSByZXF1ZXN0IHNob3VsZCBjb21lIGZyb20gS29ucmFkPwpPciB3
aG8gZWxzZSBtYXkgcmVxdWVzdCB0aGF0PwoKQW5kLCBhcyBJIGhhdmUgci1iJ3MgZnJvbSBLb25y
YWQgZm9yIGJvdGggcGF0Y2hlcywKd2lsbCBpdCBiZSBvayBpZiB3ZSBhcHBseSB0aGUgY29ycmVz
cG9uZGluZyBjaGFuZ2VzIHRvIHRoZQprZXJuZWwgbm93LCBzbyBteSBjaGFuZ2UgdG8geGVuLWti
ZGZyb250IGlzIHVuYmxvY2tlZD8KPgo+IEp1ZXJnZW4KVGhhbmsgeW91LApPbGVrc2FuZHIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBt
YWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMu
eGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=
