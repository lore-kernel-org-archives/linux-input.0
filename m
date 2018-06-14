From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 04/27] docs: fix broken references with multiple hints
Date: Thu, 14 Jun 2018 12:27:37 -0400
Message-ID: <20180614122737.4044a2b7@gandalf.local.home>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <8e28c30c9d0ba8c4f37d57adac7e12e18296a385.1528990947.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <8e28c30c9d0ba8c4f37d57adac7e12e18296a385.1528990947.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Harry Wei <harryxiyou@gmail.com>, devel@driverdev.osuosl.org, Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org, Roy Pledge <Roy.Pledge@nxp.com>, "Serge E. Hallyn" <serge@hallyn.com>, devicetree@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Kosina <jikos@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Benjamin Tissoires <ben>
List-Id: linux-input@vger.kernel.org

T24gVGh1LCAxNCBKdW4gMjAxOCAxMzowODo0OSAtMDMwMApNYXVybyBDYXJ2YWxobyBDaGVoYWIg
PG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3JnPiB3cm90ZToKCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi90cmFjZS9ldmVudHMucnN0Cj4gQEAgLTgsNyArOCw3IEBAIEV2ZW50IFRyYWNpbmcKPiAgMS4g
SW50cm9kdWN0aW9uCj4gID09PT09PT09PT09PT09PQo+ICAKPiAtVHJhY2Vwb2ludHMgKHNlZSBE
b2N1bWVudGF0aW9uL3RyYWNlL3RyYWNlcG9pbnRzLnR4dCkgY2FuIGJlIHVzZWQKPiArVHJhY2Vw
b2ludHMgKHNlZSBEb2N1bWVudGF0aW9uL3RyYWNlL3RyYWNlcG9pbnRzLnJzdCkgY2FuIGJlIHVz
ZWQKPiAgd2l0aG91dCBjcmVhdGluZyBjdXN0b20ga2VybmVsIG1vZHVsZXMgdG8gcmVnaXN0ZXIg
cHJvYmUgZnVuY3Rpb25zCj4gIHVzaW5nIHRoZSBldmVudCB0cmFjaW5nIGluZnJhc3RydWN0dXJl
Lgo+ICAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFjZS90cmFjZXBvaW50LWFuYWx5
c2lzLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhY2UvdHJhY2Vwb2ludC1hbmFseXNpcy5yc3QKPiBp
bmRleCBhNGQzZmYyZTVlZmIuLmJlZjM3YWJmNGFkMyAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL3RyYWNlL3RyYWNlcG9pbnQtYW5hbHlzaXMucnN0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi90
cmFjZS90cmFjZXBvaW50LWFuYWx5c2lzLnJzdAo+IEBAIC02LDcgKzYsNyBAQCBOb3RlcyBvbiBB
bmFseXNpbmcgQmVoYXZpb3VyIFVzaW5nIEV2ZW50cyBhbmQgVHJhY2Vwb2ludHMKPiAgMS4gSW50
cm9kdWN0aW9uCj4gID09PT09PT09PT09PT09PQo+ICAKPiAtVHJhY2Vwb2ludHMgKHNlZSBEb2N1
bWVudGF0aW9uL3RyYWNlL3RyYWNlcG9pbnRzLnR4dCkgY2FuIGJlIHVzZWQgd2l0aG91dAo+ICtU
cmFjZXBvaW50cyAoc2VlIERvY3VtZW50YXRpb24vdHJhY2UvdHJhY2Vwb2ludHMucnN0KSBjYW4g
YmUgdXNlZCB3aXRob3V0Cj4gIGNyZWF0aW5nIGN1c3RvbSBrZXJuZWwgbW9kdWxlcyB0byByZWdp
c3RlciBwcm9iZSBmdW5jdGlvbnMgdXNpbmcgdGhlIGV2ZW50Cj4gIHRyYWNpbmcgaW5mcmFzdHJ1
Y3R1cmUuCj4gIAoKQWNrZWQtYnk6IFN0ZXZlbiBSb3N0ZWR0IChWTXdhcmUpIDxyb3N0ZWR0QGdv
b2RtaXMub3JnPgoKLS0gU3RldmUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVsCg==
