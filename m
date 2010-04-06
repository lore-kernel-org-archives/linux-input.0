From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Fix for N-trig touch panel with recent firmware
Date: Tue, 6 Apr 2010 23:12:59 +0200
Message-ID: <01FA5ACC-E06A-4F52-ACFC-53843EC4D7BE@enac.fr>
References: <20100406202258.837F19520E@smtp.lii-enac.fr> <alpine.LNX.2.00.1004062302310.8345@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:36926 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824Ab0DFVNN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Apr 2010 17:13:13 -0400
In-Reply-To: <alpine.LNX.2.00.1004062302310.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Micki Balanga <micki@n-trig.com>, Rafi Rubin <rafi@seas.upenn.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


Le 6 avr. 10 =E0 23:06, Jiri Kosina a =E9crit :
>>
>> +	report =3D hdev->report_enum[HID_FEATURE_REPORT].report_id_hash=20
>> [0x0a];
>> +	if (report)
>> +		usbhid_submit_report(hdev, report, USB_DIR_OUT);
>> +
>> +
>
> Thanks guys, I have queued the patch in my tree.
>
> I will also put a one-line comment above this chunk of code to =20
> explain why
> is it actually needed, if you don't mind.

Thanks, and sorry for forgetting the comment.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
