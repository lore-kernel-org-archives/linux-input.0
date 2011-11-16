From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 16/16] HID: wiimote: Enable NO_INIT_REPORTS quirk
Date: Wed, 16 Nov 2011 18:49:44 +0100
Message-ID: <CANq1E4T-mMYgEZFSEcZnWZvPCBRg1J=f8zJSc-OOqVK9bJ9dsA@mail.gmail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
	<1321190839-3517-17-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1111161805250.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32768 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500Ab1KPRtp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 12:49:45 -0500
Received: by wwe5 with SMTP id 5so1184808wwe.1
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 09:49:44 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1111161805250.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 6:05 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 13 Nov 2011, David Herrmann wrote:
>
>> Newer bluetooth core supports the NO_INIT_REPORTS quirk. We need thi=
s for the
>> wiimote as it does not support report-initialization.
>> Also bump version level as we are almost feature complete now.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> ---
>> =A0drivers/hid/hid-wiimote-core.c | =A0 =A04 +++-
>> =A01 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimot=
e-core.c
>> index 745667e..7ea8754 100644
>> --- a/drivers/hid/hid-wiimote-core.c
>> +++ b/drivers/hid/hid-wiimote-core.c
>> @@ -22,7 +22,7 @@
>> =A0#include "hid-ids.h"
>> =A0#include "hid-wiimote.h"
>>
>> -#define WIIMOTE_VERSION "0.2"
>> +#define WIIMOTE_VERSION "0.3"
>
> Do we really need this?
>
> I generally prefer not having any file versioning for the files that =
are
> implicitly tracked by kernel git.

No, not at all. But I thought this was common practice. I have removed
it all together. The next series will be updated.

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs

Thanks
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
