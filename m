From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH 4/8] HID: input: use the Resolution Multiplier for
 high-resolution scrolling
Date: Mon, 26 Nov 2018 18:17:15 -0800
Message-ID: <CA+jURcv+1xWUR=xabVr+70LthoQqNbLZ_a8zTXxEeLrG4=wohw@mail.gmail.com>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <20181122063409.15816-5-peter.hutterer@who-t.net> <20181122232839.GA10747@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122232839.GA10747@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

On Thu, 22 Nov 2018 at 15:28, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> The choices we have now are:
> - use 1200 or 12000 internally and divide by 10 before sending the
>   final value
> - just make the evdev API use 1200 or 12000 and let userspace deal with it.
>   much simpler.
>
> Any suggestions/comments?

The second option seems cleaner to me, as then we don't have multiple
representations of the scroll amount to get mixed up.

Harry Cutts
Chrome OS Touch/Input team
