From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] Input: trackpoint: add new trackpoint firmware ID
Date: Mon, 13 Feb 2017 08:21:10 +0800
Message-ID: <119a5eeb-3be0-4bbd-13a3-39f747722fcd@canonical.com>
References: <1486695741-8969-1-git-send-email-aaron.ma@canonical.com>
 <20170212223859.GA15928@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52289 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdBMAVS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 19:21:18 -0500
In-Reply-To: <20170212223859.GA15928@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>



On 02/13/2017 06:38 AM, Dmitry Torokhov wrote:
> On Fri, Feb 10, 2017 at 11:02:21AM +0800, Aaron Ma wrote:
>> Synaptics add new TP firmware ID: 0x2 and 0x3, for now both lower 2 bits
>> are indicated as TP. Change the constant to bitwise values.
> 
> Hmm, I thought IBM/Lenovo owned trackpoint support... Andrew, is it
> yours now?
> 
> Aaron, what devices have these new trackpoints>?

Lenovo ThinkPad X1 Carbon 5th have this new trackpoint, maybe it is not
on sale yet but soon.

BR,
Aaron

> 
> Thanks.
> 
>>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/input/mouse/trackpoint.c | 3 ++-
>>  drivers/input/mouse/trackpoint.h | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
>> index 7331084..9ff0f38 100644
>> --- a/drivers/input/mouse/trackpoint.c
>> +++ b/drivers/input/mouse/trackpoint.c
>> @@ -265,7 +265,8 @@ static int trackpoint_start_protocol(struct psmouse *psmouse, unsigned char *fir
>>  	if (ps2_command(&psmouse->ps2dev, param, MAKE_PS2_CMD(0, 2, TP_READ_ID)))
>>  		return -1;
>>  
>> -	if (param[0] != TP_MAGIC_IDENT)
>> +	/* add new TP ID. */
>> +	if (!(param[0] & TP_MAGIC_IDENT))
>>  		return -1;
>>  
>>  	if (firmware_id)
>> diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
>> index 5617ed3..8805575 100644
>> --- a/drivers/input/mouse/trackpoint.h
>> +++ b/drivers/input/mouse/trackpoint.h
>> @@ -21,8 +21,9 @@
>>  #define TP_COMMAND		0xE2	/* Commands start with this */
>>  
>>  #define TP_READ_ID		0xE1	/* Sent for device identification */
>> -#define TP_MAGIC_IDENT		0x01	/* Sent after a TP_READ_ID followed */
>> +#define TP_MAGIC_IDENT		0x03	/* Sent after a TP_READ_ID followed */
>>  					/* by the firmware ID */
>> +					/* Firmware ID includes 0x1, 0x2, 0x3 */
>>  
>>  
>>  /*
>> -- 
>> 2.9.3
>>
> 
