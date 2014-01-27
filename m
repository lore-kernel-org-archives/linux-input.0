From: Luis Ortega <luiorpe1@upv.es>
Subject: Re: [PATCH 2/4] Input: zforce - fix lines exceeding 80 columns
Date: Mon, 27 Jan 2014 20:29:33 +0100
Message-ID: <CAHLRGxzc4Zcj4Td1VMVPtWHn2mrscMn5W9u271RVTQ1eOzNufg@mail.gmail.com>
References: <1390848373-7723-1-git-send-email-luiorpe1@upv.es>
 <1390848373-7723-3-git-send-email-luiorpe1@upv.es> <1864335.qYXGSfrppl@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:65091 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbaA0T3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 14:29:54 -0500
In-Reply-To: <1864335.qYXGSfrppl@phil>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Luis Ortega <luiorpe1@upv.es>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Yeah, I also ran checkpatch on the file and it had nothing to report.
Unfortunately those lines are slightly long and got word wrapped in my
editor, disrupting the flow of text. I thought fixing them wouldn't hur=
t.

On Mon, Jan 27, 2014 at 8:12 PM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> On Monday, 27. January 2014 19:46:11 Luis Ortega wrote:
>> Fixed lines exceeding 80 characters long wherever possible,
>> as per the coding style.
>>
>> Signed-off-by: Luis Ortega <luiorpe1@upv.es>
>
> checkpatch did not complain on the initial submission, so I guess it'=
s more an
> issue of taste. Nevertheless I don't have a preference for one way or=
 the
> other, so
>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
>
>> ---
>>  drivers/input/touchscreen/zforce_ts.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/zforce_ts.c
>> b/drivers/input/touchscreen/zforce_ts.c index c145c1d..c1b6b82 10064=
4
>> --- a/drivers/input/touchscreen/zforce_ts.c
>> +++ b/drivers/input/touchscreen/zforce_ts.c
>> @@ -235,7 +235,8 @@ static int zforce_scan_frequency(struct zforce_t=
s *ts,
>> u16 idle, u16 finger, (finger & 0xff), ((finger >> 8) & 0xff),
>>                       (stylus & 0xff), ((stylus >> 8) & 0xff) };
>>
>> -     dev_dbg(&client->dev, "set scan frequency to (idle: %d, finger=
: %d,
>> stylus: %d)\n", +     dev_dbg(&client->dev,
>> +             "set scan frequency to (idle: %d, finger: %d, stylus: =
%d)\n",
>>               idle, finger, stylus);
>>
>>       return zforce_send_wait(ts, &buf[0], ARRAY_SIZE(buf));
>> @@ -332,7 +333,8 @@ static int zforce_touch_event(struct zforce_ts *=
ts, u8
>> *payload)
>>
>>       count =3D payload[0];
>>       if (count > ZFORCE_REPORT_POINTS) {
>> -             dev_warn(&client->dev, "too many coordinates %d, expec=
ted max %d\n",
>> +             dev_warn(&client->dev,
>> +                      "too many coordinates %d, expected max %d\n",
>>                        count, ZFORCE_REPORT_POINTS);
>>               count =3D ZFORCE_REPORT_POINTS;
>>       }
>> @@ -494,8 +496,8 @@ static irqreturn_t zforce_irq_thread(int irq, vo=
id
>> *dev_id) while (!gpio_get_value(pdata->gpio_int)) {
>>               ret =3D zforce_read_packet(ts, payload_buffer);
>>               if (ret < 0) {
>> -                     dev_err(&client->dev, "could not read packet, =
ret: %d\n",
>> -                             ret);
>> +                     dev_err(&client->dev,
>> +                             "could not read packet, ret: %d\n", re=
t);
>>                       break;
>>               }
>>
>> @@ -539,7 +541,8 @@ static irqreturn_t zforce_irq_thread(int irq, vo=
id
>> *dev_id) payload[RESPONSE_DATA + 4];
>>                       ts->version_rev   =3D (payload[RESPONSE_DATA +=
 7] << 8) |
>>                                               payload[RESPONSE_DATA =
+ 6];
>> -                     dev_dbg(&ts->client->dev, "Firmware Version %0=
4x:%04x %04x:
> %04x\n",
>> +                     dev_dbg(&ts->client->dev,
>> +                             "Firmware Version %04x:%04x %04x:%04x\=
n",
>>                               ts->version_major, ts->version_minor,
>>                               ts->version_build, ts->version_rev);
>>
>> @@ -552,7 +555,8 @@ static irqreturn_t zforce_irq_thread(int irq, vo=
id
>> *dev_id) break;
>>
>>               default:
>> -                     dev_err(&ts->client->dev, "unrecognized respon=
se id: 0x%x\n",
>> +                     dev_err(&ts->client->dev,
>> +                             "unrecognized response id: 0x%x\n",
>>                               payload[RESPONSE_ID]);
>>                       break;
>>               }
>> @@ -618,7 +622,8 @@ static int zforce_suspend(struct device *dev)
>>
>>               enable_irq_wake(client->irq);
>>       } else if (input->users) {
>> -             dev_dbg(&client->dev, "suspend without being a wakeup =
source\n");
>> +             dev_dbg(&client->dev,
>> +                     "suspend without being a wakeup source\n");
>>
>>               ret =3D zforce_stop(ts);
>>               if (ret)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
