From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Input: synaptics - remove X240 from the topbuttonpad list
Date: Tue, 21 May 2019 08:49:08 +0200
Message-ID: <CAO-hwJLXB8Qec9Yhz0y6WgvEpE6KHk_53g4VtPGj9mfvMzk4dg@mail.gmail.com>
References: <20190519072711.2592-1-aaron.ma@canonical.com> <20190519072711.2592-2-aaron.ma@canonical.com>
 <20190521050850.GC183429@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521050850.GC183429@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaron Ma <aaron.ma@canonical.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Christopher Heiny <Cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

On Tue, May 21, 2019 at 7:09 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Aaron,
>
> On Sun, May 19, 2019 at 03:27:11PM +0800, Aaron Ma wrote:
> > Lenovo ThinkPad X240 does not have the top software button.
> > When this wrong ID in top button list, smbus mode will fail to probe,
> > so keep it working at PS2 mode.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index b6da0c1267e3..6ae7bc92476b 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -140,7 +140,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
> >       "LEN002E",
> >       "LEN0033", /* Helix */
> >       "LEN0034", /* T431s, L440, L540, T540, W540, X1 Carbon 2nd */
> > -     "LEN0035", /* X240 */
>
> According to the history this came from Synaptics through Hans, so I'd
> like to make sure there are no several X240 versions floating around...

A quick google image search showed that the X240 had 2 versions: one
with the top software buttons, one without.

And this definitively rings a bell. I am sure we asked Lenovo and
Synaptics to change the PnPID when they would do such a change, but
they "forgot" during the *40 series refresh.
We have code in place to fix the reported ranges of the coordinates,
and we had to check against the board id (see min_max_pnpid_table[] in
synaptics.c).
Unfortunately, X240 (LEN0035) is not part of this table, so I don't
know which refresh of the board ID has implemented the non top
software buttons.

Cheers,
Benjamin


>
> >       "LEN0036", /* T440 */
> >       "LEN0037", /* X1 Carbon 2nd */
> >       "LEN0038",
> > --
> > 2.17.1
> >
>
> Thanks.
>
> --
> Dmitry
