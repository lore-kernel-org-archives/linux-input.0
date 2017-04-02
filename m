From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Report slot as inactive when
 contact is a palm
Date: Sun, 2 Apr 2017 13:18:39 +0200
Message-ID: <75fab66e-11f2-253b-9cdd-f697f2c01d3d@leemhuis.info>
References: <1489708591-4320-1-git-send-email-aduggan@synaptics.com>
 <20170317000450.GE2935@dtor-ws>
 <472ff54e-34c3-0df9-f4fd-2340979a6c3d@synaptics.com>
 <20170317210010.GB26166@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317210010.GB26166@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Cameron Gutman <aicommander@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

Andrew, what's the status of this? This looks stalled, but it is a
regression in 4.11 afaics. That's why I added this thread to the list of
regressions for Linux 4.11. I'll try to watch this thread for further
updates on this issue to document progress in my weekly reports. Please
let me know in case the discussion moves to a different place (bugzilla
or another mail thread for example). tia!

Ciao, Thorsten (who wears his regression tracker hat in this case; as it
happens he also owns a device where people noticed this problem)


On 17.03.2017 22:00, Dmitry Torokhov wrote:
> On Thu, Mar 16, 2017 at 05:52:07PM -0700, Andrew Duggan wrote:
>> On 03/16/2017 05:04 PM, Dmitry Torokhov wrote:
>>> On Thu, Mar 16, 2017 at 04:56:31PM -0700, Andrew Duggan wrote:
>>>> When the firmware identifies a contact as a palm the driver sets the tool
>>>> type to MT_TOOL_PALM, but sets the slot state as active. Reporting the
>>>> palm as active results in userspace input libraries considering the palm
>>>> as a valid contact. Touchpads which previously were using hid-multitouch
>>>> are now not suppressing palms when switching to the RMI4 driver. This
>>>> change fixes palm rejection when using the RMI4 driver.
>>>>
>>>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>>>> Tested-by: Cameron Gutman <aicommander@gmail.com>
>>>> ---
>>>>  drivers/input/rmi4/rmi_2d_sensor.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
>>>> index 8bb866c..8d1f295 100644
>>>> --- a/drivers/input/rmi4/rmi_2d_sensor.c
>>>> +++ b/drivers/input/rmi4/rmi_2d_sensor.c
>>>> @@ -80,7 +80,8 @@ void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
>>>>  		input_mt_slot(input, slot);
>>>>  	input_mt_report_slot_state(input, obj->mt_tool,
>>>> -				   obj->type != RMI_2D_OBJECT_NONE);
>>>> +				   (obj->type != RMI_2D_OBJECT_NONE)
>>>> +				   && (obj->type != RMI_2D_OBJECT_PALM));
>>>>  	if (obj->type != RMI_2D_OBJECT_NONE) {
>>>>  		obj->x = sensor->tracking_pos[slot].x;
>>> If we are relying on hardware to do palm rejection, then we should not
>>> be reporting the rest of the events for palm either (i.e. the condition
>>> in the if statement above should also be updated).
>>>
>>> But I do not understand why userspace doe snot do the right thing? Yes,
>>> the slot is active, but reported contact type is MT_TOOL_PALM, so it
>>> knows what it deals with.
>>>
>>> Thanks.
>>>
>> My intent is to notify userspace that there is a palm present.
> 
> It is not going to work though. Here is input_mt_report_slot_state:
> 
> void input_mt_report_slot_state(struct input_dev *dev,
> 				unsigned int tool_type, bool active)
> {
> 	struct input_mt *mt = dev->mt;
> 	struct input_mt_slot *slot;
> 	int id;
> 
> 	if (!mt)
> 		return;
> 
> 	slot = &mt->slots[mt->slot];
> 	slot->frame = mt->frame;
> 
> 	if (!active) {
> 		input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, -1);
> 		return;
> 	}
> 
> 	id = input_mt_get_value(slot, ABS_MT_TRACKING_ID);
> 	if (id < 0 || input_mt_get_value(slot, ABS_MT_TOOL_TYPE) != tool_type)
> 		id = input_mt_new_trkid(mt);
> 
> 	input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, id);
> 	input_event(dev, EV_ABS, ABS_MT_TOOL_TYPE, tool_type);
> }
> 
> As you can see, if contact is inactive, then we do not send tool type to
> the userspace, but simply say that the slot is no longer valid. So by
> doing what your patch is doing you completely suppress the contact.
> 
> 
>> But,
>> if userspace does not have code which explicitly handles the
>> MT_TOOL_PALM type it won't be considered a finger. I think it is
>> only recently that drivers have started reporting MT_TOOL_PALM to
>> userspace so I'm not sure if libraries like libinput make use of it
>> yet.
> 
> They either will use it, or they will treat it as a [hopefully] large
> finger and [hopefully] they will have some rejection for large contacts
> anyway, even if they are not classified by hardware as "palm".
> 
>>
>> Starting with v4.11 some touchpads will be switching from
>> hid-multitouch to the RMI4 driver and reporting palms as active
>> results in unsuppressed palms. I want to avoid users from upgrading
>> and experiencing a degradation in usability. In which case I can
>> update the if statement and resubmit. This is basically how
>> hid-multitouch is handling it. Maybe in the future we can add a
>> parameter to enable reporting palms to userspace.
> 
> Ughh, parameters are something that tends to stay disabled... Too bad
> that hid-rmi4 hid this data. Is it really ugly if we simply let
> userspace clients catch up to the kernel?  As I mentioned in another
> email, we have another driver generating MT_TOOL_PALM.
> 
> Thanks.
> 
