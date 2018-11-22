From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/7] HID: revert the Logitech High Resolution wheel support
Date: Thu, 22 Nov 2018 09:01:55 +0100
Message-ID: <CAO-hwJKBEUMBcSE-oCGAtxt0iaboN6ObvzgBnCtWmb2XiUM-5g@mail.gmail.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, hcutts@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 21, 2018 at 4:27 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> It turns out that the implementation of the high resolution support of
> Logitech wheels is rather incompatible with the mice from Microsoft.
>
> We had a lengthy discussion off-list and the summary is quoted in 7/7.
>
> The TL;DR, we need to revert the current series before it gets out in
> a released kernel and work on a better approach for 4.21.
>
> This patch series has informally been acked by Dmitry, Harry, Jiri, Nestor
> and Peter, but I wouldn't mind a public ack before I push this to
> the for-linus branch.
>
> Dmitry, I chose to also revert "Input: Add the `REL_WHEEL_HI_RES` event code"
> as the documentation needs to be updated.
> I would understand if you rather keep the patch that way and we just update
> the doc. This would help synchronizing the trees. So please tell me if you
> want 7/7 in the series or not (I'll reshuffle the commit message to have
> the summary from Peter).
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (7):
>   Revert "HID: input: simplify/fix high-res scroll event handling"
>   Revert "HID: logitech: fix a used uninitialized GCC warning"
>   Revert "HID: logitech: Use LDJ_DEVICE macro for existing Logitech
>     mice"
>   Revert "HID: logitech: Enable high-resolution scrolling on Logitech
>     mice"
>   Revert "HID: logitech: Add function to enable HID++ 1.0 "scrolling
>     acceleration""
>   Revert "HID: input: Create a utility class for counting scroll events"
>   Revert "Input: Add the `REL_WHEEL_HI_RES` event code"
>
>  Documentation/input/event-codes.rst    |  11 +-
>  drivers/hid/hid-input.c                |  44 ----
>  drivers/hid/hid-logitech-hidpp.c       | 309 +++----------------------
>  include/linux/hid.h                    |  28 ---
>  include/uapi/linux/input-event-codes.h |  10 -
>  5 files changed, 28 insertions(+), 374 deletions(-)
>
> --
> 2.19.1
>

The series is now applied. Thanks everybody for the quick answers.

Cheers,
Benjamin
