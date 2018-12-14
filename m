From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
Date: Fri, 14 Dec 2018 10:37:32 -0800
Message-ID: <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, lkml <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Clement,

On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
<clement.vuchener@gmail.com> wrote:
> Hi, The G500s (and the G500 too, I think) does support the "scrolling
> acceleration" bit. If I set it, I get around 8 events for each wheel
> "click", this is what this driver expects, right? If I understood
> correctly, I should try this patch with the
> HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.

Thanks for the info! Yes, that should work.

Harry Cutts
Chrome OS Touch/Input team
