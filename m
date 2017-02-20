From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] Input: tsc2007 - switch to using input_set_capability()
Date: Mon, 20 Feb 2017 17:51:09 +0100
Message-ID: <00582767-0B38-40F8-B690-B4BDFF5CD5A8@goldelico.com>
References: <20170217225627.GA27132@dtor-ws> <6EE891F1-A20E-4AB3-934C-09B35FF7DE30@goldelico.com> <20170220011045.GC8358@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170220011045.GC8358@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

> Am 20.02.2017 um 02:10 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>=20
> On Sat, Feb 18, 2017 at 03:58:39PM +0100, H. Nikolaus Schaller wrote:
>> Hi Dmitry,
>>=20
>>> Am 17.02.2017 um 23:56 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>>>=20
>>> Do not manipulate evbit/keybit directly, use helper for that.
>>>=20
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> ---
>>> drivers/input/touchscreen/tsc2007_core.c | 3 +--
>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/input/touchscreen/tsc2007_core.c =
b/drivers/input/touchscreen/tsc2007_core.c
>>> index fdf81a2b989a..98dbefc3357d 100644
>>> --- a/drivers/input/touchscreen/tsc2007_core.c
>>> +++ b/drivers/input/touchscreen/tsc2007_core.c
>>> @@ -364,8 +364,7 @@ static int tsc2007_probe(struct i2c_client =
*client,
>>>=20
>>> 	input_set_drvdata(input_dev, ts);
>>>=20
>>> -	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>>> -	input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
>>> +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
>>=20
>> basically a good improvement, but removing the BIT_MASK(EV_ABS) makes =
problems
>> when replacing the next lines
>>=20
>>>=20
>>> 	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzx, =
0);
>>> 	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy, =
0);
>>=20
>> by touchscreen_parse_properties() as done by my patch set.
>>=20
>> The problem is that touchscreen_parse_properties() does not call
>> input_set_abs_params() but touchscreen_set_params(). This does not
>> call some input_set_capability(dev, EV_ABS, axis) but rather checks
>> that it has been set before! Hence we only see warnings in the log =
and
>> no input event properties (BTN_TOUCH works but without position
>> information).
>=20
> Yes, the driver is supposed to set defaults, then OF data may augment
> them (or it may omit them and leave driver's defaults).

Ok.

> You should not
> have removed calls to
>=20
> 	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzx, =
0);

Wouldn't it suffice to call

	input_set_capability(input_dev, EV_ABS, ABS_X);
	input_set_capability(input_dev, EV_ABS, ABS_Y);

since fuzz default is already 0?

BR,
Nikolaus
