From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Sat, 10 Apr 2010 20:00:59 +0200
Message-ID: <4E18664F-5C63-4A5B-AFC8-12CC9FD0FA3A@enac.fr>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr> <1270915489.3869.12.camel@lovely>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:56481 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab0DJSBG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 14:01:06 -0400
In-Reply-To: <1270915489.3869.12.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux@philmerk.de


Le 10 avr. 10 =E0 18:04, Christoph Fritz a =E9crit :

> Am Samstag, den 10.04.2010, 16:43 +0200 schrieb Stephane Chatty:
>> Added support for the eGalax dual-touch panel, found on the Asus =20
>> EeePC T101MT
>
>> +static void egalax_remove(struct hid_device *hdev)
>> +{
>> +	hid_hw_stop(hdev);
>> +	kfree(hid_get_drvdata(hdev));
>> +	hid_set_drvdata(hdev, NULL);
>> +}
>
> Why not using hid_hw_stop() instead of hid_set_drvdata()?
>

Er, actually for a previous driver Dmitry suggested to add this line =20
and I did it without trying to understand :-)

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
