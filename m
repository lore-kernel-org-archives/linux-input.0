From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 6/6] hid-multitouch: class MT_CLS_STANTUM is redundant
 with MT_CLS_CONFIDENCE
Date: Fri, 20 May 2011 12:32:23 +0200
Message-ID: <BANLkTim1nGEbBo2Zf6gfTzAAZJK5vmpy6A@mail.gmail.com>
References: <1305807498-8785-1-git-send-email-benjamin.tissoires@enac.fr>
	<1305807498-8785-7-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1105201031560.28291@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53240 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935523Ab1ETKcY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 May 2011 06:32:24 -0400
In-Reply-To: <alpine.LNX.2.00.1105201031560.28291@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 20, 2011 at 10:35, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 19 May 2011, Benjamin Tissoires wrote:
>
>> Stantum devices used to work with MT_CLS_STANTUM but MT_CLS_CONFIDEN=
CE
>> is exactly the same. This patch switches them to this generic class,
>> and remove the unused MT_CLS_STANTUM.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>> =A0drivers/hid/hid-multitouch.c | =A0 =A09 +++------
>> =A01 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index feeb0b7..65b92d2 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -88,7 +88,6 @@ struct mt_class {
>> =A0#define MT_CLS_DUAL_INRANGE_CONTACTNUMBER =A0 =A03
>> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 4
>> =A0#define MT_CLS_EGALAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A05
>> -#define MT_CLS_STANTUM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 6
>> =A0#define MT_CLS_3M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A07
>> =A0#define MT_CLS_CONFIDENCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
8
>> =A0#define MT_CLS_CONFIDENCE_MINUS_ONE =A0 =A0 =A0 =A0 =A09
>
> Benjamin,
>
> is it intentional that you are leaving the hole in the numbering here=
?
>
> I don't think there would be any issue with re-numbering 7-10, would =
it?

Well, the first time I tried to renumber those classes (to keep them
alphabetically sorted), I've been told not to do it. That's why I let
the hole in this case.
There won't be any issue in renumbering those classes (and we could sor=
t them).
Maybe I can just send a new patch on top of this to sort them.

Cheers,
Benjamin

PS: and thank you very much for applying so quickly the last patches I =
sent.

>
> --
> Jiri Kosina
> SUSE Labs
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
