From: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 3/3] iio: light: apple-ib-als: Add driver for ALS on
 iBridge chip.
Date: Wed, 24 Apr 2019 13:27:25 +0100
Message-ID: <20190424132725.00007633@huawei.com>
References: <20190422031251.11968-1-ronald@innovation.ch>
        <20190422031251.11968-4-ronald@innovation.ch>
        <alpine.DEB.2.21.1904221101420.964@vps.pmeerw.net>
        <20190422130138.336fb227@archlinux>
        <20190423103855.GB12528@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423103855.GB12528@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 23 Apr 2019 03:38:55 -0700
"Life is hard, and then you die" <ronald@innovation.ch> wrote:

>   Hi Jonathan, Peter,
> 
> On Mon, Apr 22, 2019 at 01:01:38PM +0100, Jonathan Cameron wrote:
> > On Mon, 22 Apr 2019 11:17:27 +0200 (CEST)
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> >   
> > > On Sun, 21 Apr 2019, Ronald Tschalär wrote:
> > >   
> > > > On 2016/2017 MacBook Pro's with a Touch Bar the ALS is attached to,
> > > > and exposed via the iBridge device. This provides the driver for that
> > > > sensor.    
> > > 
> > > some comments below inline  
> > I'll 'nest' on Peter's review to avoid repetition.
> > 
> > A few additional comments inline.  
> 
> Thank you both for your reviews. I've applied most of your
> suggestions, so I'm limiting my responses below to just those places
> where I need further clarification or can provide some answers.
> 
> [snip]
> > > > +static int appleals_read_raw(struct iio_dev *iio_dev,
> > > > +			     struct iio_chan_spec const *chan,
> > > > +			     int *val, int *val2, long mask)
> > > > +{
> > > > +	struct appleals_device *als_dev =
> > > > +				*(struct appleals_device **)iio_priv(iio_dev);
> > > > +	__s32 value;
> > > > +	int rc;
> > > > +
> > > > +	*val = 0;
> > > > +	*val2 = 0;    
> > > 
> > > no need to set these here
> > >   
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +	case IIO_CHAN_INFO_PROCESSED:
> > > > +		*val = appleals_get_field_value(als_dev, als_dev->illum_field);  
> > 
> > How can one read by both processed and raw?  
> 
> From my understanding, processed is a converted and normalized value
> of raw? But since the raw value is already in Lux the processed value
> is then the same. Furthermore, looking at userspace apps that read
> these values (e.g. iio-sensor-proxy, lightsd) they seem to be all over
> the map in terms of what sysfs entries they read:
> in_illuminance_input, in_intensity_both_raw, etc. So I figured
> providing both would provide maximal compatibility.
> 
> What then is currently the preferred approach here?

Just provide the processed value.  We may have to fix any userspace apps
that aren't checking both.  For the raw version they should be applying the
scale in userspace.

> 
> > > > +	case IIO_CHAN_INFO_HYSTERESIS:
> > > > +		if (val == APPLEALS_DYN_SENS) {
> > > > +			if (als_dev->cur_hysteresis != APPLEALS_DYN_SENS) {
> > > > +				als_dev->cur_hysteresis = val;
> > > > +				illum = appleals_get_field_value(als_dev,
> > > > +							als_dev->illum_field);
> > > > +				appleals_update_dyn_sensitivity(als_dev, illum);  
> > 
> > There is some debate in another thread on whether dynamic sensitivity can be
> > mapped to hysteresis or not...  
> 
> Is that the "drivers: iio: Add more data field for iio driver
> hysteresis parsing" thread?

That's the one.

> 
> In any case, I'm using the value 0 here to indicate that the
> pseudo-percent-relative change sensitivity should be used. Better
> suggestions certainly welcome.

It seems we are converging on a new IIO_CHAN_INFO type for sensitivity.

> 
> [snip]
> > > > +static const struct iio_chan_spec appleals_channels[] = {
> > > > +	{
> > > > +		.type = IIO_INTENSITY,
> > > > +		.modified = 1,
> > > > +		.channel2 = IIO_MOD_LIGHT_BOTH,
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > > > +			BIT(IIO_CHAN_INFO_RAW),  
> > Why return both processed and raw?  We don't generally allow that in IIO
> > (there are a few historical exceptions due to us getting it wrong the
> > first time).  
> 
> Ok. But which should be used then, especially in view of the fact that
> different user-space apps/daemons appear to use different values?
 forwards.

> 
> [snip]
> > > > +static int appleals_config_iio(struct appleals_device *als_dev)  
> [snip]
> > > > +	iio_dev = iio_device_alloc(sizeof(als_dev));    
> > > 
> > > how about using the devm_ variants?  
> 
> The problem is that there is no device with the proper lifetime here.
> In particular we can't use hid_device (the only struct device
> available here) because the instances of those can (and do) outlive
> the module. This is a consequence of the hid-driver demuxing: e.g.
> when this als module is unloaded, the hid_device is still in use by
> the touchbar driver, and if this als module is then loaded again it
> will get associated with that same hid_device again.
Fair enough.

> 
> [snip]
> > > > +	rc = iio_device_register(iio_dev);
> > > > +	if (rc) {
> > > > +		dev_err(als_dev->log_dev, "failed to register iio device: %d\n",
> > > > +			rc);
> > > > +		goto unreg_iio_trig;
> > > > +	}
> > > > +
> > > > +	als_dev->iio_dev = iio_dev;  
> > 
> > I really don't like nest of pointers going on in here.  I haven't dug
> > down to check if any of them can be remove, but they are definitely
> > ugly to deal with.  
> 
> I'm not sure how this can be avoided: *iio_dev is allocated by
> iio_device_alloc(), and this is just storing that pointer in our data
> structure for this als device.

You are probably correct.  Ugly will have to stay :(
This tends to happen when we end up merging various different
driver subsystems together like this.

> 
> [snip]
> > > > +static int appleals_probe(struct hid_device *hdev,
> > > > +			  const struct hid_device_id *id)
> > > > +{
> > > > +	struct appleals_device *als_dev =
> > > > +		appleib_get_drvdata(hid_get_drvdata(hdev),
> > > > +				    &appleals_hid_driver);
> > > > +	struct hid_field *state_field;
> > > > +	struct hid_field *illum_field;
> > > > +	int rc;
> > > > +
> > > > +	/* find als fields and reports */
> > > > +	state_field = appleib_find_hid_field(hdev, HID_USAGE_SENSOR_ALS,
> > > > +					    HID_USAGE_SENSOR_PROP_REPORT_STATE);
> > > > +	illum_field = appleib_find_hid_field(hdev, HID_USAGE_SENSOR_ALS,
> > > > +					     HID_USAGE_SENSOR_LIGHT_ILLUM);
> > > > +	if (!state_field || !illum_field)
> > > > +		return -ENODEV;
> > > > +
> > > > +	if (als_dev->hid_dev) {
> > > > +		dev_warn(als_dev->log_dev,
> > > > +			 "Found duplicate ambient light sensor - ignoring\n");  
> > 
> > I'll bite.  So how can this actually happen?  What fundamentally breaks in
> > your model if there really are two?  Can you fix whatever that is so
> > as to drop this handling?  
> 
> This should indeed never happen - the check is just defensive
> programming, in case either some new device in some new model appears,
> or due to some bug somewhere.
> 
> To actually handle this I'd need to split up appleals_device into a
> per iBridge-device part and a per ALS-device part, and allow multiple
> ALS-device parts. This is certainly doable, but seemed a bit overkill
> for something that is unlikely to ever be needed.

Fair enough I guess.

> 
> [snip]
> > > > +static void appleals_remove(struct hid_device *hdev)
> > > > +{
> > > > +	struct appleals_device *als_dev =
> > > > +		appleib_get_drvdata(hid_get_drvdata(hdev),
> > > > +				    &appleals_hid_driver);
> > > > +    
> > > 
> > > could be a lot less if devm_ were used?  
> 
> Agreed, but see explanation above of why this can't be used.
> 
> > > > +	if (als_dev->iio_dev) {
> > > > +		iio_device_unregister(als_dev->iio_dev);
> > > > +
> > > > +		iio_trigger_unregister(als_dev->iio_trig);
> > > > +		iio_trigger_free(als_dev->iio_trig);
> > > > +		als_dev->iio_trig = NULL;  
> > 
> > I would be decidedly worried if you actually have any paths
> > where setting these to NULL do anything useful. By the time
> > we get here we should absolutely 'know' nothing will touch
> > these pointers.  
> 
> I guess I was being overly paranoid here. I've removed these now.
> 
> > It is these that are blocking Peter's suggestion of using
> > devm to clean all of this up automatically for you.  
> 
> No, that is for a different reason - see above.
> 
> [snip]
> > > > +static int appleals_platform_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct appleib_platform_data *pdata = pdev->dev.platform_data;
> > > > +	struct appleib_device *ib_dev = pdata->ib_dev;
> > > > +	struct appleals_device *als_dev;
> > > > +	int rc;
> > > > +
> > > > +	als_dev = kzalloc(sizeof(*als_dev), GFP_KERNEL);
> > > > +	if (!als_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	als_dev->ib_dev = ib_dev;
> > > > +	als_dev->log_dev = pdata->log_dev;
> > > > +
> > > > +	rc = appleib_register_hid_driver(ib_dev, &appleals_hid_driver, als_dev);  
> > 
> > Hmm. This is all a bit odd.  We register a platform device, to call it's driver
> > so that it can then register another driver?  I'll let Lee comment on that but
> > it does seem overly complex.  
> 
> "Normally" this call would be to hid_register_driver().

> However, as I
> tried to explain in the cover letter and module comments, at least one
> of the hid_device's needs to be shared by both this als driver and the
> touchbar driver. But the linux device/driver architecture does not
> allow multiple drivers to be attached to a single device. Hence the
> mfd driver implements demuxing hid_driver that allows multiple
> hid_drivers to be registered for a single hid_device. And this is why
> we register our hid_driver with this demuxing driver here instead of
> directly via hid_register_driver().

I'd expect a probe to create a device managed by the driver.  The drive would normally
be registered on module load, hence _init, rather than probe.

I can't find any instances of hid_register_driver being called from a probe function.

Jonathan


> 
> Does this make sense?
> 
> 
>   Cheers,
> 
>   Ronald
> 
