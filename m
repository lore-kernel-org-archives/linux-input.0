From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 01/36] drm/bridge: analogix_dp: detect Sink PSR state
 after configuring the PSR
Date: Wed, 14 Mar 2018 11:32:31 +0100
Message-ID: <3256074.V8N7sWxg0l@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180309222327.18689-2-enric.balletbo@collabora.com>
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, thierry.reding@gmail.com, Laurent.pinchart@ideasonboard.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, linux-kernel@vger.kernel.org, jeffy.chen@rock-chips.com, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, dianders@chromium.org, tfiga@chromium.org, kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org

QW0gRnJlaXRhZywgOS4gTcOkcnogMjAxOCwgMjM6MjI6NTIgQ0VUIHNjaHJpZWIgRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYToKPiBGcm9tOiBZYWtpciBZYW5nIDx5a2tAcm9jay1jaGlwcy5jb20+Cj4g
Cj4gTWFrZSBzdXJlIHRoZSByZXF1ZXN0IFBTUiBzdGF0ZSB0YWtlcyBlZmZlY3QgaW4gYW5hbG9n
aXhfZHBfc2VuZF9wc3Jfc3BkKCkKPiBmdW5jdGlvbiwgb3IgcHJpbnQgdGhlIHNpbmsgUFNSIGVy
cm9yIHN0YXRlIGlmIHdlIGZhaWxlZCB0byBhcHBseSB0aGUKPiByZXF1ZXN0ZWQgUFNSIHNldHRp
bmcuCj4gCj4gQ2M6IOW+geWiniDnjosgPHd6ekByb2NrLWNoaXBzLmNvbT4KPiBDYzogU3TDqXBo
YW5lIE1hcmNoZXNpbiA8bWFyY2hldUBjaHJvbWl1bS5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogWWFr
aXIgWWFuZyA8eWtrQHJvY2stY2hpcHMuY29tPgo+IFtzZWFucGF1bCBjaGFuZ2VkIHRpbWVvdXQg
bG9vcCB0byBhIHJlYWR4IHBvbGxdCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBQYXVsIDxzZWFucGF1
bEBjaHJvbWl1bS5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogVGhpZXJyeSBFc2NhbmRlIDx0aGllcnJ5
LmVzY2FuZGVAY29sbGFib3JhLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBFbnJpYyBCYWxsZXRibyBp
IFNlcnJhIDxlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tPgo+IFRlc3RlZC1ieTogTWFyZWsg
U3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgoKYXBwbGllZCB0byBkcm0tbWlz
Yy1uZXh0CgpUaGFua3MKSGVpa28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVsCg==
