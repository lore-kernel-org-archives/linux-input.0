From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH 0/8] HID: MS and Logitech high-resolution scroll wheel support
Date: Wed, 28 Nov 2018 15:22:14 -0800
Message-ID: <CA+jURcuGGRtyeRXfLK0Or=hDG6KJ1z9eAS8DAuH12-QTNpgs0w@mail.gmail.com>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

On Wed, 21 Nov 2018 at 22:34, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> [snip]
> Devices tested:
> - Microsoft Comfort Optical Mouse 3000
> - Microsoft Sculpt Ergonomic Mouse
> - Microsoft Surface mouse
> - Logitech MX Anywhere 2S
>
> The following devices were tested for the HID feature and didn't have it:
> - Logitech G500s, G303
> - Roccat Kone XTD
> - all the cheap Lenovo, HP, Dell, Logitech USB mice that come with a
>   workstation that I could find in the local office
> - Etekcity something something
> - Razer Imperator
> - Microsoft Classic IntelliMouse
> - Microsoft Surface Mobile Mouse

I just tested the patches with the Microsoft Comfort Optical Mouse
3000. I also tested with the Microsoft Surface Precision mouse [0],
and like the Surface Mobile mouse it didn't seem to report the HID
feature (at least, it was only reporting REL_WHEEL_HI_RES changes of
120 in evtest).

For the series:
Acked-by: Harry Cutts <hcutts@chromium.org>
Verified-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team

[0]: https://microsoft.com/en-us/p/surface-precision-mouse/8qc5p0d8ddjt
