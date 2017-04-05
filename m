From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH] HID: asus: support backlight on USB keyboards
Date: Wed, 5 Apr 2017 12:27:00 +0200
Message-ID: <CAL9uMOGetY_bXvqCGbkOWo_HXW_dTtXv=tZawBeWMhak1viHdg@mail.gmail.com>
References: <20170404175132.20498-1-carlo@caione.org> <20170405094110.GA4939@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170405094110.GA4939@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Carlo Caione <carlo@caione.org>, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 5, 2017 at 11:41 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Carlo,

[cut]
>> With this patch we create the usual 'asus::kbd_backlight' sysfs entry
>
> Please change 'sysfs' with 'led class' or this will mislead people into
> understanding that you are adding a custom sysfs entry.

Agree

[cut]
>> +static int asus_init_kbd(struct hid_device *hdev)
>> +{
>> +     int ret;
>> +     const unsigned char buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55,
>> +                                   0x53, 0x20, 0x54, 0x65, 0x63, 0x68, 0x2e,
>> +                                   0x49, 0x6e, 0x63, 0x2e, 0x00 };
>
> Do you have any hints in what this magical blob is?

Not for the init and the level control commands. I have some hints
about the configuration command.

>> +     unsigned char *dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
>> +
>> +     if (!dmabuf) {
>> +             ret = -ENOMEM;
>> +             hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
>
> No need to have an error if kzalloc fails. There will already one to be
> shout by kzalloc. Please remove all of those errors after
> kzalloc/kmemdup.
>> +             return ret;
>
> just return -ENOMEM.

Ok

[cut]
>> +     readbuf = kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);
>
> That's a lot of kzalloc/kmemdup/kfree. I wonder if you couldn't just
> prepare some buffers in asus_register_kbd_leds() and just reuse them.

I'll try this.

[cut]
>> +static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
>> +                                enum led_brightness brightness)
>> +{
>> +     struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
>> +                                              cdev);
>> +     led->brightness = brightness;
>> +     schedule_work(&led->work);
>
> If a worker is already happening, aren't we losing the last brightness
> setting?

Uhm, I don't see how. The brightness setting is used in
asus_kbd_backlight_work() and this is scheduled only here.
Am I missing anything?

> When unplugging the device, you should also make sure nobody queued an
> event and that you are not allowing anybody to schedule a new work (by
> unregistering the led class interface first or adding a guard.

Good point.

[cut]
>> +     drvdata->kbd_backlight = kzalloc(sizeof(struct asus_kbd_leds),
>> +                                      GFP_KERNEL);
>
> Unless I am mistaken, I do not see the matching kfree.
> Also note that the rest of the driver uses devres (devm_* functions) so
> for data that's allocated and which needs to stay during the entire life
> of the device, please use the devm API.

Yeah, I'll do. Thanks for noticing this.

[cut]
>> +     ret = led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);
>
> I do not see the matching led_classdev_unregister() call too. Note that
> there is also a devm_led_classdev_register() which might help you.

Ouch.

[cut]
>> +     if (drvdata->enable_backlight) {
>> +             if (asus_init_kbd(hdev))
>> +                     return 0;
>
> Returning success here (and in the other statements below) seems wrong.

The rationale here is that if anything goes wrong with backlight
initialization it's just ok to continue, not big deal.
We have already printed the error messages so the user is already
aware, but failing here because the keyboard light is broken seems
unnecessary.

>> +
>> +             ret = asus_get_kbd_functions(hdev, &kbd_func);
>> +             if (ret)
>> +                     return 0;
>
> I do not fully understand why you need to poll the keyboard for the
> functionality if you have a quirk for it. If it's mandatory to have
> functional backlight that's OK, but otherwise it does seem like waiting
> time.

The problem here is that not all the ASUS keyboard with that PID:VID
have the leds. So for such keyboard we would create a useless (and
probably confusing) sysfs entry for a non-existent backlight.
Otherwise we could do the opposite if you agree: delete the QUIRK and
just using this test to decide whether to create the led class or not.

>> +
>> +             if (kbd_func & SUPPORT_BKD_BACKLIGHT)
>> +                     asus_register_kbd_leds(hdev);
>
> Don't you need to check for the return value here?

As written before, I guess if we fail to register the leds it's just
ok to continue (given that we already printed the error message).

Cheers,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
