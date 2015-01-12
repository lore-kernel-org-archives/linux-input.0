From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/2] HID: hid-sensor-hub: Enhance get feature report
 API
Date: Mon, 12 Jan 2015 08:38:46 -0800
Message-ID: <1421080726.4459.205.camel@spandruv-desktop.jf.intel.com>
References: <1421027714-25726-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1421027714-25726-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAAj6DX1a-UNkdtKZ+eoF2Cvv_nfM1Cc-Vqu_+iHn_sRNto+NjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAj6DX1a-UNkdtKZ+eoF2Cvv_nfM1Cc-Vqu_+iHn_sRNto+NjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2015-01-12 at 11:57 +0800, Antonio Borneo wrote: 
> On Mon, Jan 12, 2015 at 9:55 AM, Srinivas Pandruvada
> <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > Some hid sensor feature report can contain more than one reports.
> > This API can now support receiving multiple values from the feature
> > report.
> > Also update the parameters in the users of this API.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/hid/hid-sensor-hub.c                           | 16 ++++++++++++++--
> >  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 13 +++++++------
> >  drivers/iio/common/hid-sensors/hid-sensor-trigger.c    |  4 ++--
> >  include/linux/hid-sensor-hub.h                         |  8 +++++---
> >  4 files changed, 28 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> > index 83b6e15..d17aa67 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -218,10 +218,11 @@ done_proc:
> >  EXPORT_SYMBOL_GPL(sensor_hub_set_feature);
> >
> >  int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> > -                               u32 field_index, s32 *value)
> > +                          u32 field_index, int buffer_size, void *buffer)
> >  {
> >         struct hid_report *report;
> >         struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
> > +       int report_size;
> >         int ret = 0;
> >
> >         mutex_lock(&data->mutex);
> > @@ -233,7 +234,18 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> >         }
> >         hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
> >         hid_hw_wait(hsdev->hdev);
> > -       *value = report->field[field_index]->value[0];
> > +
> > +       /* calculate number of bytes required to read this field */
> > +       report_size = report->field[field_index]->report_size / 8;
> > +       if (report->field[field_index]->report_size % 8)
> > +               ++report_size;
> > +       report_size *= report->field[field_index]->report_count;
> 
> Hi Srinivas,
Hi Antonio, 
> 
> I resend my reply.
> It was discarded by the mailing list due to wrong setting with html formatting.
> 
> I think would be more clear writing directly:
> 
>         report_size = DIV_ROUND_UP(report->field[field_index]->report_size, 8) *
>                       report->field[field_index]->report_count;
Correct. I will resubmit this one.

Thanks,
Srinivas

> 
> Regards,
> Antonio
> 
> > +       if (!report_size) {
> > +               ret = -EINVAL;
> > +               goto done_proc;
> > +       }
> > +       ret = min(report_size, buffer_size);
> > +       memcpy(buffer, report->field[field_index]->value, ret);
> >
> >  done_proc:
> >         mutex_unlock(&data->mutex);
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index 25b01e1..e1435e9 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -153,8 +153,8 @@ s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
> >         int ret;
> >
> >         ret = sensor_hub_get_feature(st->hsdev,
> > -               st->poll.report_id,
> > -               st->poll.index, &value);
> > +                                    st->poll.report_id,
> > +                                    st->poll.index, sizeof(value), &value);
> >
> >         if (ret < 0 || value < 0) {
> >                 return -EINVAL;
> > @@ -174,8 +174,8 @@ int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
> >         int ret;
> >
> >         ret = sensor_hub_get_feature(st->hsdev,
> > -               st->poll.report_id,
> > -               st->poll.index, &value);
> > +                                    st->poll.report_id,
> > +                                    st->poll.index, sizeof(value), &value);
> >         if (ret < 0 || value < 0) {
> >                 *val1 = *val2 = 0;
> >                 return -EINVAL;
> > @@ -229,8 +229,9 @@ int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
> >         int ret;
> >
> >         ret = sensor_hub_get_feature(st->hsdev,
> > -               st->sensitivity.report_id,
> > -               st->sensitivity.index, &value);
> > +                                    st->sensitivity.report_id,
> > +                                    st->sensitivity.index, sizeof(value),
> > +                                    &value);
> >         if (ret < 0 || value < 0) {
> >                 *val1 = *val2 = 0;
> >                 return -EINVAL;
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index 92068cd..ef0c495 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -76,8 +76,8 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
> >         }
> >
> >         sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
> > -                                       st->power_state.index,
> > -                                       &state_val);
> > +                              st->power_state.index,
> > +                              sizeof(state_val), &state_val);
> >         return 0;
> >  }
> >  EXPORT_SYMBOL(hid_sensor_power_state);
> > diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> > index 0b21c4f..1995bbd 100644
> > --- a/include/linux/hid-sensor-hub.h
> > +++ b/include/linux/hid-sensor-hub.h
> > @@ -203,13 +203,15 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> >  * @hsdev:      Hub device instance.
> >  * @report_id:  Report id to look for
> >  * @field_index:        Field index inside a report
> > -* @value:      Place holder for return value
> > +* @buffer_size:        size of the buffer
> > +* @buffer:     buffer to copy output
> >  *
> >  * Used to get a field in feature report. For example this can get polling
> > -* interval, sensitivity, activate/deactivate state.
> > +* interval, sensitivity, activate/deactivate state. On success it returns
> > +* number of bytes copied to buffer. On failure, it returns value < 0.
> >  */
> >  int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> > -                       u32 field_index, s32 *value);
> > +                          u32 field_index, int buffer_size, void *buffer);
> >
> >  /* hid-sensor-attributes */
> >
> > --
> > 1.9.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
