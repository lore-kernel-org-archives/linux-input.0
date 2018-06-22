From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH v3 1/2] HID: i2c-hid: Use devm to allocate i2c_hid struct
Date: Fri, 22 Jun 2018 15:39:46 -0700
Message-ID: <CAE_wzQ9bOd4Ee06UbBY8NePRdtsF5wX7awmJqozn0FBhRBfkdA@mail.gmail.com>
References: <20180622022717.134300-1-swboyd@chromium.org> <20180622022717.134300-2-swboyd@chromium.org>
 <CAO-hwJJxSHqwEcypc-PVSDUoOSM4OHcOP18QJpoxq6OqKcbq-w@mail.gmail.com> <095738e5-eb31-905b-b496-0d78489e253d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <095738e5-eb31-905b-b496-0d78489e253d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, swboyd@chromium.org, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, andriy.shevchenko@linux.intel.com, Doug Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 22, 2018 at 2:13 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 22-06-18 09:16, Benjamin Tissoires wrote:
> > On Fri, Jun 22, 2018 at 4:27 AM, Stephen Boyd <swboyd@chromium.org> wrote:
> >> Use devm here to save some lines and prepare for bulk regulator usage in
> >> this driver. Otherwise, when we devm bulk get regulators we'll free the
> >> containing i2c_hid structure and try to put regulator pointers from
> >> freed memory.
> >>
> >> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >> Cc: Hans de Goede <hdegoede@redhat.com>
> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Cc: Dmitry Torokhov <dtor@chromium.org>
> >> Cc: Doug Anderson <dianders@chromium.org>
> >> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >> ---
> >>   drivers/hid/i2c-hid/i2c-hid.c | 9 +++------
> >>   1 file changed, 3 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> >> index c1652bb7bd15..c7d6738dc524 100644
> >> --- a/drivers/hid/i2c-hid/i2c-hid.c
> >> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> >> @@ -1002,18 +1002,18 @@ static int i2c_hid_probe(struct i2c_client *client,
> >>                  return client->irq;
> >>          }
> >>
> >> -       ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
> >> +       ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
> >
> > IIRC, I never made the switch towards devm for i2c_hid because at the
> > time there was a "all or nothing" rule regarding devm.
>
> I'm not aware of any such rule. Sure ideally everything should use
> devm, because it makes life just so much easier. But I've seen mixed
> use in plenty of cases.

When mixing managed and unmanaged resources you need to be extremely
careful to make sure they are released in proper order. There were
many naive conversions that would convert just part of resources to
devm and end up, let's say, powering down rails of a device or turning
off clocks while interrupts are still registered, which causes errors
if interrupt fires, and so on. I usually request people to do either
full conversion or leave the driver alone.

That said, using devm to allocate the "main" driver structure is usually safe.

>
> With that said converting fully to devm is not necessarily a bad
> idea.
>
> Regards,
>
> Hans
>
>
> > But given that the regulator already has a devm inside, I think we are
> > screwed here and we should probably try to devm-ize the module.
> >
> > I seem to remember that someone posted a devm version of
> > hid_allocate_device/hid-add_device, but I don't think this ever went
> > upstream (because no use).

There is always devm_add_action_or_reset() to inject custom actions
into devm stack to work around lacking devm APIs.

> >
> > Otherwise, for the series:
> > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Cheers,
> > Benjamin
> >
> >
> >
> >>          if (!ihid)
> >>                  return -ENOMEM;
> >>
> >>          if (client->dev.of_node) {
> >>                  ret = i2c_hid_of_probe(client, &ihid->pdata);
> >>                  if (ret)
> >> -                       goto err;
> >> +                       return ret;
> >>          } else if (!platform_data) {
> >>                  ret = i2c_hid_acpi_pdata(client, &ihid->pdata);
> >>                  if (ret)
> >> -                       goto err;
> >> +                       return ret;
> >>          } else {
> >>                  ihid->pdata = *platform_data;
> >>          }
> >> @@ -1126,7 +1126,6 @@ static int i2c_hid_probe(struct i2c_client *client,
> >>
> >>   err:
> >>          i2c_hid_free_buffers(ihid);
> >> -       kfree(ihid);
> >>          return ret;
> >>   }
> >>
> >> @@ -1150,8 +1149,6 @@ static int i2c_hid_remove(struct i2c_client *client)
> >>
> >>          regulator_disable(ihid->pdata.supply);
> >>
> >> -       kfree(ihid);
> >> -
> >>          return 0;
> >>   }
> >>
> >> --
> >> Sent by a computer through tubes
> >>
