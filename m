From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH] libgencec: Add userspace library for the generic CEC
 kernel interface
Date: Tue, 5 May 2015 16:03:26 +0100
Message-ID: <CACvgo50jMOCG5K1iM=SFE2CFYR6JMN3LBPmNtKO__Tra3KkCRQ@mail.gmail.com>
References: <1430301765-22202-1-git-send-email-k.debski@samsung.com>
 <1430301765-22202-13-git-send-email-k.debski@samsung.com>
 <CACvgo52hDYpgv2FY8X-O7SC=+2YMn7osHt_V=NJxP+4REaw1=Q@mail.gmail.com>
 <0af301d0832f$f0ffec70$d2ffc550$@debski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <0af301d0832f$f0ffec70$d2ffc550$@debski@samsung.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Kamil Debski <k.debski@samsung.com>
Cc: "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>, sean@mess.org, mchehab@osg.samsung.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, lars@opdenkamp.eu, thomas@tommie-lie.de, linux-input@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

SGkgS2FtaWwsCgpJdCBzZWVtcyB0aGF0IHlvdSd2ZSBvbmx5IGluY29ycG9yYXRlZCB0aGUgbGli
Z2VuY2VjLnBjIHN1Z2dlc3Rpb24uCkRpZCB5b3UgY2hhbmdlIHlvdXIgbWluZCBhYm91dCB0aGUg
b3RoZXJzLCBmb3VuZCBvdXQgc29tZXRoaW5nIGZ1bm55CndpdGggdGhlbSAoaWYgc28gY2FuIHlv
dSBsZXQgbWUga25vdyB3aGF0KSBvciBzaW1wbHkgZm9yZ290IGFib3V0IHRoZW0KPwoKT24gMzAg
QXByaWwgMjAxNSBhdCAxMToyNSwgS2FtaWwgRGVic2tpIDxrLmRlYnNraUBzYW1zdW5nLmNvbT4g
d3JvdGU6Cj4gSGkgRW1pbCwKPgo+IEZyb206IGxpbnV4LW1lZGlhLW93bmVyQHZnZXIua2VybmVs
Lm9yZyBbbWFpbHRvOmxpbnV4LW1lZGlhLQo+IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVo
YWxmIE9mIEVtaWwgVmVsaWtvdgo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjksIDIwMTUgNTow
MCBQTQo+Pgo+PiBIaSBLYW1pbCwKPj4KPj4gQWxsb3cgbWUgdG8gcHV0IGEgZmV3IHN1Z2dlc3Rp
b25zOgo+Pgo+PiBPbiAyOSBBcHJpbCAyMDE1IGF0IDExOjAyLCBLYW1pbCBEZWJza2kgPGsuZGVi
c2tpQHNhbXN1bmcuY29tPiB3cm90ZToKCj4+ID4gZGlmZiAtLWdpdCBhL200Ly5naXRrZWVwIGIv
bTQvLmdpdGtlZXAgbmV3IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXgKPj4gPiAwMDAwMDAwLi5lNjlk
ZTI5Cj4+IEhhdmVuJ3Qgc2VlbiBhbnkgcHJvamVjdHMgZG9pbmcgdGhpcy4gQ3VyaW91cyB3aGF0
IHRoZSBiZW5lZml0cyBvZgo+PiBrZWVwaW5nIGFuZCBlbXB0eSBmb2xkZXIgbWlnaHQgYmUgPwo+
Cj4gV2hlbiBJIHJ1biBhdXRvcmVjb25mIC1pIGl0IGNvbXBsYWluZWQgYWJvdXQgbWlzc2luZyBt
NCBmb2xkZXIsIGhlbmNlIEkgYWRkZWQKPiB0aGlzIGZpbGxlciBmaWxlIHN1Y2ggdGhhdCB0aGUg
Zm9sZGVyIGlzIGNyZWF0ZWQuIEFueSBzdWdnZXN0aW9uIG9uIGhvdyB0byBkbwo+IHRoaXMgYmV0
dGVyPwo+CkFoaCB5ZXMgLSB0aGF0IGxvdmVseSBtZXNzYWdlLiBJdCB0dXJucyBvdXQgdGhhdCBv
bGRlciB2ZXJzaW9ucyBvZgphdXRvbWFrZSB3aWxsIGV2ZW4gZXJyb3Igb3V0IFsxXSwgcmF0aGVy
IHRoYW4ganVzdCBwcmludGluZyBvdXQgYQp3YXJuaW5nLiBBIGhhbmR5IHdvcmthcm91bmQgd291
bGQgYmUgdG8gYWRkIGEgLmdpdGlnbm9yZSAoYW5kIGEgc2Vjb25kCm9uZSBpbiB0aGUgdG9wIGZv
bGRlcikgbGlzdC4gUGx1cyBpdCB3aWxsIHNsaW0gZG93biB0aGUgdW50cmFja2VkCmZpbGVzIGxp
c3QgYW5kIGxldCB5b3UgY2xlYXJseSBzZWUgd2hlbiBnaXQgYWRkIHdhcyBtaXNzZWQgOi0pCgpD
aGVlcnMKRW1pbAoKWzFdIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/
aWQ9OTAxMzMzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
