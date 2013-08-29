From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Thu, 29 Aug 2013 11:13:14 -0700
Message-ID: <521F8F3A.7050002@linux.intel.com>
References: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz> <521E60CE.6050000@linux.intel.com> <alpine.LNX.2.00.1308282241270.22181@pobox.suse.cz> <CAGXu5jL2vrO5NR+Bm+HeWa0WihwN4nAr5b=Fga9QE8WW2Wjt6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9691 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755998Ab3H2SGb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 14:06:31 -0400
In-Reply-To: <CAGXu5jL2vrO5NR+Bm+HeWa0WihwN4nAr5b=Fga9QE8WW2Wjt6w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, srinivas pandruvada <srinivas.pandruvada@intel.com>

On 08/28/2013 02:16 PM, Kees Cook wrote:
> On Wed, Aug 28, 2013 at 1:42 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Wed, 28 Aug 2013, Srinivas Pandruvada wrote:
>>
>>>> A HID device could send a malicious feature report that would cause the
>>>> sensor-hub HID driver to read past the end of heap allocation, leaking
>>>> kernel memory contents to the caller.
>>>>
>>>> CVE-2013-2898
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> Cc: stable@kernel.org
>>>> ---
>>>>    drivers/hid/hid-sensor-hub.c |    3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
>>>> index ca749810..aa34755 100644
>>>> --- a/drivers/hid/hid-sensor-hub.c
>>>> +++ b/drivers/hid/hid-sensor-hub.c
>>>> @@ -221,7 +221,8 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device
>>>> *hsdev, u32 report_id,
>>>>              mutex_lock(&data->mutex);
>>>>      report = sensor_hub_report(report_id, hsdev->hdev,
>>>> HID_FEATURE_REPORT);
>>>> -   if (!report || (field_index >=  report->maxfield)) {
>>>> +   if (!report || (field_index >=  report->maxfield) ||
>>>> +       report->field[field_index]->report_count < 1) {
>>> Is it based on some HID device is sending junk report or just from a code
>>> review?
>> My understanding is that this whole Kees' patchset is about potentially
>> evil devices doing bad things (on purpose).
> Correct, though this particular flaw is pretty weak. It requires both
> malicious device and malicious user-space. However, with the advent of
> things like HTML5 USB API, it's possible these could be combined to
> attack a device.
>
> Regardless, this fix seems obviously correct and trivial to me.
Agree fix is simple, but the malicious feature report can contains other 
junk also. Can we really address all such issues?
>>>>              ret = -EINVAL;
>>>>              goto done_proc;
>>>>      }
>>> Thanks,
>>> Srinivas
>>>
>> --
>> Jiri Kosina
>> SUSE Labs
>
> Thanks,
Srinivas

