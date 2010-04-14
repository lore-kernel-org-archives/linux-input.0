From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] Use TipSwitch for Touch
Date: Wed, 14 Apr 2010 03:51:11 -0400
Message-ID: <4BC573EF.7050404@seas.upenn.edu>
References: <alpine.LNX.2.00.1004131530460.8345@pobox.suse.cz> <1271221494-14846-1-git-send-email-rafi@seas.upenn.edu> <20100414063242.GB9428@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:54357 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab0DNHvT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 03:51:19 -0400
In-Reply-To: <20100414063242.GB9428@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, micki@n-trig.com, chatty@enac.fr

Dmitry Torokhov wrote:
> On Wed, Apr 14, 2010 at 01:04:54AM -0400, Rafi Rubin wrote:
>> TipSwitch is a better match for touch.  Confidence and InRange work
>> for more current firmwares, but with some older versions only
>> TipSwitch is appropriate.
>>
>> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
>> ---
>>  drivers/hid/hid-ntrig.c |   27 +++++++++++++++++++--------
>>  1 files changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
>> index 58ba0d3..071f86d 100644
>> --- a/drivers/hid/hid-ntrig.c
>> +++ b/drivers/hid/hid-ntrig.c
>> @@ -31,10 +31,12 @@ struct ntrig_data {
>>  	/* Incoming raw values for a single contact */
>>  	__u16 x, y, w, h;
>>  	__u16 id;
>> -	__u8 confidence;
>> +
>> +	bool tipswitch;
>> +	bool confidence;
>> +	bool first_contact_touch;
>>  
>>  	bool reading_mt;
>> -	__u8 first_contact_confidence;
>>  
>>  	__u8 mt_footer[4];
>>  	__u8 mt_foot_count;
>> @@ -141,9 +143,10 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>>  		case 0xff000001:
>>  			/* Tag indicating the start of a multitouch group */
>>  			nd->reading_mt = 1;
>> -			nd->first_contact_confidence = 0;
>> +			nd->first_contact_touch = 0;
>>  			break;
>>  		case HID_DG_TIPSWITCH:
>> +			nd->tipswitch = value;
>>  			/* Prevent emission of touch until validated */
>>  			return 1;
>>  		case HID_DG_CONFIDENCE:
>> @@ -171,10 +174,17 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>>  			 * to emit a normal (X, Y) position
>>  			 */
>>  			if (!nd->reading_mt) {
>> -				input_report_key(input, BTN_TOOL_DOUBLETAP,
>> -						 (nd->confidence != 0));
>> +				/*
>> +				 * TipSwitch indicates the presence of a
>> +				 * finger.  Touch is the preferred event for
>> +				 * downstream support.  DoubleTap is also
>> +				 * emitted to support proper operation with
>> +				 * the wacom X driver (for now).
>> +				 */
> 
> I am not sure if we want to propagate unfortunate event selection in
> wacom drievr into other drivers. Any chance you could lend Ping hand in
> adding proper multitouch support to wacom X driver instead?

I agree.  Unfortunately I made the mistake of starting with the wacom 
driver a year ago, and now am trying to avoid breaking things for users, 
at least for a while longer.

I'm confident evdev or Henrik's multitouch driver will dominate in the 
near future.  Evdev already supports the touch modes as well or better 
than the wacom for generic touch devices.  I'm hoping users will migrate 
over the next few months and plan to remove the redundant tap events 
after the transition.

But you raise perhaps a better point.  Migrate the wacom stack to match 
the event conventions of everything else.  I'd certainly be willing to help.
