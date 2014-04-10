From: Tolga Cakir <tolga@cevel.net>
Subject: Re: [PATCH 4/4] HID: microsoft: undefining ms_map_key_clear after
 usage
Date: Thu, 10 Apr 2014 02:02:25 +0200
Message-ID: <5345DF91.5050701@cevel.net>
References: <1396631237-11813-1-git-send-email-tolga@cevel.net> <CAN+gG=HFEcsVdmuf6o2GyfSmjWRansS02MVbXdjws7xVNp1QGw@mail.gmail.com>
Reply-To: tolga@cevel.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp03.udag.de ([62.146.106.29]:42813 "EHLO smtp03.udag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933480AbaDJAC2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Apr 2014 20:02:28 -0400
In-Reply-To: <CAN+gG=HFEcsVdmuf6o2GyfSmjWRansS02MVbXdjws7xVNp1QGw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Derya <derya.kiran@yahoo.de>, Jiri Kosina <jkosina@suse.cz>, Reyad Attiyat <reyad.attiyat@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Am 09.04.2014 22:42, schrieb Benjamin Tissoires:
> On Fri, Apr 4, 2014 at 1:07 PM, Tolga Cakir <tolga@cevel.net> wrote:
>> This is inspired by various other hid drivers.
>>
>> Signed-off-by: Tolga Cakir <tolga@cevel.net>
>> ---
>>   drivers/hid/hid-microsoft.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
>> index 5674c0c..5281d2d 100644
>> --- a/drivers/hid/hid-microsoft.c
>> +++ b/drivers/hid/hid-microsoft.c
>> @@ -211,6 +211,8 @@ static int ms_sidewinder_kb_quirk(struct hid_input *hi, struct hid_usage *usage,
>>          return 1;
>>   }
>>
>> +#undef ms_map_key_clear
>> +
> Not sure this is really needed. The macro is prefixed by ms_, so I
> will simply let it there.
>
> Cheers,
> Benjamin
Ouch, I've just rechecked hid-lenovo-tpkbd.c and it wasn't prefixed 
there and therefore
needed. My fault, I'm sorry.

Greetings,
Tolga Cakir
>>   static int ms_sidewinder_control(struct hid_device *hdev, __u8 setup)
>>   {
>>          struct ms_data *sc = hid_get_drvdata(hdev);
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

