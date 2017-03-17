From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Report slot as inactive when
 contact is a palm
Date: Thu, 16 Mar 2017 17:52:07 -0700
Message-ID: <472ff54e-34c3-0df9-f4fd-2340979a6c3d@synaptics.com>
References: <1489708591-4320-1-git-send-email-aduggan@synaptics.com>
 <20170317000450.GE2935@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317000450.GE2935@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Cameron Gutman <aicommander@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

On 03/16/2017 05:04 PM, Dmitry Torokhov wrote:
> On Thu, Mar 16, 2017 at 04:56:31PM -0700, Andrew Duggan wrote:
>> When the firmware identifies a contact as a palm the driver sets the tool
>> type to MT_TOOL_PALM, but sets the slot state as active. Reporting the
>> palm as active results in userspace input libraries considering the palm
>> as a valid contact. Touchpads which previously were using hid-multitouch
>> are now not suppressing palms when switching to the RMI4 driver. This
>> change fixes palm rejection when using the RMI4 driver.
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> Tested-by: Cameron Gutman <aicommander@gmail.com>
>> ---
>>   drivers/input/rmi4/rmi_2d_sensor.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
>> index 8bb866c..8d1f295 100644
>> --- a/drivers/input/rmi4/rmi_2d_sensor.c
>> +++ b/drivers/input/rmi4/rmi_2d_sensor.c
>> @@ -80,7 +80,8 @@ void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
>>   		input_mt_slot(input, slot);
>>   
>>   	input_mt_report_slot_state(input, obj->mt_tool,
>> -				   obj->type != RMI_2D_OBJECT_NONE);
>> +				   (obj->type != RMI_2D_OBJECT_NONE)
>> +				   && (obj->type != RMI_2D_OBJECT_PALM));
>>   
>>   	if (obj->type != RMI_2D_OBJECT_NONE) {
>>   		obj->x = sensor->tracking_pos[slot].x;
> If we are relying on hardware to do palm rejection, then we should not
> be reporting the rest of the events for palm either (i.e. the condition
> in the if statement above should also be updated).
>
> But I do not understand why userspace doe snot do the right thing? Yes,
> the slot is active, but reported contact type is MT_TOOL_PALM, so it
> knows what it deals with.
>
> Thanks.
>
My intent is to notify userspace that there is a palm present. But, if 
userspace does not have code which explicitly handles the MT_TOOL_PALM 
type it won't be considered a finger. I think it is only recently that 
drivers have started reporting MT_TOOL_PALM to userspace so I'm not sure 
if libraries like libinput make use of it yet.

Starting with v4.11 some touchpads will be switching from hid-multitouch 
to the RMI4 driver and reporting palms as active results in unsuppressed 
palms. I want to avoid users from upgrading and experiencing a 
degradation in usability. In which case I can update the if statement 
and resubmit. This is basically how hid-multitouch is handling it. Maybe 
in the future we can add a parameter to enable reporting palms to userspace.

Andrew
