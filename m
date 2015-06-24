From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [RFC_v2 1/4] HID: hid-sony: Add basic IIO support for SixAxis Controller
Date: Wed, 24 Jun 2015 17:29:26 +0300
Message-ID: <CAEnQRZCE2XJJr9d9ieyQ4PdfdXNJfm4sAxjeVjHoWPfVBtW8ig@mail.gmail.com>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org>
	<1435105830-2297-2-git-send-email-simon@mungewell.org>
	<20150624111343.9cbff925b0f25865fc6e5cd8@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:35542 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbFXO32 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 10:29:28 -0400
In-Reply-To: <20150624111343.9cbff925b0f25865fc6e5cd8@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>

<snip>

>> +static const struct iio_info sony_iio_info = {
>> +     .read_raw = &sony_iio_read_raw,
>> +     .driver_module = THIS_MODULE,
>> +};
>> +
>> +static int sony_iio_probe(struct sony_sc *sc)
>> +{
>> +     struct hid_device *hdev = sc->hdev;
>> +     struct iio_dev *indio_dev;
>> +     struct sony_iio *data;
>> +     int ret;
>> +
>> +     indio_dev = iio_device_alloc(sizeof(*data));
>
> In general for new code the devm_ variants are preferred, but I am
> not sure in this case, maybe others have comments about that?
>
>> +     if (!indio_dev)
>> +             return -ENOMEM;
>> +
>> +     sc->indio_dev = indio_dev;
>> +     data = iio_priv(indio_dev);
>> +     data->sc = sc;
>> +
>> +     indio_dev->dev.parent = &hdev->dev;
>> +     indio_dev->name = dev_name(&hdev->dev);
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +     indio_dev->info = &sony_iio_info;
>> +     indio_dev->channels = sony_sixaxis_channels;
>> +     indio_dev->num_channels = 3;

Use ARRAY_SIZE(sony_sixaxis_channels) here.

>> +
>> +     ret = iio_device_register(indio_dev);
>
> if you used the devm_ variant here and in the other patches, the cleanup
> below and the sony_iio_remove() function could go away.
>
>> +     if (ret < 0) {
>> +             hid_err(hdev, "Unable to register iio device\n");
>> +             goto err;
>> +     }
>> +     return 0;
>> +
>> +err:
>> +     kfree(indio_dev);

Not to mention that the correct way to free an iio_dev is iio_device_free.

>> +     sc->indio_dev = NULL;
>> +     return ret;
>> +}
>> +
>> +static void sony_iio_remove(struct sony_sc *sc)
>> +{
>> +     if (!sc->indio_dev)
>> +             return;
>> +
>> +     iio_device_unregister(sc->indio_dev);
>> +     kfree(sc->indio_dev);
The same here.

>> +     sc->indio_dev = NULL;
>> +}

So, better use the devm_ variant at least for indio_dev allocation.

thanks,
Daniel.
