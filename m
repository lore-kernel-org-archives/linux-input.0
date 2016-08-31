From: Grant Likely <glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Wed, 31 Aug 2016 15:19:45 +0100
Message-ID: <CACxGe6s9Xo8wBbTsro7RZjtXp=30a9tz6sxKkT9TyQDmoO+Vwg@mail.gmail.com>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <b81da639-0ec5-bb30-1f77-b71d8e7ad434@secretlab.ca> <CACxGe6v6pDisF9FpKPJrojGS7qUn13xUUd-Uydr7B1701Y4szg@mail.gmail.com>
 <alpine.LNX.2.00.1608242313540.22028@cbobk.fhfr.pm> <4ab0f3f3-43e3-f815-dd7b-9f6aa0bf6833@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ab0f3f3-43e3-f815-dd7b-9f6aa0bf6833-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 24, 2016 at 10:23 PM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On 24/08/16 22:14, Jiri Kosina wrote:
>> On Wed, 24 Aug 2016, Grant Likely wrote:
>>
>>>>> v2:
>>>>> - Overview in documentation show analogy with usbhid implementation
>>>>> - sparse errors for statics. Also pointed by Jiri
>>>>> - Clearly marking exported function header file. Clean up all exports
>>>>> unused inteface functions
>>>>> - Changed to tristate from boolean as pointed by Jiri:
>>>>> this required remove/unload functions
>>>>> - Prevent crash when ISH enabled on non supported platform
>>>>> - Break client.c to smaller part by seprating buffer allocations
>>>>> - move bus register/unregister to ishtp module
>>>>> - There is only one config symbol INTEL_ISH_HID, removed silent
>>>>> config for TRANSPORT and IPC
>>>>
>>>> Tested-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>>>
>>>> On an HP Spectre x360 laptop using v4.7-rc5.
>>>
>>> Hey Srinivas. Any progress on this patch series?
>>
>> The HID part (with patch #5 omitted) should be in linux-next through
>> hid.git already.
>>
> The one IIO patch was pulled by Greg KH last night so hit linux next
> today.  Hence all on it's way by the sound of it!

Nice!

Unfortunately, I've just hit a new bug after updating to v4.8-rc4.
4.7.0-rc6 works fine.

The kernel boots, and the driver loads, but the orientations are
wrong. It appears that the X/Y is getting swapped:

Normal orientation: display rotated 90 degrees CW
Rotated 90 degrees CW: display normal orientation
Rotated 180 degrees (upside down): display rotated 90 degrees CCW
Rotated 90 degrees CCW: display rotated 180 degrees

Cheers,
g.
