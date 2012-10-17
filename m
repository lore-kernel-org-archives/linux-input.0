From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 2/2] input: qt2160: Add support for LEDs.
Date: Wed, 17 Oct 2012 09:23:28 +0200
Message-ID: <CACKLOr0sbzH4gTvmjcXYp4zYZjKrHnpV1ZDNkcEXBG6c28wLSg@mail.gmail.com>
References: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com>
	<1350400771-7950-2-git-send-email-javier.martin@vista-silicon.com>
	<1693540.1O90RJqgga@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58434 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100Ab2JQHXa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Oct 2012 03:23:30 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so6083527wgb.1
        for <linux-input@vger.kernel.org>; Wed, 17 Oct 2012 00:23:29 -0700 (PDT)
In-Reply-To: <1693540.1O90RJqgga@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, axel.lin@gmail.com

Hi Dmitry,

On 16 October 2012 17:53, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Javier,
>
> On Tuesday, October 16, 2012 05:19:31 PM Javier Martin wrote:
>> Outputs x8..x0 of the qt2160 can have leds attached to it.
>> This patch handles those outputs using EV_LED events.
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>>  drivers/input/keyboard/qt2160.c |   38
>> ++++++++++++++++++++++++++++++++++++++ 1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/input/keyboard/qt2160.c
>> b/drivers/input/keyboard/qt2160.c index 73ea4b0..7070372 100644
>> --- a/drivers/input/keyboard/qt2160.c
>> +++ b/drivers/input/keyboard/qt2160.c
>> @@ -39,6 +39,7 @@
>>  #define QT2160_CMD_GPIOS      6
>>  #define QT2160_CMD_SUBVER     7
>>  #define QT2160_CMD_CALIBRATE  10
>> +#define QT2160_CMD_LEDS       70
>>
>>  #define QT2160_CYCLE_INTERVAL        (2*HZ)
>>
>> @@ -217,6 +218,30 @@ static int __devinit qt2160_write(struct i2c_client
>> *client, u8 reg, u8 data) return ret;
>>  }
>>
>> +static int qt2160_event(struct input_dev *dev,
>> +                     unsigned int type, unsigned int code, int value)
>> +{
>> +     struct qt2160_data *qt2160 = input_get_drvdata(dev);
>> +     struct i2c_client *client = qt2160->client;
>> +     u32 val;
>> +
>> +     switch (type) {
>> +     case EV_LED:
>> +             val = qt2160_read(qt2160->client, QT2160_CMD_LEDS);
>> +             if (value)
>> +                     val |= (1 << code);
>> +             else
>> +                     val &= ~(1 << code);
>
> So qt2160 happens to use the same encoding as Linux and the leds
> have the same purpose? Or maybe LED subsystem should be used to
> register general-purpose leds?

Yes, it uses the same encoding as Linux.
The second question is more tricky and I expect you kindly give some
guidelines about it.
It is true that x8...x0 are just output pins in the qt2160, and
anything could be attached to them. They could be handled as
output-only GPIOs. Is it right to mix GPIO framework with input
framework in this driver?
On the other hand, with the current approach x8...x0 are fully functional too.

>> +             qt2160_write(qt2160->client, QT2160_CMD_LEDS, val);
>
> I do not think this will work as qt2160_event() runs under a spinlock
> with interrupts off, and qt2160_read() and qt2160_write() do I2C IO
> and thus may sleep.

Sorry, I hadn't notice that the upper layers used a spinlock for this.
This have worked in our tests but it is obviously not safe. I should
use a tasklet or similar to issue the qt2160_write() call.

> Also qt2160_write is marked __devinit and so may not be available to
> qt2160_event.
>
> How was this tested?

Well, it was tested and works properly in our platform but it seems a
good idea to remove __devinit for those functions now that they will
be used outside the init functions.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
