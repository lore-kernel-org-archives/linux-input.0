From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] xpad: Add GPD Win 2 Controller USB IDs
Date: Thu, 31 May 2018 10:10:06 -0700
Message-ID: <CAKdAkRTYdJj+4V+Ty+b4vo+2LW8b7uB1pn78v=LKd0=-9HU5Tg@mail.gmail.com>
References: <20180531121019.18228-1-flibitijibibo@gmail.com> <192ae554-497b-2597-90d9-ecd242b5105a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <192ae554-497b-2597-90d9-ecd242b5105a@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ethan Lee <flibitijibibo@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, Cameron Gutman <aicommander@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Ethan,

- stable@ to BCC

On Thu, May 31, 2018 at 5:12 AM, Ethan Lee <flibitijibibo@gmail.com> wrote:
> Aaand right as I send these I see git-send-email auto-CC'd stable directly
> again. Sorry!
>
> -Ethan
>
>
> On 05/31/2018 08:10 AM, flibitijibibo@gmail.com wrote:
>>
>> From: Ethan Lee <flibitijibibo@gmail.com>
>>
>> GPD Win 2 Website: http://www.gpd.hk/gpdwin2.asp
>>
>> Tested on a unit from the first production run sent to Indiegogo backers

So I understand that adding this new VID/PID pair to the xpad driver
makes controller recognize the device,
but the button/axis mapping is not what it should be. Does it mean
that the mapping is different from other xpad controllers, or the
mapping that we are using is messed up for all/most of them?

It looks like the mapping we use is quite a mess, I wonder if we could
not bite the bullet and unify it so it follows
Documentation/input/gamepad.rst... I would make users update their
existing configs, but the new installations would be more sensible.
Just a thought... Or you could tell me that nobody pays attention to
what kernel sends and everyone remaps anyway...

>>
>> Signed-off-by: Ethan Lee <flibitijibibo@gmail.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/input/joystick/xpad.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>> index 06e9650b3b30..a89b81b35932 100644
>> --- a/drivers/input/joystick/xpad.c
>> +++ b/drivers/input/joystick/xpad.c
>> @@ -123,6 +123,7 @@ static const struct xpad_device {
>>         u8 mapping;
>>         u8 xtype;
>>   } xpad_device[] = {
>> +       { 0x0079, 0x18d4, "GPD Win 2 Controller", 0, XTYPE_XBOX360 },
>>         { 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
>>         { 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
>>         { 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX
>> },
>> @@ -409,6 +410,7 @@ static const signed short xpad_abs_triggers[] = {
>>     static const struct usb_device_id xpad_table[] = {
>>         { USB_INTERFACE_INFO('X', 'B', 0) },    /* X-Box USB-IF not
>> approved class */
>> +       XPAD_XBOX360_VENDOR(0x0079),            /* GPD Win 2 Controller */
>>         XPAD_XBOX360_VENDOR(0x044f),            /* Thrustmaster X-Box 360
>> controllers */
>>         XPAD_XBOX360_VENDOR(0x045e),            /* Microsoft X-Box 360
>> controllers */
>>         XPAD_XBOXONE_VENDOR(0x045e),            /* Microsoft X-Box One
>> controllers */
>

-- 
Dmitry
