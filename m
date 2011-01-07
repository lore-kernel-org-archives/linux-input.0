From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v3 0/5] hid-multitouch: a first step towards multitouch unification
Date: Fri, 7 Jan 2011 22:06:34 +0100
Message-ID: <AANLkTim1qw_=9Z23wtU5BxTUrzfGiEJRdR3naQUrTrpK@mail.gmail.com>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110107200850.GE29913@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49297 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1AGVGf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 16:06:35 -0500
In-Reply-To: <20110107200850.GE29913@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 7, 2011 at 9:08 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Hi Benjamin,
>
>> here is the v3.
>>
>> all changes are coming from the mails with Henrik:
>>
>> - restricted to new drivers only
>> - delete mt_buffer struct
>> - replace/adapt prev_valid in favor of seen_in_this_frame
>> - integrated fuzz
>> - introduce MT_QUIRKS
>> - other small fixes
>
> A lot of progress in one day - thank you very much for making the
> changes. I will be online for quite a bit longer in case there is mor=
e
> coming this way. With some testing over the weekend (I will be
> traveling, sorry), it doesn't look impossible to have this ready earl=
y
> next week.

=46or my part, I'm a bit tired, and I don't have any device at home to
test. I wont publish anything for the evening as I will for sure
introduce bugs.

Good night,
Benjamin

>
> Cheers,
> Henrik
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
