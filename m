From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Thu, 29 Aug 2013 12:47:30 -0700
Message-ID: <CAGXu5j+8PEBA5MCeSPMofBRPkb0pXJ2ce_x5rGY98kojTdx8Xg@mail.gmail.com>
References: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz>
	<521E60CE.6050000@linux.intel.com>
	<alpine.LNX.2.00.1308282241270.22181@pobox.suse.cz>
	<CAGXu5jL2vrO5NR+Bm+HeWa0WihwN4nAr5b=Fga9QE8WW2Wjt6w@mail.gmail.com>
	<521F8F3A.7050002@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:53729 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab3H2Tra (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 15:47:30 -0400
Received: by mail-ie0-f176.google.com with SMTP id s9so1574782iec.21
        for <linux-input@vger.kernel.org>; Thu, 29 Aug 2013 12:47:30 -0700 (PDT)
In-Reply-To: <521F8F3A.7050002@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, srinivas pandruvada <srinivas.pandruvada@intel.com>

On Thu, Aug 29, 2013 at 11:13 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On 08/28/2013 02:16 PM, Kees Cook wrote:
>>
>> On Wed, Aug 28, 2013 at 1:42 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>>>
>>> On Wed, 28 Aug 2013, Srinivas Pandruvada wrote:
>>>
>>>>> A HID device could send a malicious feature report that would cause the
>>>>> sensor-hub HID driver to read past the end of heap allocation, leaking
>>>>> kernel memory contents to the caller.
>>>>>
>>>>> CVE-2013-2898
>>>>>
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> Cc: stable@kernel.org
>>>>> ---
>>>>>    drivers/hid/hid-sensor-hub.c |    3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hid/hid-sensor-hub.c
>>>>> b/drivers/hid/hid-sensor-hub.c
>>>>> index ca749810..aa34755 100644
>>>>> --- a/drivers/hid/hid-sensor-hub.c
>>>>> +++ b/drivers/hid/hid-sensor-hub.c
>>>>> @@ -221,7 +221,8 @@ int sensor_hub_get_feature(struct
>>>>> hid_sensor_hub_device
>>>>> *hsdev, u32 report_id,
>>>>>              mutex_lock(&data->mutex);
>>>>>      report = sensor_hub_report(report_id, hsdev->hdev,
>>>>> HID_FEATURE_REPORT);
>>>>> -   if (!report || (field_index >=  report->maxfield)) {
>>>>> +   if (!report || (field_index >=  report->maxfield) ||
>>>>> +       report->field[field_index]->report_count < 1) {
>>>>
>>>> Is it based on some HID device is sending junk report or just from a
>>>> code
>>>> review?
>>>
>>> My understanding is that this whole Kees' patchset is about potentially
>>> evil devices doing bad things (on purpose).
>>
>> Correct, though this particular flaw is pretty weak. It requires both
>> malicious device and malicious user-space. However, with the advent of
>> things like HTML5 USB API, it's possible these could be combined to
>> attack a device.
>>
>> Regardless, this fix seems obviously correct and trivial to me.
>
> Agree fix is simple, but the malicious feature report can contains other
> junk also. Can we really address all such issues?

I certainly hope so! :) It should be possible to range check all
usages. We just need to examine the code closely.

-Kees

>>>>>
>>>>>              ret = -EINVAL;
>>>>>              goto done_proc;
>>>>>      }
>>>>
>>>> Thanks,
>>>> Srinivas
>>>>
>>> --
>>> Jiri Kosina
>>> SUSE Labs
>>
>>
>> Thanks,
>
> Srinivas
>



-- 
Kees Cook
Chrome OS Security
