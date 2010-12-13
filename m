From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: Re: [PATCH v2 1/2] input: keyboard: MCS5080: support suspend/resume.
Date: Mon, 13 Dec 2010 19:20:39 +0900
Message-ID: <4D05F377.2060507@samsung.com>
References: <4CE6179A.5050404@samsung.com>
 <20101213090026.GF21401@core.coreip.homeip.net>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50016 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab0LMKUs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 05:20:48 -0500
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LDD0007M3EFWBD0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Mon, 13 Dec 2010 19:20:39 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LDD00F063EFQO@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 13 Dec 2010 19:20:39 +0900 (KST)
In-reply-to: <20101213090026.GF21401@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

2010-12-13 =EC=98=A4=ED=9B=84 6:00, Dmitry Torokhov =EC=93=B4 =EA=B8=80=
:
> Hi Kim,
>=20
> On Fri, Nov 19, 2010 at 03:22:18PM +0900, Kim, HeungJun wrote:
>> This patch supports suspend/resume functions for mcs5080 touchkey
>> driver.
>>
> ...
>=20
>> @@ -181,6 +188,9 @@ static int __devinit mcs_touchkey_probe(struct i=
2c_client *client,
>>  		goto err_free_irq;
>> =20
>>  	i2c_set_clientdata(client, data);
>> +
>> +	pm_runtime_set_active(&client->dev);
>> +
>=20
> Why is this required? Won't this effectively disable PM suspend/resum=
e?

Actually, this part marks system as "ACTIVE".=20
So, I know that, if there is not this part, the pm framework skip previ=
ous suspend() or rumtime-pm suspend(),
when the system into suspend doing like, # echo mem > /sys/power/state.
Then, this part is needed I think.

If I'm wrong, let me know.

Thank.

Regards,
HeungJun Kim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
