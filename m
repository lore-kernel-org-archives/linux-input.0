From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] Input: elantech - enable middle button support on 2 ThinkPads
Date: Tue, 21 May 2019 08:43:29 +0200
Message-ID: <CAO-hwJ+edn3SD8Z=yc1gOWRsA8_=uPTAHc18PkDhV2y7ackTPw@mail.gmail.com>
References: <20190519072711.2592-1-aaron.ma@canonical.com> <20190521051053.GD183429@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521051053.GD183429@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: Aaron Ma <aaron.ma@canonical.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Tue, May 21, 2019 at 7:11 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Aaron,
>
> On Sun, May 19, 2019 at 03:27:10PM +0800, Aaron Ma wrote:
> > Adding 2 new touchpad PNPIDs to enable middle button support.
>
> Could you add their names in the comments please?
>
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/input/mouse/elantech.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > index a7f8b1614559..530142b5a115 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1189,6 +1189,8 @@ static const char * const middle_button_pnp_ids[] = {
> >       "LEN2132", /* ThinkPad P52 */
> >       "LEN2133", /* ThinkPad P72 w/ NFC */
> >       "LEN2134", /* ThinkPad P72 */
> > +     "LEN0407",

AFAICT, this one is the Lenovo P53.
However, having a whitelist of new models is not going to scale IMO.

I was thinking at submitting a patch to enable middle button
unconditionally, but then I realized that libinput disables middle
click emulation on touchpads with an actual physical middle button.

And this morning I just realized that we might have a better chance at
this if we consider the new models to have the physical middle button.
I know LEN0407 attempts to bind over SMBus, so I would think we can
reduce the set of whitelist by just checking for
ETP_NEW_IC_SMBUS_HOST_NOTIFY (patch coming in).

Cheers,
Benjamin

> > +     "LEN0408",
>
> These should come first - I'd like to keep the list sorted
> alphabetically.
>
> >       NULL
> >  };
> >
> > --
> > 2.17.1
> >
>
> Thanks.
>
> --
> Dmitry
