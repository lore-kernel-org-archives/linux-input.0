From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
Date: Thu, 17 Dec 2015 17:08:40 -0800
Message-ID: <CAOhV88OinTE31-qp1vh-4XHT-TqMTTOYwHiLk0yptg0prwetjw@mail.gmail.com>
References: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
	<1450399868.5427.11.camel@linux.intel.com>
	<1450400312.5427.15.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450400312.5427.15.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "jic23@kernel.org" <jic23@kernel.org>, "cmo@melexis.com" <cmo@melexis.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 17, 2015 at 5:00 PM, Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> Hi Andy,
>
> As per Nish these patches are impacting sensors on Yoga.
> https://lkml.org/lkml/2015/11/30/441

To be clear, without that series, the touchpad and touchscreen on the
Yoga 900 don't work at all. So they are necessary for functioning. I
don't know (I will test it now), if removing the series makes the IIO
sensors work properly in /dev/.

-Nish

> On Thu, 2015-12-17 at 16:51 -0800, Srinivas Pandruvada wrote:
>> On Thu, 2015-12-17 at 15:38 -0800, Nish Aravamudan wrote:
>> > [Starting a new thread from https://lkml.org/lkml/2015/12/15/663,
>> > as
>> > now my laptop is displaying values in the sysfs *raw* files.]
>> >
>> > So I'm trying to understand exactly how the hid-sensor-accel-3d
>> > driver works.
>> >
>> > If I turn up debugging, when I `cat
>> > /sys/bus/iio/devices/device*/*raw*`, I see "iio iio:device3:
>> > accel_3d_proc_event" and I think that means that
>> > hid_sensor_push_data() is getting called.
>> >
>> > But read()'s on /dev/iio:device3 never produces anything, which is
>> > what iio-sensor-proxy uses to translate events to dbus.
>> >
>> > Is it expected that the dev-node is "silent"? Just trying to
>> > understand if an extension to the driver to support a chardev based
>> > output is appropriate, or if iio-sensor-proxy needs to be changed
>> > to
>> > handle this device.
>>
>> You are saying there is some regression. This used to work and now it
>> doesn't work. Is raw values are displayed correctly, when you do
>> "cat"?
>> If cat of raw values is working then power on of sensors is working.
>>
>> Turn on HID debug prints. If it is regression we can do git bisect.
>> Any ACPI or PM changes can break this. Usually there will be GPIOs
>> which will be involved in power on, where ACPI comes into play. This
>> will be done by i2c-hid. There are some prints in i2c-hid which can
>> be
>> enabled also.
>>
>> Thanks,
>> Srinivas
>>
>> >
