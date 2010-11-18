From: Chris Leech <christopher.leech@linux.intel.com>
Subject: Re: [PATCH 2/5] qt602240_ts: move clearing of pending interrupt
	closer to request_threaded_irq
Date: Thu, 18 Nov 2010 11:29:02 -0800
Message-ID: <20101118192902.GE1273@cleech-lnx.jf.intel.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6> <20101116204155.28796.6682.stgit@localhost6.localdomain6> <4CE521B9.9070509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7227 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461Ab0KRT3D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 14:29:03 -0500
Content-Disposition: inline
In-Reply-To: <4CE521B9.9070509@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org

On Thu, Nov 18, 2010 at 09:53:13PM +0900, Joonyoung Shim wrote:
> Hi, Chris.
>
> On 2010-11-17 =EC=98=A4=EC=A0=84 5:41, Chris Leech wrote:
>> I've seen interrupts asserted on the CHG pin between the call to mak=
e_highcgh()
>> during initialization and registering the interrupt handler, leaving=
 CHG low
>> and no events get passed up.
>>
>
> The CHG pin can be affected by control of gpios connected to touch
> chip. Could you check it? I think it doesn't matter where
> make_highchg() exists actually.

My understanding is that CHG is to be used to trigger interrupts, and
the attached gpio should be set as an input.  I'm not sure trying to se=
t
the value from the gpio side is going to work.

The problem I was seeing was the attached gpio configured as a
falling-edge-triggered interrupt stuck in the low state, and
qt602240_interrupt is never called.  What that says to me is that CHG
transitioned low before the interrupt handler was registered.  From wha=
t
I can see, the only way to reset CHG is to clear the queue of pending
messages, which is what make_highchg does.

- Chris

> Thanks.
>
>> This moves the clearing of pending messages to right before the call=
 to
>> request_threaded_irq().  I still think there's a race here that coul=
d leave CHG
>> stuck low, but worry about clearing the message queue while the inte=
rrupt
>> handler is registered without some sort of additional locking.
>>
>> Signed-off-by: Chris Leech<christopher.leech@linux.intel.com>
>> ---
>>   drivers/input/touchscreen/qt602240_ts.c |    8 ++++----
>>   1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input=
/touchscreen/qt602240_ts.c
>> index 0b92c9d..95496ec 100644
>> --- a/drivers/input/touchscreen/qt602240_ts.c
>> +++ b/drivers/input/touchscreen/qt602240_ts.c
>> @@ -991,10 +991,6 @@ static int qt602240_initialize(struct qt602240_=
data *data)
>>   	if (error)
>>   		return error;
>>
>> -	error =3D qt602240_make_highchg(data);
>> -	if (error)
>> -		return error;
>> -
>>   	qt602240_handle_pdata(data);
>>
>>   	/* Backup to memory */
>> @@ -1280,6 +1276,10 @@ static int __devinit qt602240_probe(struct i2=
c_client *client,
>>   	if (error)
>>   		goto err_free_object;
>>
>> +	error =3D qt602240_make_highchg(data);
>> +	if (error)
>> +		goto err_free_object;
>> +
>>   	error =3D request_threaded_irq(client->irq, NULL, qt602240_interr=
upt,
>>   			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
>>   	if (error) {
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
