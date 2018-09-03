From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 0/5] Add support for high-resolution scrolling on
 Logitech mice
Date: Mon, 3 Sep 2018 10:15:08 +0200
Message-ID: <CAO-hwJL6xz=b4wA5WnSeZw1PO+exVgs3isyPO6ZFWVemiJU9yA@mail.gmail.com>
References: <20180830215622.47550-1-hcutts@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hcutts@chromium.org
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, jiri.kosina@suse.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, corbet@lwn.net, Jiri Kosina <jikos@kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Harry,

On Thu, Aug 30, 2018 at 11:56 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> Hi everyone,
>
> This is v2 of the patch set adding support for high-resolution scroll
> wheels on Logitech mice. See the linux-input "Reporting high-resolution
> scroll events" thread [0] for previous discussion of the evdev changes.
> I would love to hear your feedback.

Series looks good. I just tested it on a regular Logitech mouse and a
MX Master with high-res scrolling and everything works as expected.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> Thanks,
>
> Harry Cutts
> Chrome OS Touch/Input team
>
> [0]: https://www.spinics.net/lists/linux-input/msg57380.html
>
>
> Changes in v2:
> * Changed the REL_WHEEL_HI_RES code to use micrometres (a.k.a. microns)
>   as its units, instead of 256ths of a millimetre.
> * Removed support for mice connecting over Bluetooth, due to a bug where
>   the mouse's high-res mode and the driver's settings get out of sync
>   when the mouse is power cycled.
> * Moved the creation of the HID++ 1.0 function and the refactor to use
>   the LDJ_DEVICE macro into separate patches.
> * Added a couple of explanatory comments to the Logitech driver.
>
> Harry Cutts (5):
>   Add the `REL_WHEEL_HI_RES` event code
>   Create a utility class for counting scroll events
>   Add function to enable HID++ 1.0 "scrolling acceleration"
>   Enable high-resolution scrolling on Logitech mice
>   Use LDJ_DEVICE macro for existing Logitech mice
>
>  Documentation/input/event-codes.rst    |  11 +-
>  drivers/hid/hid-input.c                |  45 ++++
>  drivers/hid/hid-logitech-hidpp.c       | 311 ++++++++++++++++++++++---
>  include/linux/hid.h                    |  28 +++
>  include/uapi/linux/input-event-codes.h |   1 +
>  5 files changed, 368 insertions(+), 28 deletions(-)
>
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
