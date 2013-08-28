From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 14/14] HID: check for NULL field when setting values
Date: Wed, 28 Aug 2013 14:14:22 -0700
Message-ID: <CAGXu5jJXJVZR8=q0b6joVyXtrJC1NNeoQ81WfJkq4umcjRVDnQ@mail.gmail.com>
References: <alpine.LNX.2.00.1308282223090.22181@pobox.suse.cz>
	<alpine.LNX.2.00.1308282232080.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52486 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3H1VOY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 17:14:24 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so9427266iea.23
        for <linux-input@vger.kernel.org>; Wed, 28 Aug 2013 14:14:22 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1308282232080.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wed, Aug 28, 2013 at 1:32 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 28 Aug 2013, Jiri Kosina wrote:
>
>> From: Kees Cook <keescook@chromium.org>
>>
>> Defensively check that the field to be worked on is not NULL.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: stable@kernel.org
>> ---
>>  drivers/hid/hid-core.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 55798b2..192be6b 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1206,7 +1206,12 @@ EXPORT_SYMBOL_GPL(hid_output_report);
>>
>>  int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
>>  {
>> -     unsigned size = field->report_size;
>> +     unsigned size;
>> +
>> +     if (!field)
>> +             return -1;
>> +
>> +     size = field->report_size;
>
> Kees,
>
> do you actually see any way how field could ever be null in
> hid_set_field()?

Yes, report->field[0] may be uninitialized (NULL due to kzalloc) if
hid_add_field() bails out during the padding field check:

        if (!parser->local.usage_index) /* Ignore padding fields */
                return 0;

The report will be registered (earlier call to hid_register_report()
was successful), but the entire field list will be NULL.

The hid-ntrig.c fix is a fix for such a problem
(report->field[0]->value[0]) where field[0] can be NULL. I was able to
make a reproduction case for this, with the crash can be seen in the
hid-ntrig.c patch.

-Kees

-- 
Kees Cook
Chrome OS Security
