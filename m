From: Benjamin Tissoires <tissoire@cena.fr>
Subject: Re: [PATCH 3/3] HID: deletion of unused code in hid-magicmouse.
Date: Wed, 10 Mar 2010 16:39:51 +0100
Message-ID: <4B97BD47.5050004@cena.fr>
References: <1268065277-30129-1-git-send-email-tissoire@cena.fr> <1268065277-30129-2-git-send-email-tissoire@cena.fr> <1268065277-30129-3-git-send-email-tissoire@cena.fr> <1268065277-30129-4-git-send-email-tissoire@cena.fr> <1268065277-30129-5-git-send-email-tissoire@cena.fr> <4B95255B.5010900@cena.fr> <alpine.LNX.2.00.1003081730170.17799@pobox.suse.cz> <4B952C77.3080505@cena.fr> <alpine.LNX.2.00.1003101607560.18642@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fw.tls.cena.fr ([195.83.98.200]:42986 "EHLO
	mailhost.tls.cena.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723Ab0CJPjz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Mar 2010 10:39:55 -0500
In-Reply-To: <alpine.LNX.2.00.1003101607560.18642@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

No problem, this patch had a meaning only with the 2 others Micheal=20
already reviewed.

The core idea of the series of patch was to register the fields in the=20
newly created report in order to having two benefits:
- use the input created by hid-input (not required anymore as you=20
integrated Michael's patch) and suppress the second input created by=20
hand (this is why the patch n=B03 named "HID: deletion of unused code i=
n=20
hid-magicmouse" suppress everything related to this input)
- recreate the fields in the report descriptor in order to avoid using=20
the raw event in a later patch.

I have now to look on how can we register fields in a report that are=20
non mandatory. Michael told me that he did not found it too.
After that, I will probably resend a better patch.

Cheers,
Benjamin


Le 10/03/2010 16:09, Jiri Kosina a =E9crit :
> On Mon, 8 Mar 2010, Benjamin Tissoires wrote:
>
>>> Well ... I don't see any patch titled "HID: deletion of unused code=
 in
>>> hid-magicmouse" neither in my inbox nor in my linux-input@ folder. =
Could
>>> you perhaps please resend?
>>>
>>> Thanks,
>>
>> Of course, I attached it. Do I need to send it in mbox format or is =
it ok ?
>
> Well, magicmouse_setup_input() is actually used from inside the probe
> routine, so we'd rather not remove it.
>
> I have already merged Michael's patch with calls hid_hw_start() with
> HID_CONNECT_HIDINPUT flag cleared out, so the registration of the inp=
ut
> device is now performed properly.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
