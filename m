From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: apple: Fix stuck function keys when using FN
Date: Mon, 1 Jul 2019 10:32:44 +0200
Message-ID: <CAO-hwJ+1FyaXj0iuCjvc5R-Kqdh6PNB7Un0ko1F_NV7-f5GMdw@mail.gmail.com>
References: <20190610213106.19342-1-mail@joaomoreno.com> <CAHxFc3QC147B6j4pBztjK7stLgCveeYhJWojai_SbKNbnpC9yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHxFc3QC147B6j4pBztjK7stLgCveeYhJWojai_SbKNbnpC9yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?Sm/Do28gTW9yZW5v?= <mail@joaomoreno.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi João,

On Sun, Jun 30, 2019 at 10:15 PM João Moreno <mail@joaomoreno.com> wrote:
>
> Hi Jiri & Benjamin,
>
> Let me know if you need something else to get this patch moving forward. This
> fixes an issue I hit daily, it would be great to get it fixed.

Sorry for the delay, I am very busy with internal corporate stuff, and
I tried setting up a new CI system at home, and instead of spending a
couple of ours, I am down to 2 weeks of hard work, without possibility
to switch to the new right now :(
Anyway.

>
> Thanks.
>
> On Mon, 10 Jun 2019 at 23:31, Joao Moreno <mail@joaomoreno.com> wrote:
> >
> > This fixes an issue in which key down events for function keys would be
> > repeatedly emitted even after the user has raised the physical key. For
> > example, the driver fails to emit the F5 key up event when going through
> > the following steps:
> > - fnmode=1: hold FN, hold F5, release FN, release F5
> > - fnmode=2: hold F5, hold FN, release F5, release FN

Ouch :/

> >
> > The repeated F5 key down events can be easily verified using xev.
> >
> > Signed-off-by: Joao Moreno <mail@joaomoreno.com>
> > ---
> >  drivers/hid/hid-apple.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 1cb41992aaa1..81867a6fa047 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -205,20 +205,21 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
> >                 trans = apple_find_translation (table, usage->code);
> >
> >                 if (trans) {
> > -                       if (test_bit(usage->code, asc->pressed_fn))
> > -                               do_translate = 1;
> > -                       else if (trans->flags & APPLE_FLAG_FKEY)
> > -                               do_translate = (fnmode == 2 && asc->fn_on) ||
> > -                                       (fnmode == 1 && !asc->fn_on);
> > +                       int fn_on = value ? asc->fn_on :
> > +                               test_bit(usage->code, asc->pressed_fn);
> > +
> > +                       if (!value)
> > +                               clear_bit(usage->code, asc->pressed_fn);
> > +                       else if (asc->fn_on)
> > +                               set_bit(usage->code, asc->pressed_fn);

I have the feeling that this is not the correct fix here.

I might be wrong, but the following sequence might also mess up the
driver state, depending on how the reports are emitted:
- hold FN, hold F4, hold F5, release F4, release FN, release F5

The reason is that the driver only considers you have one key pressed
with the modifier, and as the code changed its state based on the last
value.

IMO a better fix would:

- keep the existing `trans` mapping lookout
- whenever a `trans` mapping gets found:
  * get both translated and non-translated currently reported values
(`test_bit(keycode, input_dev->key)`)
  * if one of them is set to true, then consider the keycode to be the
one of the key (no matter fn_on)
    -> deal with `value` with the corrected keycode
  * if the key was not pressed:
    -> chose the keycode based on `fn_on` and `fnmode` states
    and report the key press event

This should remove the nasty pressed_fn state which depends on the
other pressed keys.

Cheers,
Benjamin

> > +
> > +                       if (trans->flags & APPLE_FLAG_FKEY)
> > +                               do_translate = (fnmode == 2 && fn_on) ||
> > +                                       (fnmode == 1 && !fn_on);
> >                         else
> >                                 do_translate = asc->fn_on;
> >
> >                         if (do_translate) {
> > -                               if (value)
> > -                                       set_bit(usage->code, asc->pressed_fn);
> > -                               else
> > -                                       clear_bit(usage->code, asc->pressed_fn);
> > -
> >                                 input_event(input, usage->type, trans->to,
> >                                                 value);
> >
> > --
> > 2.19.1
> >
