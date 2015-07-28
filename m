From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH] Input: zforce_ts - fix playload length check
Date: Tue, 28 Jul 2015 13:28:32 +0200
Message-ID: <55B76760.10406@de.bosch.com>
References: <20150727210619.GA2825@dtor-ws>
 <CAMuHMdWAudXRafuey2whrZUaff4PZZBCt8823femWr7v44q+Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:16708 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbG1L2f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 07:28:35 -0400
In-Reply-To: <CAMuHMdWAudXRafuey2whrZUaff4PZZBCt8823femWr7v44q+Ww@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Heiko Stuebner <heiko.stuebner@bq.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 28.07.2015 12:23, Geert Uytterhoeven wrote:
> On Mon, Jul 27, 2015 at 11:06 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Commit 7d01cd261c76f95913c81554a751968a1d282d3a ("Input: zforce - do=
n't
>> overwrite the stack") attempted to add a check for payload size bein=
g too
>> large for the supplied buffer. Unfortunately with the currently sele=
cted
>> buffer size the comparison is always false as buffer size is larger =
than
>> the value a single byte can hold, and that results in compiler warni=
ngs.
>> Additionally the check was incorrect as it was not accounting for th=
e
>> already read 2 bytes of data stored in the buffer.
>
> The check was indeed incorrect.
>
>> Fixes: 7d01cd261c76f95913c81554a751968a1d282d3a
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>
>> This seems to shut up my GCC, I wonder if it is going to work gfor
>> everyone or we better add BUILD_BUG_ON(FRAME_MAXSIZE < 257) and a
>> comment and remove check.
>>
>>   drivers/input/touchscreen/zforce_ts.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/t=
ouchscreen/zforce_ts.c
>> index 2554efd..542ff02 100644
>> --- a/drivers/input/touchscreen/zforce_ts.c
>> +++ b/drivers/input/touchscreen/zforce_ts.c
>> @@ -441,7 +441,9 @@ static int zforce_read_packet(struct zforce_ts *=
ts, u8 *buf)
>>                  goto unlock;
>>          }
>>
>> -       if (buf[PAYLOAD_LENGTH] =3D=3D 0 || buf[PAYLOAD_LENGTH] > FR=
AME_MAXSIZE) {
>> +       if (buf[PAYLOAD_LENGTH] =3D=3D 0 ||
>> +           (FRAME_MAXSIZE - 2 < 255 &&
>> +            buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE - 2)) {
>
> Doesn't help with gcc 4.1.2 :-(
>
> Before:
>
> drivers/input/touchscreen/zforce_ts.c: In function =E2=80=98zforce_re=
ad_packet=E2=80=99:
> drivers/input/touchscreen/zforce_ts.c:432: warning: comparison is
> always false due to limited range of data type
>
> After:
>
> drivers/input/touchscreen/zforce_ts.c: In function =E2=80=98zforce_re=
ad_packet=E2=80=99:
> drivers/input/touchscreen/zforce_ts.c:434: warning: comparison is
> always false due to limited range of data type


If it's easier, then just revert 7d01cd261c76f95913c81.

Sorry! It seems that at least 4 people have overlooked this issue :(

Best regards

Dirk

Btw: Could anybody give me a hint how to get this warning? My GCC 4.8.1=
=20
with kernel default ARM Cortex A9 kernel options doesn't give me=20
anything about this.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
