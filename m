From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: hid-input: allow input_configured callback return errors
Date: Mon, 28 Sep 2015 12:10:36 +0200
Message-ID: <CANq1E4SgM7ga9_gLg-Ysi+ki_TKyMogiHcJ5toKZBS+h7Nd8nA@mail.gmail.com>
References: <20150925231451.GA40951@dtor-ws>
	<CANq1E4SjLUWinuNzBN7MNSgEQTLsfFK-t-OqGXmnkN1X1bJ0Vg@mail.gmail.com>
	<20150928002328.GB17818@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150928002328.GB17818@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Jaikumar Ganesh <jaikumarg@android.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, James C Boyd <jcboyd.dev@gmail.com>, Karl Relton <karllinuxtest.relton@ntlworld.com>, Olivier Gay <ogay@logitech.com>, Ross Skaliotis <rskaliotis@gmail.com>, Jamie Lentin <jm@lentin.co.uk>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andreas Fleig <andreasfleig@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Peter Wu <peter@lekensteyn.nl>, Goffredo Baroncelli <kreijack@inwind.it>, Mathieu Magnaudet <mathieu.magnaudet@gmail.com>, Brent Adam <brentadamdev@gmail.com>, Yang Bo <linuxsea@163.com>, Seth Forshee <seth.forshee@canonical.com>, Andrew Duggan <aduggan@synaptics.com>, Dan Carpenter <dan.carpenter@oracle.com>, Frank Praznik <frank.praz>
List-Id: linux-input@vger.kernel.org

Hi

On Mon, Sep 28, 2015 at 2:23 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
[...]
>>
>> >  }
>> >
>> >  static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>
>> [snip]
>>
>> > diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
>> > index 2c14812..33280f3 100644
>> > --- a/drivers/hid/hid-rmi.c
>> > +++ b/drivers/hid/hid-rmi.c
>> > @@ -1173,7 +1173,7 @@ static int rmi_populate(struct hid_device *hdev)
>> >         return 0;
>> >  }
>> >
>> > -static void rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
>> > +static int rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
>> >  {
>> >         struct rmi_data *data = hid_get_drvdata(hdev);
>> >         struct input_dev *input = hi->input;
>> > @@ -1185,10 +1185,10 @@ static void rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
>> >         hid_dbg(hdev, "Opening low level driver\n");
>> >         ret = hid_hw_open(hdev);
>> >         if (ret)
>> > -               return;
>> > +               return ret;
>> >
>> >         if (!(data->device_flags & RMI_DEVICE))
>> > -               return;
>> > +               return -ENXIO;
>> >
>> >         /* Allow incoming hid reports */
>> >         hid_device_io_start(hdev);
>> > @@ -1228,7 +1228,9 @@ static void rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
>> >         input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 0x0f, 0, 0);
>> >         input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 0x0f, 0, 0);
>> >
>> > -       input_mt_init_slots(input, data->max_fingers, INPUT_MT_POINTER);
>> > +       ret = input_mt_init_slots(input, data->max_fingers, INPUT_MT_POINTER);
>> > +       if (ret < 0)
>> > +               goto exit;
>> >
>> >         if (data->button_count) {
>> >                 __set_bit(EV_KEY, input->evbit);
>> > @@ -1244,6 +1246,7 @@ static void rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
>> >  exit:
>> >         hid_device_io_stop(hdev);
>> >         hid_hw_close(hdev);
>> > +       return ret;
>>
>> rmi_probe() has an explicit comment that it *wants* hid_probe() to
>> continue on failure, to make sure hidraw is loaded. Not sure what to
>> make with that, but please either remove the comment in rmi_probe() or
>> make sure to always return 0 from rmi_input_configured().
>
> I think that comment is erroneous since the fact that we could not
> attach hidinput interface should not affect hidraw in any shape or form.

The comment might indeed be correct. If rmi_input_configured() failed,
probing is continued, but the device-internal state might be
different. rmi_probe() checks that, and explicitly continues device
probing in that case (if it didn't, the device would indeed be
rejected).

Sorry for the confusion. Your changes to rmi do look correct.

Thanks
David
