From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: restore EV_ABS ABS_RESERVED
Date: Thu, 6 Dec 2018 10:24:11 +0100
Message-ID: <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
References: <20181205230336.GA23462@jelly> <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 6, 2018 at 9:36 AM Martin Kepplinger
<martin.kepplinger@ginzinger.com> wrote:
>
> On 06.12.18 00:03, Peter Hutterer wrote:
> > ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
> > ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.
> >
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>
> Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Dmitry, I do not think this one will conflict with the high res wheel
patches, so I think it should be safe to take it through your tree.
If you think it'll be an issue, I can also take it through the HID one.

Cheers,
Benjamin
