From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH] hid-debug: Show application usage for each collection.
Date: Wed, 24 Aug 2011 11:58:03 -0700
Message-ID: <CAMu+ixjg71wR9_WLqEihGtud0=SuRdnc=4nB43F+pxjNpdEKug@mail.gmail.com>
References: <1313451542-79316-1-git-send-email-jeffbrown@android.com> <CAN+gG=ETNmP4Xy7NhxLpkaqAog4T1PQ5eCdXF11SvR2Ce+DtHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57684 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab1HXS6o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 14:58:44 -0400
In-Reply-To: <CAN+gG=ETNmP4Xy7NhxLpkaqAog4T1PQ5eCdXF11SvR2Ce+DtHA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@euromail.se

On Tue, Aug 16, 2011 at 12:32 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Tue, Aug 16, 2011 at 01:39, =A0<jeffbrown@android.com> wrote:
>> From: Jeff Brown <jeffbrown@android.com>
>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@logitech.com>

Just a friendly ping.

Do I need to do anything more on this, or on the other patch to hid-mul=
titouch?

>> Signed-off-by: jeffbrown@android.com
>> ---
>> =A0drivers/hid/hid-debug.c | =A0 =A05 +++++
>> =A01 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
>> index bae4874..9a243ca 100644
>> --- a/drivers/hid/hid-debug.c
>> +++ b/drivers/hid/hid-debug.c
>> @@ -450,6 +450,11 @@ void hid_dump_field(struct hid_field *field, in=
t n, struct seq_file *f) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seq_printf(f, "Logical(");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_resolv_usage(field->logical, f); =
seq_printf(f, ")\n");
>> =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 if (field->application) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tab(n, f);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(f, "Application(");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_resolv_usage(field->application, f=
); seq_printf(f, ")\n");
>> + =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0tab(n, f); seq_printf(f, "Usage(%d)\n", field->maxusa=
ge);
>> =A0 =A0 =A0 =A0for (j =3D 0; j < field->maxusage; j++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tab(n+2, f); hid_resolv_usage(field->=
usage[j].hid, f); seq_printf(f, "\n");
>> --
>> 1.7.0.4
>>
>> --
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
