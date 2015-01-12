From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute
 read
Date: Mon, 12 Jan 2015 21:24:00 +0000
Message-ID: <54B43B70.4070501@kernel.org>
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420656483-7093-3-git-send-email-srinivas.pandruvada@linux.intel.com> <54B1AAD6.6070303@kernel.org> <54B30286.7090106@linux.intel.com> <54B30610.3070907@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54B30610.3070907-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 11/01/15 23:24, Srinivas Pandruvada wrote:
> 
> On 01/11/2015 03:08 PM, Srinivas Pandruvada wrote:
>>
>> On 01/10/2015 02:42 PM, Jonathan Cameron wrote:
>>> On 07/01/15 18:47, Srinivas Pandruvada wrote:
>>>> The new API added a flag for sync/async mode. Added sync mode flag.
>>>>
>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> Again, please don't break the build between patches like this.
>> As we did in the past, the hid sensor hub patches involving hid sensor and IIO part goes through one tree, either via IIO or HID.
>> So once acked this needs to go through a single tree, as done in the past.
>> So the patches submitted in a series to avoid breaking build.
>>
> Ignore this comment.
> Is this not a common procedure for API change? Single patch touching various subsystem, will be more difficult to apply.
Take one more step in doing it.
First you introduce a new function with the arguments changed
as you like.

Second you move all calls over to the new function.

Third you kill off the old function - sometimes you also do an easily
verified rename of all functions at once.

How the last patch gets applied is rather dependent on what it touches.
If just a couple of subsystems, then the maintainers tend to agree on who
is taking the series and if useful they create an immutable branch which
can then be pulled into any trees that need the change.  Doesn't matter
who ends up sending the pull request to Linus as Git will sort it all out.

If it's really kernel wide, then you need to get in touch with Linus.
Typically these are done at very specific points in the merge cycle - often
either just before or just after rc1 I think.

Rafael did one of these whilst changing some stuff with power management
kconfig dependencies in the last cycle.  It bit me because I was
running a couple of months behind mainline, but mostly it went in
without causing trouble.

Here, I'd probably just Ack the series and let Jiri pick it up and
keep a vague eye open for possible merge conflicts later in the cycle.


Jonathan
> 
> 
>> Thanks,
>> Srinivas
>>>
>>> If you want to do things in steps, you'll have to carry to versions of
>>> the function during the conversion and drop the unwanted one at the end.
>>>
>>>> ---
>>>>   drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
>>>> index d5d9531..0085c2f 100644
>>>> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
>>>> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
>>>> @@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>>>>               *val = sensor_hub_input_attr_get_raw_value(
>>>>                       accel_state->common_attributes.hsdev,
>>>>                       HID_USAGE_SENSOR_ACCEL_3D, address,
>>>> -                    report_id);
>>>> +                    report_id,
>>>> +                    SENSOR_HUB_SYNC);
>>>>           else {
>>>>               *val = 0;
>>>> hid_sensor_power_state(&accel_state->common_attributes,
>>>>
>>>
>>
> 
