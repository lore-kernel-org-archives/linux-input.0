From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 4/4] hid-multitouch: migrated support for MosArt panels
Date: Thu, 14 Oct 2010 14:34:01 +0200
Message-ID: <91E93F68-B6CD-4D27-9304-CFE6FBCF1B5E@enac.fr>
References: <20101013223514.E383A9522F@smtp.lii-enac.fr> <4CB6F2D4.2040308@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:43401 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab0JNMeL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 08:34:11 -0400
In-Reply-To: <4CB6F2D4.2040308@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@lii-enac.fr>, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org


Le 14 oct. 10 =E0 14:08, Henrik Rydberg a =E9crit :
>>
>> +static int mosart_compute_slot(struct mt_device *td)
>> +{
>> +	return td->curcontactid - 1;
>> +}
>
>
> What is the range of reported values from the firmware here?
>

[1, 2]

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
