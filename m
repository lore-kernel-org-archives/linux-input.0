From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
Date: Fri, 14 Dec 2018 14:46:50 +0100
Message-ID: <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
References: <20181205004228.10714-1-peter.hutterer@who-t.net> <20181205004228.10714-8-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205004228.10714-8-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, lkml <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Le mer. 5 d=C3=A9c. 2018 =C3=A0 01:44, Peter Hutterer <peter.hutterer@who-t=
.net> a =C3=A9crit :
>
> From: Harry Cutts <hcutts@chromium.org>
>
> There are three features used by various Logitech mice for
> high-resolution scrolling: the scrolling acceleration bit in HID++ 1.0,
> and the x2120 and x2121 features in HID++ 2.0 and above. This patch
> supports all three, and uses the multiplier reported by the mouse for
> the HID++ 2.0+ features.

Hi, The G500s (and the G500 too, I think) does support the "scrolling
acceleration" bit. If I set it, I get around 8 events for each wheel
"click", this is what this driver expects, right? If I understood
correctly, I should try this patch with the
HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
