From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH 5/6] HID: Add vendor specific usage pages for Logitech G920
Date: Tue, 10 Nov 2015 22:38:27 +0100
Message-ID: <CADbOyBQFFCpSrg36STiegvyBJwgFWwdcewhfxepuZ68DZjvY9Q@mail.gmail.com>
References: <1446912609-2573-1-git-send-email-simon@mungewell.org>
	<1446912609-2573-6-git-send-email-simon@mungewell.org>
	<CAN+gG=FTGXyV1heOpQb9Y=ZVRHhYP8=N-3jKgYq8OnqHgT=ikg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35172 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbKJVi1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2015 16:38:27 -0500
In-Reply-To: <CAN+gG=FTGXyV1heOpQb9Y=ZVRHhYP8=N-3jKgYq8OnqHgT=ikg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@velds.nl>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, Nov 9, 2015 at 9:20 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Sat, Nov 7, 2015 at 5:10 PM, Simon Wood <simon@mungewell.org> wrote:
>> The Logitech G920 uses a couple of vendor specific usage pages,
>> which results in incorrect number of axis/buttons being detected.
>>
>> This patch adds these pages to the 'ignore' list.
>>
>> Reported-by: Elias Vanderstuyft <elias.vds@gmail.com>
>> Signed-off-by: Simon Wood <simon@mungewell.org>
>> ---
>>  drivers/hid/hid-input.c | 2 +-
>>  include/linux/hid.h     | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index 53aeaf6..c120be5 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -959,7 +959,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>>                 set_bit(EV_REP, input->evbit);
>>                 goto ignore;
>>
>> -       case HID_UP_LOGIVENDOR:
>> +       case HID_UP_LOGIVENDOR: case HID_UP_LOGIVENDOR2: case HID_UP_LOGIVENDOR3:
>
> One line per case, please.

This is my fault, I followed the convention used some lines above:
"case HID_GD_SLIDER: case HID_GD_DIAL: case HID_GD_WHEEL:"
but we expected this would get comments ;-)

Cheers,
Elias
