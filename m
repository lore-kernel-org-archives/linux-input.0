From: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v5] input: tablet: add Pegasus Notetaker tablet driver
Date: Sat, 28 May 2016 12:37:47 +0200
Message-ID: <574974FB.7070308@posteo.de>
References: <1464342381-2939-1-git-send-email-martink@posteo.de>
 <20160527215907.GD25540@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160527215907.GD25540@dtor-ws>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks again for your help! Only one comment below...

Am 2016-05-27 um 23:59 schrieb Dmitry Torokhov:
> Hi Martin,
> 

>> +static void pegasus_parse_packet(struct pegasus *pegasus)
>> +{
>> +	unsigned char *data = pegasus->data;
>> +	struct input_dev *dev = pegasus->dev;
>> +	u16 x, y;
>> +
>> +	switch (data[0]) {
>> +	case SPECIAL_COMMAND:
>> +		/* device button pressed */
>> +		if (data[1] == BUTTON_PRESSED)
>> +			schedule_work(&pegasus->init);
>> +
>> +		break;
>> +	/* xy data */
>> +	case BATTERY_LOW:
>> +		dev_warn_once(&dev->dev, "Pen battery low\n");
>> +	case BATTERY_NO_REPORT:
>> +	case BATTERY_GOOD:
>> +		x = le16_to_cpup((__le16 *)&data[2]);
>> +		y = le16_to_cpup((__le16 *)&data[4]);
>> +
>> +		/* ignore pen up events */
>> +		if (x == 0 && y == 0)
> 
> Why are we ignoring pen-up events? I'd at least send
> EV_KEY/BTN_TOOL_PEN/0 and maybe the rest of BTN* events.

I tried a few things, but I found them not to be useful in our case. To
the contrary, they seem to happen at random (or wrongly) too. They seem
to be there to seperate lines in drawings or whatever, but I'm not sure
exactly when they are valuable.

As an input device I get the best user experience when we ignore them. I
don't want them to break "clicking" or the like.
