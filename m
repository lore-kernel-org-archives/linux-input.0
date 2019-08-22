From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: wacom: do not call hid_set_drvdata(hdev, NULL)
Date: Thu, 22 Aug 2019 17:49:34 +0200
Message-ID: <CAO-hwJLyHYmBKiEvcWebr5tyic9tnm1tydgqt8CimxsEaPWrYw@mail.gmail.com>
References: <20190812162740.15898-1-benjamin.tissoires@redhat.com>
 <20190812162740.15898-3-benjamin.tissoires@redhat.com> <CANRwn3QQcGVGx2KjoU0sG70gSjzwjDKUuL_8q-oYFHRYrn4qGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANRwn3QQcGVGx2KjoU0sG70gSjzwjDKUuL_8q-oYFHRYrn4qGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, Linux Input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Aug 17, 2019 at 12:04 AM Jason Gerecke <killertofu@gmail.com> wrote:
>
> On Mon, Aug 12, 2019 at 9:29 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > This is a common pattern in the HID drivers to reset the drvdata.
> > However, this is actually already handled by driver core, so there
> > is no need to do it manually.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Thanks

Applied to for-5.4/wacom

Cheers,
Benjamin

>
> Jason
> ---
> Now instead of four in the eights place /
> you’ve got three, ‘Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can’t take seven from three,    /
> So you look at the sixty-fours....
>
>
> > ---
> >  drivers/hid/wacom_sys.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 53bddb50aeba..69ccfdd51a6f 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -2718,14 +2718,12 @@ static int wacom_probe(struct hid_device *hdev,
> >         wacom_wac->features = *((struct wacom_features *)id->driver_data);
> >         features = &wacom_wac->features;
> >
> > -       if (features->check_for_hid_type && features->hid_type != hdev->type) {
> > -               error = -ENODEV;
> > -               goto fail;
> > -       }
> > +       if (features->check_for_hid_type && features->hid_type != hdev->type)
> > +               return -ENODEV;
> >
> >         error = kfifo_alloc(&wacom_wac->pen_fifo, WACOM_PKGLEN_MAX, GFP_KERNEL);
> >         if (error)
> > -               goto fail;
> > +               return error;
> >
> >         wacom_wac->hid_data.inputmode = -1;
> >         wacom_wac->mode_report = -1;
> > @@ -2743,12 +2741,12 @@ static int wacom_probe(struct hid_device *hdev,
> >         error = hid_parse(hdev);
> >         if (error) {
> >                 hid_err(hdev, "parse failed\n");
> > -               goto fail;
> > +               return error;
> >         }
> >
> >         error = wacom_parse_and_register(wacom, false);
> >         if (error)
> > -               goto fail;
> > +               return error;
> >
> >         if (hdev->bus == BUS_BLUETOOTH) {
> >                 error = device_create_file(&hdev->dev, &dev_attr_speed);
> > @@ -2759,10 +2757,6 @@ static int wacom_probe(struct hid_device *hdev,
> >         }
> >
> >         return 0;
> > -
> > -fail:
> > -       hid_set_drvdata(hdev, NULL);
> > -       return error;
> >  }
> >
> >  static void wacom_remove(struct hid_device *hdev)
> > @@ -2791,8 +2785,6 @@ static void wacom_remove(struct hid_device *hdev)
> >                 wacom_release_resources(wacom);
> >
> >         kfifo_free(&wacom_wac->pen_fifo);
> > -
> > -       hid_set_drvdata(hdev, NULL);
> >  }
> >
> >  #ifdef CONFIG_PM
> > --
> > 2.19.2
> >
