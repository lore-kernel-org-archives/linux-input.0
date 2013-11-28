From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [RFC][PATCH] Input: define keys for WWAN and SES
Date: Thu, 28 Nov 2013 13:32:59 +0100
Message-ID: <CACna6rz58KybJ4dMPWUwXzR6QkQXnkdu_5zvQWteBaepikS0UA@mail.gmail.com>
References: <1385639293-23225-1-git-send-email-zajec5@gmail.com>
	<529731CB.3010107@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:44999 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab3K1MdA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 07:33:00 -0500
Received: by mail-ob0-f176.google.com with SMTP id va2so8654822obc.21
        for <linux-input@vger.kernel.org>; Thu, 28 Nov 2013 04:32:59 -0800 (PST)
In-Reply-To: <529731CB.3010107@hauke-m.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

2013/11/28 Hauke Mehrtens <hauke@hauke-m.de>:
> On 11/28/2013 12:48 PM, Rafa=C5=82 Mi=C5=82ecki wrote:
>> This is just a RFC, so be nice to this "patch", please ;)
>>
>> My goal is to add support for buttons on bcm47xx arch. However after
>> analyzing existing database of devices I realized I don't know what =
code
>> I should assign to some buttons.
>>
>> First of all, older routers often have a "SES" button. SES stands fo=
r
>> SecureEasySetup and is Broadcom's proprietary protocol which was lat=
er
>> replaced with WPS (Wi-Fi Protected Setup).
>> Btw. WPS appeared to be broken because it's easy to attack it with
>> brutal-force method.
>
> Only a badly implemented WPS pin authentication is vulnerable to the
> brute force attack, as far as I know.

Oh, indeed, I missed that. Thanks!

>> I'm not sure if any distribution have any interest
>> in using that buttons, but it still would be nice to have support fo=
r
>> them in kernel. One option is to add KEY_SES for this purpose.
>> Is this the right way? It's similar to the KEY_WPS_BUTTON, but I wan=
ted
>> to somehow distinct them. Is there any other option? Should I use
>> KEY_UNKNOWN or BTN_MISC or BTN_n?
>
> I do not think you or someone else plans to implement SecureEasySetup=
 on
> a device running current Linux kernel, why not use the WPS button key
> for for these button. If someone wants to implement this just use the
> WPS button key for that.

I'm just not sure about possible scenarios. I imagined end-user
pressing SES button router and SES button on a device and complaining
it's not working (because of SES being interpreted as WPS).

If you guys think we should just use WPS for the SES button, I'm OK wit=
h that.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
