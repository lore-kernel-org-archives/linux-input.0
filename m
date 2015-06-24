From: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Subject: Re: [RFC_v2 1/4] HID: hid-sony: Add basic IIO support for SixAxis
 Controller
Date: Wed, 24 Jun 2015 11:20:03 -0400
Message-ID: <d36d734164c9679d55d630893ace65a4.squirrel@mungewell.org>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org>
    <1435105830-2297-2-git-send-email-simon@mungewell.org>
    <20150624111343.9cbff925b0f25865fc6e5cd8@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150624111343.9cbff925b0f25865fc6e5cd8-qKGr9MkilAE@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ao2-qKGr9MkilAE@public.gmane.org>
Cc: Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_ACCEL:
>> +			*val = 0;	/* 9.80665/117 = 0.084540086 */
>> +			*val2 = 84540;
>
> I guess 9.80665 is 'g', but is the 117 taken from the accelerometer
> datasheet? What is it? And BTW I get 9.80665/117 = 0.083817521

The '117' was taken from experimentation, average value accessed across
all accelerometer axis on a stationary device.

It does appear however that I can not use a calculator ;-) (...must have
been a prior value left there).
Simon.
