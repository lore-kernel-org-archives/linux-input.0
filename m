From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Wed, 6 Jan 2016 09:12:30 +0100
Message-ID: <568CCC6E.7010707@redhat.com>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
 <20160105164421.GP22661@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160105164421.GP22661@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Santiago Gala <sgala@apache.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Hung <alex.hung@canonical.com>
List-Id: linux-input@vger.kernel.org

Hi,

On 05-01-16 17:44, Pali Roh=C3=A1r wrote:
> On Sunday 22 March 2015 14:46:11 Pali Roh=C3=A1r wrote:
>> This patch adds detection of trackstick for v7 protocol devices. Cod=
e in this
>> patch is used in official Dell touchpad linux drivers for Dell model=
s:
>> Dell Latitude E5250/5250, E5450/5450, E5550/5550
>>
>> Detection code and base reg for alps v3 rushmore and v7 devices is e=
xacly same.
>>
>> Also user in bug https://bugzilla.kernel.org/show_bug.cgi?id=3D94801=
 reported
>> that Toshiba Sattellite Z30-A-1DG has only alps v7 touchpad device w=
ithout
>> trackstick and kernel reports to userspace also redundant trackstick=
 device.
>>
>> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>> ---
>
> Hello!
>
> Alex now tested this patch on two Dell machines with ALPS: E5450 (wit=
h
> TrackStick) and E5250 (without TrackStick).
>
> With patch nothing was changed for E5450. And E5250 with patch does n=
ot
> show trackstick input device anymore.
>
> Tested-by: Alex Hung <alex.hung@canonical.com>

With that this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Pali, it is probably a good idea to send Dmitry a v2 of these 2
patches rebased on top of the latest next and with Alex' Tested-By
and my Reviewed-by-s added.

Regards,

Hans


>
>>   drivers/input/mouse/alps.c |   12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index 33198b9..c9cd27a 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -30,6 +30,7 @@
>>   #define ALPS_CMD_NIBBLE_10	0x01f2
>>
>>   #define ALPS_REG_BASE_RUSHMORE	0xc2c0
>> +#define ALPS_REG_BASE_V7	0xc2c0
>>   #define ALPS_REG_BASE_PINNACLE	0x0000
>>
>>   static const struct alps_nibble_commands alps_v3_nibble_commands[]=
 =3D {
>> @@ -1795,7 +1796,7 @@ static int alps_absolute_mode_v3(struct psmous=
e *psmouse)
>>   	return 0;
>>   }
>>
>> -static int alps_probe_trackstick_v3(struct psmouse *psmouse, int re=
g_base)
>> +static int alps_probe_trackstick_v3_v7(struct psmouse *psmouse, int=
 reg_base)
>>   {
>>   	int ret =3D -EIO, reg_val;
>>
>> @@ -1880,7 +1881,7 @@ static int alps_hw_init_v3(struct psmouse *psm=
ouse)
>>   	int reg_val;
>>   	unsigned char param[4];
>>
>> -	reg_val =3D alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_PINNAC=
LE);
>> +	reg_val =3D alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_PIN=
NACLE);
>>   	if (reg_val =3D=3D -EIO)
>>   		goto error;
>>
>> @@ -2260,8 +2261,8 @@ static int alps_set_protocol(struct psmouse *p=
smouse,
>>   		priv->x_bits =3D 16;
>>   		priv->y_bits =3D 12;
>>
>> -		if (alps_probe_trackstick_v3(psmouse,
>> -					     ALPS_REG_BASE_RUSHMORE) < 0)
>> +		if (alps_probe_trackstick_v3_v7(psmouse,
>> +						ALPS_REG_BASE_RUSHMORE) < 0)
>>   			priv->flags &=3D ~ALPS_DUALPOINT;
>>
>>   		break;
>> @@ -2311,6 +2312,9 @@ static int alps_set_protocol(struct psmouse *p=
smouse,
>>   		if (priv->fw_ver[1] !=3D 0xba)
>>   			priv->flags |=3D ALPS_BUTTONPAD;
>>
>> +		if (alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_V7) < 0)
>> +			priv->flags &=3D ~ALPS_DUALPOINT;
>> +
>>   		break;
>>   	}
>>
>
