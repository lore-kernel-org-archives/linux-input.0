From: Yufeng Shen <miletus@chromium.org>
Subject: Re: [PATCH v3] Input: atmel_mxt_ts - Report pressure information from
 the driver
Date: Tue, 16 Aug 2011 14:17:49 -0400
Message-ID: <CAPDwgkN9uqxJMkF4hjQcNSfvvJ=n-x-fURy0bJ5rfP6UMt5wcw@mail.gmail.com>
References: <1313420550-5885-1-git-send-email-miletus@chromium.org>
	<20110816052738.GA25878@polaris.bitmath.org>
	<20110816072041.GA20084@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:17490 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab1HPSRw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 14:17:52 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p7GIHpx7024995
	for <linux-input@vger.kernel.org>; Tue, 16 Aug 2011 11:17:51 -0700
Received: from gwj15 (gwj15.prod.google.com [10.200.10.15])
	by wpaz33.hot.corp.google.com with ESMTP id p7GIHkEO005069
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 16 Aug 2011 11:17:50 -0700
Received: by gwj15 with SMTP id 15so211970gwj.25
        for <linux-input@vger.kernel.org>; Tue, 16 Aug 2011 11:17:49 -0700 (PDT)
In-Reply-To: <20110816072041.GA20084@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-kernel@vger.kernel.org, Michael Gong <Michael.Gong@atmel.com>, Alan Bowens <Alan.Bowens@atmel.com>

Re-sent from proper email account and sorry for the spam.

-----------------------------------------------------------------------=
------------------------------------------------

Tested that adding=A0=A0ABS_PRESSURE to ST works properly.
Do you want me to submit a new patch or is this good enough for you to =
merge ?
Thanks.

On Tue, Aug 16, 2011 at 3:20 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Tue, Aug 16, 2011 at 07:27:38AM +0200, Henrik Rydberg wrote:
> > On Mon, Aug 15, 2011 at 11:02:30AM -0400, Yufeng Shen wrote:
> > > Atmel mxt1386 touch controller has the touch pressure information=
 but
> > > the current driver atmel_mxt_ts does not expose it to the user sp=
ace.
> > > This patch makes the driver report the touch pressure information=
 to
> > > user space.
> > >
> > > ChangeLog:
> > > v2: fixed indentation as commented by Wanlong Gao
> > > v3: added signed-off-by
> > >
>
> I think we should be reporting pressure for ST emulation as well. Doe=
s
> the following version still work for you?
>
> Thanks.
>
> --
> Dmitry
>
> Input: atmel_mxt_ts - report pressure information from the driver
>
> From: Yufeng Shen <miletus@chromium.org>
>
> Atmel mxt1386 touch controller has the touch pressure information so
> let's report it to the user space.
>
> [dtor@mail.ru: added ABS_RESSURE reporting for ST emulation.]
>
> Signed-off-by: Yufeng Shen <miletus@chromium.org>
> Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Acked-by: Henrik Rydberg <rydberg@euromail.se>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 12 ++++++++++++
> =A01 files changed, 12 insertions(+), 0 deletions(-)
>
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input=
/touchscreen/atmel_mxt_ts.c
> index c4f6b81..5bc2065 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -245,6 +245,7 @@ struct mxt_finger {
> =A0 =A0 =A0 =A0int x;
> =A0 =A0 =A0 =A0int y;
> =A0 =A0 =A0 =A0int area;
> + =A0 =A0 =A0 int pressure;
> =A0};
>
> =A0/* Each client has this additional data */
> @@ -537,6 +538,8 @@ static void mxt_input_report(struct mxt_data *dat=
a, int single_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0finger[id].x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input=
_dev, ABS_MT_POSITION_Y,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0finger[id].y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_=
dev, ABS_MT_PRESSURE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 finger[id].pressure);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0finger[id].status =3D =
0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -547,6 +550,8 @@ static void mxt_input_report(struct mxt_data *dat=
a, int single_id)
> =A0 =A0 =A0 =A0if (status !=3D MXT_RELEASE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input_dev, ABS_X, fin=
ger[single_id].x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input_dev, ABS_Y, fin=
ger[single_id].y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ABS_=
PRESSURE, finger[single_id].pressure);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0input_sync(input_dev);
> @@ -561,6 +566,7 @@ static void mxt_input_touchevent(struct mxt_data =
*data,
> =A0 =A0 =A0 =A0int x;
> =A0 =A0 =A0 =A0int y;
> =A0 =A0 =A0 =A0int area;
> + =A0 =A0 =A0 int pressure;
>
> =A0 =A0 =A0 =A0/* Check the touch is present on the screen */
> =A0 =A0 =A0 =A0if (!(status & MXT_DETECT)) {
> @@ -585,6 +591,7 @@ static void mxt_input_touchevent(struct mxt_data =
*data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y =3D y >> 2;
>
> =A0 =A0 =A0 =A0area =3D message->message[4];
> + =A0 =A0 =A0 pressure =3D message->message[5];
>
> =A0 =A0 =A0 =A0dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status & MXT_MOVE ? "moved" : "pressed=
",
> @@ -595,6 +602,7 @@ static void mxt_input_touchevent(struct mxt_data =
*data,
> =A0 =A0 =A0 =A0finger[id].x =3D x;
> =A0 =A0 =A0 =A0finger[id].y =3D y;
> =A0 =A0 =A0 =A0finger[id].area =3D area;
> + =A0 =A0 =A0 finger[id].pressure =3D pressure;
>
> =A0 =A0 =A0 =A0mxt_input_report(data, id);
> =A0}
> @@ -1130,6 +1138,8 @@ static int __devinit mxt_probe(struct i2c_clien=
t *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, data->max_=
x, 0, 0);
> =A0 =A0 =A0 =A0input_set_abs_params(input_dev, ABS_Y,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, data->max_=
y, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_PRESSURE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, 255, 0, 0=
);
>
> =A0 =A0 =A0 =A0/* For multi touch */
> =A0 =A0 =A0 =A0input_mt_init_slots(input_dev, MXT_MAX_FINGER);
> @@ -1139,6 +1149,8 @@ static int __devinit mxt_probe(struct i2c_clien=
t *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, data->max_=
x, 0, 0);
> =A0 =A0 =A0 =A0input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, data->max_=
y, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_PRESSURE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, 255, 0, 0=
);
>
> =A0 =A0 =A0 =A0input_set_drvdata(input_dev, data);
> =A0 =A0 =A0 =A0i2c_set_clientdata(client, data);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
