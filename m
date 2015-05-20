From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] alps: Fix finger jumps on lifting 2 fingers on v7 touchpad
Date: Wed, 20 May 2015 19:39:48 +0200
Message-ID: <555CC6E4.8020806@redhat.com>
References: <1432113413-7007-1-git-send-email-hdegoede@redhat.com> <20150520164016.GB23809@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33201 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbbETRjy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 13:39:54 -0400
In-Reply-To: <20150520164016.GB23809@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

Hi,

On 20-05-15 18:40, Dmitry Torokhov wrote:
> On Wed, May 20, 2015 at 11:16:53AM +0200, Hans de Goede wrote:
>> On v7 touchpads sometimes when 2 fingers are moved down on the touchpad
>> until they "fall of" the touchpad, the second touch will report 0 for y
>> (max y really since the y axis is inverted) and max x as coordinates,
>> rather then reporting 0, 0 as is expected for a non touching finger.
>>
>> This commit detects this and treats these touches as non touching.
>>
>> See the evemu-recording here:
>> https://bugzilla.redhat.com/attachment.cgi?id=1025058
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1221200
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/input/mouse/alps.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index 745921f..9bc4343 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -949,6 +949,11 @@ static void alps_get_finger_coordinate_v7(struct input_mt_pos *mt,
>>   	case V7_PACKET_ID_TWO:
>>   		mt[1].x &= ~0x000F;
>>   		mt[1].y |= 0x000F;
>> +		/* Detect false-postive touches where x & y report max value */
>> +		if (mt[1].y == 0x7ff && mt[1].x == 0xff0) {
>> +			mt[1].x = 0;
>> +			/* y gets set to 0 at the end of this function */
>
> I think this is too fragile; I believe we can spare an assignment and
> maybe compiler will optimize it out.
>
> I can fix it up locally unless there are objections to having this extra
> assignment.

I object to having the extra assignment, the comment is there, because the setting
to 0 at the end of the function is done in the form of:

         mt[0].y = 0x7FF - mt[0].y;
         mt[1].y = 0x7FF - mt[1].y;

So if you add a "mt[1].y = 0" assignment in stead of the comment then you're
actually making mt[1].y = 0x7ff instead of 0, that is why there is a comment
there instead of an assignment. Feel free to modify the comment to make this
more clear ...

And yes normally the firmware sends 0x7ff for y and 0 for x when there is no touch,
except sometimes it glitches and it sends 0x7ff for y and 0xff0 for x when there is
no touch, which is what this commit catches (this has been tested by the reporter).

Regards,

Hans
