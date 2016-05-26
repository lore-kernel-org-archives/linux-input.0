From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] input/alps: Add device description for Dell Latitude
 E7470
Date: Thu, 26 May 2016 14:19:18 +0200
Message-ID: <5b09ed5d-838b-b319-1272-e9ca4c9bc627@redhat.com>
References: <201605251801.45240@pali>
 <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
 <1464252914-11450-4-git-send-email-ben@smart-cactus.org>
 <20160526090509.GE29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41921 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbcEZMTZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 08:19:25 -0400
In-Reply-To: <20160526090509.GE29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Ben Gamari <ben@smart-cactus.org>
Cc: linux-input@vger.kernel.org, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>

Hi,

On 26-05-16 11:05, Pali Roh=C3=A1r wrote:
> On Thursday 26 May 2016 10:55:14 Ben Gamari wrote:
>> ---
>>  drivers/input/mouse/alps.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index 10e6836..eb4bf31 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -143,6 +143,7 @@ static const struct alps_model_info alps_model_d=
ata[] =3D {
>>  	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
>>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Tosh=
iba Tecra A11-11L */
>>  	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
>> +	{ { 0x73, 0x03, 0x28 }, 0x00, { ALPS_PROTO_V8, 0x18, 0x18, ALPS_SS=
4_V2_ALT_DECODING | ALPS_DUALPOINT } }, /* Dell Latitude E7470 */
>>  };
>>
>>  static const struct alps_protocol_info alps_v3_protocol_data =3D {
>
> Hi! I would rather move this code into alps_identify and probably cre=
ate
> alps_v8_ss<name>_data structure for it.
>
> Above alps_model_data list looks like hooks for special touchpads whi=
ch
> needs more flags to work correctly...

Agreed, the alps_model_data array is really only used for quirks for ol=
d touchpads
and should not be used for new touchpads.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
