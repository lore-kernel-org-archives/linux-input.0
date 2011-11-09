From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH] Input: elantech: adjust hw_version detection logic
Date: Wed, 09 Nov 2011 06:28:36 +0100
Message-ID: <4EBA0F84.5030809@tudelft.nl>
References: <1320754099-2669-1-git-send-email-jj_ding@emc.com.tw> <1998016.KAbb3SKMtM@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:53310 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab1KIF2m (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Nov 2011 00:28:42 -0500
In-Reply-To: <1998016.KAbb3SKMtM@ax5200p>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: JJ Ding <jj_ding@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Op 08-11-11 18:55, Marc Dietrich schreef:
> hi Jj,
>
> On Tuesday 08 November 2011 20:08:19 JJ Ding wrote:
>> This patch fixes some v3 hardware (fw_version: 0x150500) wrongly det=
ected
>> as v2 hardware.
>>
>> Reported-by: Marc Dietrich<marvin24@gmx.de>
>> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
>> ---
>> Hi list,
>>
>> This is patched against v3.2-rc1.
>>
>> Marc, could you please test this again? Thanks a lot.
Indeed, it looks good :-)
Acked-by: =C9ric Piel <eric.piel@tremplin-utc.net>

>
> patch works fine here. You may add:
>
> 	Tested-By: Marc Dietrich<marvin24@gmx.de>
>
> Btw, are there any known issues with suspend/resume? The touchpad doe=
sn't seem
> to wakeup again after resume, but that's propably a problem of our kb=
d
> controller driver. Just in case there's something known...
Just for the info, I've never received any reports of problems with the=
=20
suspend/resume (nor noticed any).

See you,
=C9ric

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
