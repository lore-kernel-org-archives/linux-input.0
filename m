From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 2/2] input: qt2160: Add support for LEDs.
Date: Wed, 17 Oct 2012 10:32:33 +0200
Message-ID: <CACKLOr1h-OrmyOfqwGETZymzcY_DNGODnU_soWCkZmTgN5LxCw@mail.gmail.com>
References: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com>
	<1350400771-7950-2-git-send-email-javier.martin@vista-silicon.com>
	<1693540.1O90RJqgga@dtor-d630.eng.vmware.com>
	<CACKLOr0sbzH4gTvmjcXYp4zYZjKrHnpV1ZDNkcEXBG6c28wLSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:53566 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab2JQIce (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Oct 2012 04:32:34 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so309978wib.1
        for <linux-input@vger.kernel.org>; Wed, 17 Oct 2012 01:32:33 -0700 (PDT)
In-Reply-To: <CACKLOr0sbzH4gTvmjcXYp4zYZjKrHnpV1ZDNkcEXBG6c28wLSg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, axel.lin@gmail.com

Hi Dmitry,
let me elaborate more on the LED issue.

On 17 October 2012 09:23, javier Martin <javier.martin@vista-silicon.com> wrote:
> Hi Dmitry,
>
> On 16 October 2012 17:53, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> Hi Javier,
>>
>> On Tuesday, October 16, 2012 05:19:31 PM Javier Martin wrote:
>>> Outputs x8..x0 of the qt2160 can have leds attached to it.
>>> This patch handles those outputs using EV_LED events.
>>>
>>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>>> ---
>>>  drivers/input/keyboard/qt2160.c |   38
>>> ++++++++++++++++++++++++++++++++++++++ 1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/input/keyboard/qt2160.c
>>> b/drivers/input/keyboard/qt2160.c index 73ea4b0..7070372 100644
>>> --- a/drivers/input/keyboard/qt2160.c
>>> +++ b/drivers/input/keyboard/qt2160.c
>>> @@ -39,6 +39,7 @@
>>>  #define QT2160_CMD_GPIOS      6
>>>  #define QT2160_CMD_SUBVER     7
>>>  #define QT2160_CMD_CALIBRATE  10
>>> +#define QT2160_CMD_LEDS       70
>>>
>>>  #define QT2160_CYCLE_INTERVAL        (2*HZ)
>>>
>>> @@ -217,6 +218,30 @@ static int __devinit qt2160_write(struct i2c_client
>>> *client, u8 reg, u8 data) return ret;
>>>  }
>>>
>>> +static int qt2160_event(struct input_dev *dev,
>>> +                     unsigned int type, unsigned int code, int value)
>>> +{
>>> +     struct qt2160_data *qt2160 = input_get_drvdata(dev);
>>> +     struct i2c_client *client = qt2160->client;
>>> +     u32 val;
>>> +
>>> +     switch (type) {
>>> +     case EV_LED:
>>> +             val = qt2160_read(qt2160->client, QT2160_CMD_LEDS);
>>> +             if (value)
>>> +                     val |= (1 << code);
>>> +             else
>>> +                     val &= ~(1 << code);
>>
>> So qt2160 happens to use the same encoding as Linux and the leds
>> have the same purpose? Or maybe LED subsystem should be used to
>> register general-purpose leds?
>
> Yes, it uses the same encoding as Linux.
> The second question is more tricky and I expect you kindly give some
> guidelines about it.
> It is true that x8...x0 are just output pins in the qt2160, and
> anything could be attached to them. They could be handled as
> output-only GPIOs. Is it right to mix GPIO framework with input
> framework in this driver?
> On the other hand, with the current approach x8...x0 are fully functional too.

There are three possible frameworks that could be used to implement
this functionality:
1. Using EV_LED events in the input framework.
2. Using LED subsystem and registering general-purpose leds.
3. Using GPIO subsystem to register generic, output only, GPIOs.

IMHO, option 3 could be discarded since it doesn't make much sense to
have output only GPIOs, the flexibility this framework provides
wouldn't be used at all.
So only options 1 and 2 would be left.

I chose option 1 because this driver already uses the input framework
and I thought this functionality would be more easily integrated this
way.
As I understand, your concern with option 1 is related with the fact
that LED_NUML, LED_CAPSL, etc... don't have that meaning in this chip,
because we don't know what the user will be attaching to x7...x0
outputs.
But this argument could be used for the EV_KEY feature too. The
following suggested mapping in the same driver is just arbitrary,
isn't it?:

static unsigned char qt2160_key2code[] = {
	KEY_0, KEY_1, KEY_2, KEY_3,
	KEY_4, KEY_5, KEY_6, KEY_7,
	KEY_8, KEY_9, KEY_A, KEY_B,
	KEY_C, KEY_D, KEY_E, KEY_F,
};

Anyway I'm totally open to reimplement the feature using option 2, as
long as we agree that it's the right way to proceed. If this approach
were to be taken, should I add it to the same file or should I create
a separate driver inside /drivers/leds ?

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
