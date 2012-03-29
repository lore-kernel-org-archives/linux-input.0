From: "Przemo Firszt" <przemo@firszt.eu>
Subject: Re: [PATCH 2/2] HID: wacom: Add module description
Date: Thu, 29 Mar 2012 16:08:49 +0100
Message-ID: <9e2b626b76c74a25e2cf5eac9bb1437f.squirrel@webmail.firszt.eu>
References: <1332969217-10727-1-git-send-email-przemo@firszt.eu>
    <1332969217-10727-3-git-send-email-przemo@firszt.eu>
    <alpine.LNX.2.00.1203291641330.25526@pobox.suse.cz>
Reply-To: przemo@firszt.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:46747 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932634Ab2C2PJF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 11:09:05 -0400
In-Reply-To: <alpine.LNX.2.00.1203291641330.25526@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Przemo Firszt <przemo@firszt.eu>, pinglinux@gmail.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org


Dnia 29 Marca 2012, 3:46 pm, Cz, Jiri Kosina napisa=B3(a):
> On Wed, 28 Mar 2012, Przemo Firszt wrote:
>
>> Add description for hid-wacom module: "Driver for Wacom Graphire
>> Bluetooth
>> and Wacom Intuos4 WL"
>>
>> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
>> ---
>>  drivers/hid/hid-wacom.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
>> index f130f40..fb0fe16 100644
>> --- a/drivers/hid/hid-wacom.c
>> +++ b/drivers/hid/hid-wacom.c
>> @@ -687,5 +687,5 @@ static void __exit wacom_exit(void)
>>
>>  module_init(wacom_init);
>>  module_exit(wacom_exit);
>> +MODULE_DESCRIPTION("Driver for Wacom Graphire Bluetooth and Wacom
>> Intuos4 WL");
>
> I am a little bit unsure about having the information about supported
> models duplicate in Kconfig and MODULE_DESCRIPTION() ... it's just ad=
ding
> more places that we will forget to update once support for a new devi=
ce
> line is added.
>
> Applied, but not fully convinced.
>
Hi Jiri,
Thanks! I'll come back to this issue later - I have to test an idea..
--=20
Regards,
Przemo Firszt

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
