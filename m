From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 06/36] drm/rockchip: Only wait for panel ACK on PSR
 entry
Date: Mon, 12 Mar 2018 17:58:22 +0100
Message-ID: <1909495.WV5cT3kS9W@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-7-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-7-enric.balletbo@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, thierry.reding@gmail.com, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, linux-kernel@vger.kernel.org, jeffy.chen@rock-chips.com, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, tfiga@chromium.org, kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

SGksCgp0aGUgc3ViamVjdCBpcyBtaXNsZWFkaW5nIEkgdGhpbmssIGFzIHRoaXMgaXMgdG91Y2hp
bmcgb25seSB0aGUgZ2VuZXJpYwpicmlkZ2UgY29kZSBhbmQgbm90IGFueXRoaW5nIFJvY2tjaGlw
LXJlbGF0ZWQsIHNvIHNob3VsZCBwcm9iYWJseQpiZSAiZHJtL2JyaWRnZSI/CgpBbSBGcmVpdGFn
LCA5LiBNw6RyeiAyMDE4LCAyMzoyMjo1NyBDRVQgc2NocmllYiBFbnJpYyBCYWxsZXRibyBpIFNl
cnJhOgo+IEZyb206IHphaW4gd2FuZyA8d3p6QHJvY2stY2hpcHMuY29tPgo+IAo+IFdlIGN1cnJl
bnRseSB3YWl0IGZvciB0aGUgcGFuZWwgdG8gbWlycm9yIG91ciBpbnRlbmRlZCBQU1Igc3RhdGUK
PiBiZWZvcmUgY29udGludWluZyBvbiBib3RoIFBTUiBlbnRlciBhbmQgUFNSIGV4aXQuIFRoaXMg
aXMgcmVhbGx5Cj4gb25seSBpbXBvcnRhbnQgdG8gZG8gd2hlbiB3ZSdyZSBlbnRlcmluZyBQU1Is
IHNpbmNlIHdlIHdhbnQgdG8KPiBiZSBzdXJlIHRoZSBsYXN0IGZyYW1lIHdlIHB1c2hlZCBpcyBi
ZWluZyBzZXJ2ZWQgZnJvbSB0aGUgcGFuZWwncwo+IGludGVybmFsIGZiIGJlZm9yZSBzaHV0dGlu
ZyBkb3duIHRoZSBzb2MgYmxvY2tzICh2b3AvYW5hbG9naXgpLgo+IAo+IFRoaXMgcGF0Y2ggY2hh
bmdlcyB0aGUgYmVoYXZpb3Igc3VjaCB0aGF0IHdlIG9ubHkgd2FpdCBmb3IgdGhlCj4gcGFuZWwg
dG8gY29tcGxldGUgdGhlIFBTUiB0cmFuc2l0aW9uIHdoZW4gd2UncmUgZW50ZXJpbmcgUFNSLCBh
bmQKPiB0byBza2lwIHZlcmlmaWNhdGlvbiB3aGVuIHdlJ3JlIGV4aXRpbmcuCj4gCj4gQ2M6IFN0
w6lwaGFuZSBNYXJjaGVzaW4gPG1hcmNoZXVAY2hyb21pdW0ub3JnPgo+IENjOiBTb25ueSBSYW8g
PHNvbm55cmFvQGNocm9taXVtLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiB6YWluIHdhbmcgPHd6ekBy
b2NrLWNoaXBzLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIFBhdWwgPHNlYW5wYXVsQGNocm9t
aXVtLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBUaGllcnJ5IEVzY2FuZGUgPHRoaWVycnkuZXNjYW5k
ZUBjb2xsYWJvcmEuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEVucmljIEJhbGxldGJvIGkgU2VycmEg
PGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+Cj4gVGVzdGVkLWJ5OiBNYXJlayBTenlwcm93
c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+CgpjaGFuZ2UgaXRzZWxmIGxvb2tzIGdvb2Qs
IHNvClJldmlld2VkLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNoLmRlPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
