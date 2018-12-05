From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
Date: Wed, 5 Dec 2018 13:52:54 -0800
Message-ID: <CA+jURcuR8LzsQUPL4OMfx+OGV5DkADibO_LS_YPmA5pCGRkk8Q@mail.gmail.com>
References: <20181205004228.10714-1-peter.hutterer@who-t.net> <20181205004228.10714-8-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205004228.10714-8-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

Hi Peter,

On Tue, 4 Dec 2018 at 16:43, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> Changes to v2:
> - m560 now has REL_HWHEEL_HI_RES (untested, I don't have the device)

I just tested with my M560, and it now reports REL_HWHEEL_HI_RES correctly.

Verified-by: Harry Cutts <hcutts@chromium.org>

Thanks,

Harry Cutts
Chrome OS Touch/Input team
