From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] CHROMIUM: Input: synaptics - filter out the events with
 low z values
Date: Wed, 22 Feb 2012 18:26:37 +0800
Message-ID: <CAGS+omCU9f=DyC442+4HOF=sGhZYXne+E2ephFiOmuj-XKciMA@mail.gmail.com>
References: <1329896503-28394-1-git-send-email-cywang@chromium.org> <20120222083858.GA26570@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120222083858.GA26570@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chung-yih Wang <cywang@chromium.org>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 22, 2012 at 4:38 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Chung-yih Wang,
>
>> The single touch path imposes a minimum z value (with hysterisis) be=
fore
>> registering BTN_TOUCH. Apply the same (hard coded) threshold when
>> deciding how many fingers to report in the semi-mt path.
>>
>> This patch improves performance of the Google Cr-48 chromebook's
>> extremely sensitive Synaptics profile sensor touchpad by filtering o=
ut
>> touch events for hovering fingers.
>>
>> Note: We continue to use the same hard coded threshold value used in=
 the
>> single touch case as it appears this works just as well on these
>> multitouch profile sensor pads as on whatever pads it was originally
>> discovered.
>>
>> Signed-off-by: Chung-Yih Wang <cywang@chromium.org>
>> ---
>
> The idea is sound and has worked well in practise for a long
> time. However, please see the comments inline.
>
>> =A0drivers/input/mouse/synaptics.c | =A0 15 +++++++++++----
>> =A01 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/s=
ynaptics.c
>> index 8081a0a..746dbcc 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -568,17 +568,22 @@ static void synaptics_report_semi_mt_slot(stru=
ct input_dev *dev, int slot,
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static bool finger_touched(const struct synaptics_hw_state *hw)
>> +{
>> + =A0 =A0 return (hw->z > 30);
>> +}
>> +
>> =A0static void synaptics_report_semi_mt_data(struct input_dev *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 const struct synaptics_hw_state *a,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 const struct synaptics_hw_state *b,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 int num_fingers)
>> =A0{
>> - =A0 =A0 if (num_fingers >=3D 2) {
>> + =A0 =A0 if ((num_fingers >=3D 2) && finger_touched(a) && finger_to=
uched(b)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_report_semi_mt_slot(dev, 0, tr=
ue, min(a->x, b->x),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 min(a->y, b->y));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_report_semi_mt_slot(dev, 1, tr=
ue, max(a->x, b->x),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 max(a->y, b->y));
>> - =A0 =A0 } else if (num_fingers =3D=3D 1) {
>> + =A0 =A0 } else if ((num_fingers =3D=3D 1) && finger_touched(a)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_report_semi_mt_slot(dev, 0, tr=
ue, a->x, a->y);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_report_semi_mt_slot(dev, 1, fa=
lse, 0, 0);
>> =A0 =A0 =A0 } else {
>
> So if num_fingers =3D=3D 2 and only one of a and b returns
> finger_touched() =3D=3D true, we fall back to zero fingers?

Actually, yes.   In this case, we will have 2 x's and 2 y's, but not
know which belong to a good finger and which belong to a too light
finger....  sigh... synaptics... sigh...

>
>> @@ -1040,8 +1045,10 @@ static void synaptics_process_packet(struct p=
smouse *psmouse)
>> =A0 =A0 =A0 =A0* BTN_TOUCH has to be first as mousedev relies on it =
when doing
>> =A0 =A0 =A0 =A0* absolute -> relative conversion
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
>> - =A0 =A0 if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
>> + =A0 =A0 if (finger_touched(&hw))
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dev, BTN_TOUCH, 1);
>> + =A0 =A0 if (hw.z < 25)
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dev, BTN_TOUCH, 0);
>>
>> =A0 =A0 =A0 if (num_fingers > 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_X, hw.x);
>
> Why not introduce hysteresis for all fingers here? There is an exampl=
e
> implementation in bcm5974.c in the same directory.

Good idea, can it be in a different, follow-up patch?

>
> Thanks,
> Henrik
