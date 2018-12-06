From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: restore EV_ABS ABS_RESERVED
Date: Fri, 7 Dec 2018 08:46:05 +1000
Message-ID: <20181206224605.GA27899@jelly>
References: <20181205230336.GA23462@jelly>
 <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
 <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 06, 2018 at 10:24:11AM +0100, Benjamin Tissoires wrote:
> On Thu, Dec 6, 2018 at 9:36 AM Martin Kepplinger
> <martin.kepplinger@ginzinger.com> wrote:
> >
> > On 06.12.18 00:03, Peter Hutterer wrote:
> > > ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
> > > ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.
> > >
> > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> >
> > Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Dmitry, I do not think this one will conflict with the high res wheel
> patches, so I think it should be safe to take it through your tree.
> If you think it'll be an issue, I can also take it through the HID one.

fwiw, patch was made on top of v4.20-rc5, so it shouldn't conflict.

Cheers,
   Peter
