From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] hid: ntrig touch events
Date: Thu, 18 Mar 2010 16:19:34 -0400
Message-ID: <4BA28AD6.7020803@seas.upenn.edu>
References: <4B9722A5.1030607@seas.upenn.edu> <1268210326-8066-1-git-send-email-rafi@seas.upenn.edu> <alpine.LNX.2.00.1003101603400.18642@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:33482 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab0CRUTj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Mar 2010 16:19:39 -0400
In-Reply-To: <alpine.LNX.2.00.1003101603400.18642@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/10/10 10:04, Jiri Kosina wrote:
> On Wed, 10 Mar 2010, rafi@seas.upenn.edu wrote:
> 
>> This reinstates the lost unpressing of BTN_TOUCH.  To prevent undesireably
>> touch toggles this also deals with tip switch events.
>>
>> Added a trap to prevent going out of bounds for hidinputs with empty reports.
>>
>> Clear bits of unused buttons which result in misidentification.
>>
>> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
>> ---
>>  drivers/hid/hid-ntrig.c |   11 +++++++++++
>>  1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
>> index 3234c72..edcc0c4 100644
>> --- a/drivers/hid/hid-ntrig.c
>> +++ b/drivers/hid/hid-ntrig.c
>> @@ -140,6 +140,9 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>>  			nd->reading_mt = 1;
>>  			nd->first_contact_confidence = 0;
>>  			break;
>> +		case HID_DG_TIPSWITCH:
>> +			/* Prevent emission of touch until validated */
>> +			return 1;
>>  		case HID_DG_CONFIDENCE:
>>  			nd->confidence = value;
>>  			break;
>> @@ -259,6 +262,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>>  						BTN_TOOL_TRIPLETAP, 0);
>>  				input_report_key(input,
>>  						BTN_TOOL_QUADTAP, 0);
>> +				input_report_key(input, BTN_TOUCH, 0);
>>  			}
>>  			break;
>>  
>> @@ -308,13 +312,20 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  
>>  
>>  	list_for_each_entry(hidinput, &hdev->inputs, list) {
>> +		if (hidinput->report->maxfield < 1)
>> +			continue;
>> +
>>  		input = hidinput->input;
>>  		switch (hidinput->report->field[0]->application) {
>>  		case HID_DG_PEN:
>>  			input->name = "N-Trig Pen";
>>  			break;
>>  		case HID_DG_TOUCHSCREEN:
>> +			/* These keys are redundant for fingers, clear them
>> +			 * to prevent incorrect identification */
>>  			__clear_bit(BTN_TOOL_PEN, input->keybit);
>> +			__clear_bit(BTN_TOOL_FINGER, input->keybit);
>> +			__clear_bit(BTN_0, input->keybit);
>>  			/*
>>  			 * A little something special to enable
>>  			 * two and three finger taps.
> 
> Thanks for the fix. I have altered changelog a little bit, and applied.

Is this patch likely to get promoted soon (days, weeks)?

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkuiitMACgkQwuRiAT9o608cYgCgv9Rj4eDXJYVuW8tGZUfQ+U8W
y0EAnjZj21Cdlj6dvHvdceOXQunnhqiX
=dibf
-----END PGP SIGNATURE-----
