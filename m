From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH V1] elan_i2c: Increment wakeup count if wake source.
Date: Wed, 15 May 2019 09:17:59 -0700
Message-ID: <CAEZbON4Z5GKYvMZJ8ojko_f1xzv2rf4uR6cDz2LMxu+XvzTzog@mail.gmail.com>
References: <20190513220610.177489-1-ravisadineni@chromium.org> <CAKdAkRQ_J6QWxtWpoRQnNWKcJpXox6xVDZWcWYOXkBhPSn99Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQ_J6QWxtWpoRQnNWKcJpXox6xVDZWcWYOXkBhPSn99Rw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Abhishek Bhardwaj <abhishekbh@google.com>, Todd Broch <tbroch@google.com>, lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, May 13, 2019 at 4:29 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Ravi,
>
> On Mon, May 13, 2019 at 3:06 PM Ravi Chandra Sadineni
> <ravisadineni@chromium.org> wrote:
> >
> > Notify the PM core that this dev is the wake source. This helps
> > userspace daemon tracking the wake source to identify the origin of the
> > wake.
>
> I wonder if we could do that form the i2c core instead of individual drivers?
I am sorry, I don't see a way how this could be done.
>
> >
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > ---
> >  drivers/input/mouse/elan_i2c_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > index f9525d6f0bfe..2c0561e20b7f 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -981,6 +981,8 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
> >         if (error)
> >                 goto out;
> >
> > +       pm_wakeup_event(dev, 0);
> > +
> >         switch (report[ETP_REPORT_ID_OFFSET]) {
> >         case ETP_REPORT_ID:
> >                 elan_report_absolute(data, report);
> > --
> > 2.20.1
> >
>
> Thanks.
>
> --
> Dmitry

Thanks,
Ravi
