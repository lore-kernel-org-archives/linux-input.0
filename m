From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v5] iio: hid-sensors: use asynchronous resume
Date: Sun, 21 Aug 2016 12:39:42 -0700
Message-ID: <1471808382.23539.6.camel@linux.intel.com>
References: <1471288367-5325-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <bafa3ac3-3542-3c98-c562-91879d485e47@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36773 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753318AbcHUTms (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Aug 2016 15:42:48 -0400
In-Reply-To: <bafa3ac3-3542-3c98-c562-91879d485e47@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com

On Sun, 2016-08-21 at 20:13 +0100, Jonathan Cameron wrote:
> On 15/08/16 20:12, Srinivas Pandruvada wrote:
> > 
> > Some platforms power off sensor hubs during S3 suspend, which will
> > require
> > longer time to resume. This hurts system resume time, so resume
> > asynchronously.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> Applied to the togreg branch of iio.git - initially pushed out as
> testing
> for the autobuilders to play with it.
> 
> Thanks for tidying up the loose ends on this!
> 
Thanks you and Jiri for review and taking ISH patches.

-Srinivas


> Jonathan
> > 
> > ---
> > 
> > Formerly this patch was v4 5/7 for Intel ISH series, which was
> > separated
> > from the series.
> > 
> > v5:
> > Added cancel_work_sync
> > 
> > 
> >  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 22
> > +++++++++++++++++++++-
> >  include/linux/hid-sensor-hub.h                     |  1 +
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index 5b41f9d..5264ed6 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -122,6 +122,14 @@ int hid_sensor_power_state(struct
> > hid_sensor_common *st, bool state)
> >  #endif
> >  }
> >  
> > +static void hid_sensor_set_power_work(struct work_struct *work)
> > +{
> > +	struct hid_sensor_common *attrb = container_of(work,
> > +						       struct
> > hid_sensor_common,
> > +						       work);
> > +	_hid_sensor_power_state(attrb, true);
> > +}
> > +
> >  static int hid_sensor_data_rdy_trigger_set_state(struct
> > iio_trigger *trig,
> >  						bool state)
> >  {
> > @@ -130,6 +138,7 @@ static int
> > hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
> >  
> >  void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
> >  {
> > +	cancel_work_sync(&attrb->work);
> >  	iio_trigger_unregister(attrb->trigger);
> >  	iio_trigger_free(attrb->trigger);
> >  }
> > @@ -170,6 +179,9 @@ int hid_sensor_setup_trigger(struct iio_dev
> > *indio_dev, const char *name,
> >  		goto error_unreg_trigger;
> >  
> >  	iio_device_set_drvdata(indio_dev, attrb);
> > +
> > +	INIT_WORK(&attrb->work, hid_sensor_set_power_work);
> > +
> >  	pm_suspend_ignore_children(&attrb->pdev->dev, true);
> >  	pm_runtime_enable(&attrb->pdev->dev);
> >  	/* Default to 3 seconds, but can be changed from sysfs */
> > @@ -202,7 +214,15 @@ static int hid_sensor_resume(struct device
> > *dev)
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >  	struct hid_sensor_common *attrb =
> > iio_device_get_drvdata(indio_dev);
> > +	schedule_work(&attrb->work);
> > +	return 0;
> > +}
> >  
> > +static int hid_sensor_runtime_resume(struct device *dev)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +	struct hid_sensor_common *attrb =
> > iio_device_get_drvdata(indio_dev);
> >  	return _hid_sensor_power_state(attrb, true);
> >  }
> >  
> > @@ -211,7 +231,7 @@ static int hid_sensor_resume(struct device
> > *dev)
> >  const struct dev_pm_ops hid_sensor_pm_ops = {
> >  	SET_SYSTEM_SLEEP_PM_OPS(hid_sensor_suspend,
> > hid_sensor_resume)
> >  	SET_RUNTIME_PM_OPS(hid_sensor_suspend,
> > -			   hid_sensor_resume, NULL)
> > +			   hid_sensor_runtime_resume, NULL)
> >  };
> >  EXPORT_SYMBOL(hid_sensor_pm_ops);
> >  
> > diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-
> > sensor-hub.h
> > index c02b5ce..dd85f35 100644
> > --- a/include/linux/hid-sensor-hub.h
> > +++ b/include/linux/hid-sensor-hub.h
> > @@ -236,6 +236,7 @@ struct hid_sensor_common {
> >  	struct hid_sensor_hub_attribute_info report_state;
> >  	struct hid_sensor_hub_attribute_info power_state;
> >  	struct hid_sensor_hub_attribute_info sensitivity;
> > +	struct work_struct work;
> >  };
> >  
> >  /* Convert from hid unit expo to regular exponent */
> > 
> 
