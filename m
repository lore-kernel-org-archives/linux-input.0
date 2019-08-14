From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Add back missing mask for event_type
Date: Wed, 14 Aug 2019 15:06:25 -0700
Message-ID: <20190814220625.GD121898@dtor-ws>
References: <20190813093821.74158-1-fshao@chromium.org>
 <CANMq1KCNFfWA=ApVUFoPctgTftHDSAvGjtk-Xu2hcKWBq9R1zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANMq1KCNFfWA=ApVUFoPctgTftHDSAvGjtk-Xu2hcKWBq9R1zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Fei Shao <fshao@chromium.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Ting Shen <phoenixshen@chromium.org>, Brian Norris <briannorris@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 13, 2019 at 05:47:22PM +0800, Nicolas Boichat wrote:
> On Tue, Aug 13, 2019 at 5:38 PM Fei Shao <fshao@chromium.org> wrote:
> >
> > In the previous patch we didn't mask out event_type in case statement,
> > so switches are always picked instead of buttons, which results in
> > ChromeOS devices misbehaving when power button is pressed.
> > This patch adds back the missing mask.
> >
> > Fixes: d096aa3eb604 ("Input: cros_ec_keyb: mask out extra flags in event_type")
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> 
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Applied, thank you.

> 
> > ---
> >  drivers/input/keyboard/cros_ec_keyb.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> > index 38cb6d82d8fe..bef7bee6f05e 100644
> > --- a/drivers/input/keyboard/cros_ec_keyb.c
> > +++ b/drivers/input/keyboard/cros_ec_keyb.c
> > @@ -226,6 +226,8 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
> >  {
> >         struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
> >                                                   notifier);
> > +       uint8_t mkbp_event_type = ckdev->ec->event_data.event_type &
> > +                                 EC_MKBP_EVENT_TYPE_MASK;
> >         u32 val;
> >         unsigned int ev_type;
> >
> > @@ -237,7 +239,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
> >         if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
> >                 return NOTIFY_OK;
> >
> > -       switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
> > +       switch (mkbp_event_type) {
> >         case EC_MKBP_EVENT_KEY_MATRIX:
> >                 pm_wakeup_event(ckdev->dev, 0);
> >
> > @@ -264,7 +266,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
> >         case EC_MKBP_EVENT_SWITCH:
> >                 pm_wakeup_event(ckdev->dev, 0);
> >
> > -               if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
> > +               if (mkbp_event_type == EC_MKBP_EVENT_BUTTON) {
> >                         val = get_unaligned_le32(
> >                                         &ckdev->ec->event_data.data.buttons);
> >                         ev_type = EV_KEY;
> > --
> > 2.23.0.rc1.153.gdeed80330f-goog

-- 
Dmitry
