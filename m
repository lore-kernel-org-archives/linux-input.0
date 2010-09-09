From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [Patch v2] input:rohm based bu21013 touch panel controller driver
 support
Date: Thu, 09 Sep 2010 20:26:40 +0200
Message-ID: <4C8926E0.3040400@euromail.se>
References: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local> <20100909155918.GB19937@core.coreip.homeip.net> <20100909160140.GC19937@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:36102 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959Ab0IIS1v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Sep 2010 14:27:51 -0400
In-Reply-To: <20100909160140.GC19937@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Trilok Soni <tsoni@codeaurora.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Naveen, Dmitry,

comments below.

>>> +/**
>>> + * bu21013_verify_delta() - verify the co-ordinates delta
>>> + * @x1: x1 position
>>> + * @y1: y1 position
>>> + * @x2: x2 position
>>> + * @y2: y2 position
>>> + *
>>> + * This function verifies the delta of the
>>> + * co-ordinates and returns boolean.
>>> + */
>>> +static bool bu21013_verify_delta(int x1, int y1, int x2, int y2)
>>> +{
>>> +       int delta_x, delta_y;
>>> +
>>> +       if ((x1 != 0) && (y1 != 0)) {
>>> +               delta_x = x2 - x1;
>>> +               if (x1 > x2)
>>> +                       delta_x = x1 - x2;
>>> +               delta_y = y2 - y1;
>>> +               if (y1 > y2)
>>> +                       delta_y = y1 - y2;
>>> +               if ((delta_x < DELTA_MIN) || (delta_y < DELTA_MIN))
>>> +                       return false;
>>> +       }
>>> +       return true;
>>
>> Hmm, I remember - the fuzz handling indeed will not work for MT A protocol.
>> Still, I do not think it is correct. Don't you need to do
>> "abs(delta_x) < DELTA_MIN"?


True, fuzz wont be processed in the kernel, but the information can be used
outside the kernel, like in mtdev.

I do not understand why deltas are verified in the first place. Either one can
rely on the identity of the fingers, in which case MT slots is simpler to
handle, or one cannot rely on it, in which case the above code is wrong, since
it assumes the values compared have the same identity.

>>> +static int bu21013_do_touch_report(struct bu21013_ts_data *data)

[...]
>>> +       finger1_pos_x = buf[3] << SHIFT_2 | (buf[4] & MASK_BITS);

>>> +       finger1_pos_y = buf[5] << SHIFT_2 | (buf[6] & MASK_BITS);
>>> +
>>> +       if (data->chip->multi_touch) {
>>> +               finger2_pos_x = buf[7] << SHIFT_2 | (buf[8] & MASK_BITS);
>>> +               finger2_pos_y = buf[9] << SHIFT_2 | (buf[10] & MASK_BITS);
>>> +       }


Yes, why branching on multi_touch here?

>>> +       if (total_number_of_active_sensors) {


Perhaps the logic could be inverted so that the case when the total number is
zero is treated first, to avoid repeated tests below.

>>> +               if ((finger2_pos_x != 0) && (finger2_pos_y != 0)) {
>>> +                       if ((finger1_pos_x == 0) || (finger1_pos_y == 0))
>>> +                               return 0;


So zero is some kind of null value? No continuation here?

>>> +                       ret = bu21013_verify_delta(finger1_pos_x,
>>> +                               finger1_pos_y, finger2_pos_x, finger2_pos_y);
>>> +                       if (!ret)
>>> +                               total_number_of_active_sensors = 0;
>>> +               }


So this is a tracking-plus-filtering solution? Unless the form factor forbids
it, having driver-specific tracking solutions in the kernel is not encouraged.
Two fingers might be borderline.

>>> +       }
>>> +
>>> +       if (total_number_of_active_sensors) {
>>> +               finger1_valid = 1;
>>> +               if ((finger1_pos_x == 0) || (finger1_pos_y == 0) ||
>>> +                       (finger1_pos_x >= data->chip->touch_x_max) ||
>>> +                       (finger1_pos_y >= data->chip->touch_y_max))
>>> +                       finger1_valid = 0;
>>> +               finger2_valid = 1;
>>> +               if ((finger2_pos_x == 0) || (finger2_pos_y == 0) ||
>>> +                       (finger2_pos_x >= data->chip->touch_x_max) ||
>>> +                       (finger2_pos_y >= data->chip->touch_y_max))
>>> +                       finger2_valid = 0;
>>> +               if ((finger1_valid == 0) && (finger2_valid == 0))
>>> +                       return 0;
>>> +               if (finger1_valid) {
>>> +                       bu21013_touch_calc(data, finger1_pos_x,
>>> +                               finger1_pos_y, finger_down_count);
>>> +                       finger_down_count++;
>>> +               }
>>> +               if (finger2_valid) {
>>> +                       bu21013_touch_calc(data, finger2_pos_x,
>>> +                               finger2_pos_y, finger_down_count);
>>> +                       finger_down_count++;
>>> +               }
>>> +       }


Surely this code could be made more comprehensible. Is it even necessary?
It is not an error from the perspective of the input core to send values outside
limits. If we are treating null values, perhaps defining them at the beginning
could help seeing the logic more clearly.

[...]

>>> +static int __devinit bu21013_probe(struct i2c_client *i2c,
[...]
>>> +       /* register the device to input subsystem */
>>> +       in_dev->name = DRIVER_TP;
>>> +       in_dev->id.bustype = BUS_I2C;
>>> +       in_dev->dev.parent = &i2c->dev;
>>> +       __set_bit(EV_SYN, in_dev->evbit);
>>> +       __set_bit(EV_KEY, in_dev->evbit);
>>> +       __set_bit(EV_ABS, in_dev->evbit);
>>> +       __set_bit(BTN_TOUCH, in_dev->keybit);
>>> +
>>> +       input_set_abs_params(in_dev, ABS_X, 0, x_max, 0, 0);
>>> +       input_set_abs_params(in_dev, ABS_Y, 0, y_max, 0, 0);
>>> +       input_set_abs_params(in_dev, ABS_PRESSURE, 0, MAX_PRESSURE, 0, 0);
>>> +       input_set_abs_params(in_dev, ABS_TOOL_WIDTH, 0, MAX_TOOL_WIDTH, 0, 0);
>>> +
>>> +       if (pdata->multi_touch) {
>>> +               input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0, x_max,
>>> +                                                                       0, 0);
>>> +               input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0, y_max,
>>> +                                                                       0, 0);
>>> +               input_set_abs_params(in_dev, ABS_MT_TOUCH_MAJOR, 0,
>>> +                                               MAX_TOUCH_MAJOR, 0, 0);
>>> +               input_set_abs_params(in_dev, ABS_MT_TOUCH_MINOR, 0,
>>> +                                               MAX_TOUCH_MINOR, 0, 0);
>>> +               input_set_abs_params(in_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
>>> +               input_set_abs_params(in_dev, ABS_MT_WIDTH_MAJOR, 0,
>>> +                                               MAX_TOOL_WIDTH, 0, 0);


TOUCH_MAJOR/MINOR and ORIENTATION are not used anywhere.

Thanks,
Henrik
