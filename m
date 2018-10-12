From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/5] Fix Elan I2C touchpads in latest generation from Lenovo
Date: Fri, 12 Oct 2018 21:07:21 +0200
Message-ID: <CAO-hwJKenvHpOQc6vjxDq0YZesLJVu1MXPuZ-iTSLKxJEbZeAQ@mail.gmail.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com> <20181012185342.GA35430@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012185342.GA35430@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 12, 2018 at 8:53 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Oct 12, 2018 at 04:24:08PM +0200, Benjamin Tissoires wrote:
> > Since v4.18, we unconditionally switch the I2C capable touchpads over I2C.
> > In the model I had (a pre-prod t480s I guess), the touchpad was behaving
> > fine.
> > However, it occurs that later production models don't expose the clickpad
> > information from I2C. The Windows driver gets all the information from PS/2
> > so we should do the same.
> >
> > The situation is even worse for the P52. Once of the query parameter function
> > fails, which means the touchpad doesn't even probe. This effectively kills
> > the touchpad, which is less than ideal.
> >
> > Dmitry, I am not sure if we should take those for stable in v4.18+.
> > I'd like to, but given the series is 5 patches, I don't know if this
> > will be acceptable.
> > We could revert in stable df077237cf55928f5 but that would mean
> > distributions will have to revert the revert if they want to provide
> > the I2C behavior.
> >
> > So, regarding stable: your call :)
>
> Heh ;) I think we have to fix it at least in 4.19 stable train. How
> about we merge it normally into 4.20, and let it cook there for a while.
> If there is no issues, then we can send it to 4.19 stable manually. How
> does this sound?
>

Sounds like a plan :)

Cheers,
Benjamin
