From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] Input: Add driver for a generic ADC keypad
Date: Sun, 29 Mar 2015 22:07:38 -0700
Message-ID: <CAL1qeaEdUq8eyFB1H4mCrGSKc1a1CeJ4YaZHRVFW841wtTmcFA@mail.gmail.com>
References: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
	<1427503398-19682-2-git-send-email-abrestic@chromium.org>
	<5516B48C.4030003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5516B48C.4030003-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 28, 2015 at 7:02 AM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On 28/03/15 00:43, Andrew Bresticker wrote:
>> Add a polled input driver for a keypad in which the buttons are connected
>> in resistor ladders to an ADC.  The IIO framework is used to claim and
>> read the ADC channels.
>>
>> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

>> +static int adc_keypad_probe(struct platform_device *pdev)
>> +{
>> +     struct adc_keypad *keypad;
>> +     struct input_polled_dev *poll_dev;
>> +     struct input_dev *input;
>> +     unsigned int i;
>> +     int ret;
>> +
>> +     keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
>> +     if (!keypad)
>> +             return -ENOMEM;
>> +     keypad->dev = &pdev->dev;
>> +     platform_set_drvdata(pdev, keypad);
>> +
>> +     keypad->iio_chans = iio_channel_get_all(&pdev->dev);
>> +     if (IS_ERR(keypad->iio_chans)) {
>> +             dev_err(&pdev->dev, "Failed to get IIO channels: %ld\n",
>> +                     PTR_ERR(keypad->iio_chans));
>> +             return PTR_ERR(keypad->iio_chans);
>> +     }
>> +
>> +     i = 0;
>> +     while (keypad->iio_chans[i].channel != NULL)
>> +             i++;
>> +     keypad->num_chans = i;
>> +     keypad->chan_map = devm_kcalloc(&pdev->dev, keypad->num_chans,
>> +                                     sizeof(*keypad->chan_map), GFP_KERNEL);
>> +     if (!keypad->chan_map) {
>> +             ret = -ENOMEM;
>> +             goto put_chans;
>> +     }
>> +
>> +     ret = adc_keypad_of_parse(keypad);
>> +     if (ret < 0)
>> +             goto put_chans;
>> +
>> +     poll_dev = devm_input_allocate_polled_device(&pdev->dev);
>> +     if (!poll_dev) {
>> +             ret = -ENOMEM;
>> +             goto put_chans;
>> +     }
>> +     keypad->poll_dev = poll_dev;
>> +
>> +     poll_dev->private = keypad;
>> +     poll_dev->poll = adc_keypad_poll;
>> +     poll_dev->poll_interval = keypad->poll_interval;
>> +
>> +     input = poll_dev->input;
>> +     input->name = pdev->name;
>> +     input->phys = "adc-keys/input0";
>> +
>> +     input->id.bustype = BUS_HOST;
>> +     input->id.vendor = 0x0001;
>> +     input->id.product = 0x0001;
>> +     input->id.version = 0x0100;

> Why these particular values?

I just chose these because these are the values most other platform
input devices use, including gpio_keys and gpio_keys_polled.
