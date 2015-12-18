From: Nish Aravamudan <nish.aravamudan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
Date: Thu, 17 Dec 2015 18:33:02 -0800
Message-ID: <CAOhV88Oqj+JrPsHqZmtmydUftSA9sUuCDErUOaAG_Erk+uDr1g@mail.gmail.com>
References: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
	<1450399868.5427.11.camel@linux.intel.com>
	<1450400312.5427.15.camel@intel.com>
	<CAOhV88OinTE31-qp1vh-4XHT-TqMTTOYwHiLk0yptg0prwetjw@mail.gmail.com>
	<1450400953.5427.18.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450400953.5427.18.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org" <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Shevchenko, Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 17, 2015 at 5:11 PM, Pandruvada, Srinivas
<srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, 2015-12-17 at 17:08 -0800, Nish Aravamudan wrote:
>> On Thu, Dec 17, 2015 at 5:00 PM, Pandruvada, Srinivas
>> <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> > Hi Andy,
>> >
>> > As per Nish these patches are impacting sensors on Yoga.
>> > https://lkml.org/lkml/2015/11/30/441
>>
>> To be clear, without that series, the touchpad and touchscreen on the
>> Yoga 900 don't work at all. So they are necessary for functioning. I
>> don't know (I will test it now), if removing the series makes the IIO
>> sensors work properly in /dev/.
> This is important to know before we take Andy's time.

It seems like Andy's patches are not the problem. That is, with stock
4.4-rc5, the accelerommeter /dev files still do not update.

-Nish
