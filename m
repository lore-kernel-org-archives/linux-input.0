From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 0/3] input - wacom_w8001: support one finger touch etc.
Date: Fri, 17 Dec 2010 18:47:25 -0600
Message-ID: <AANLkTinpXbGAx=3C=eocsAFcWVift4xAwFfkyWLxYQr_@mail.gmail.com>
References: <1292607369-22534-1-git-send-email-pinglinux@gmail.com>
	<AANLkTim3XdFHEtcaJOCre22ECVKPDgwagHT71Cxq1yc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:32850 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab0LRAr0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 19:47:26 -0500
Received: by ywl5 with SMTP id 5so594202ywl.19
        for <linux-input@vger.kernel.org>; Fri, 17 Dec 2010 16:47:25 -0800 (PST)
In-Reply-To: <AANLkTim3XdFHEtcaJOCre22ECVKPDgwagHT71Cxq1yc3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Yes, they do.  It seems to send events consistent with wacom_wac.c.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

On Fri, Dec 17, 2010 at 3:21 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> Hi Chris,
>
> Does this patchset address your comments? I didn't add your
> reviewed-by since I want to get it from you directly.
>
> Thank you.
>
> Ping
>
> On Fri, Dec 17, 2010 at 9:36 AM, Ping Cheng <pinglinux@gmail.com> wro=
te:
>> This is the v2 of adding one finger touch support for Wacom serial t=
ouchscreen.
>> It converts input_dev->keybit to __set_bit, supports pen or touch on=
ly devices,
>> and adds one finger touch support to the driver.
>>
>> The patchset is based on git://git.kernel.org/pub/scm/linux/kernel/g=
it/dtor/input.git next
>>
>> Ping Cheng (3):
>> =A0 =A0 =A0input - wacom_w8001: use __set_bit to set keybits
>> =A0 =A0 =A0input - wacom_w8001: Support pen or touch only devices
>> =A0 =A0 =A0input - wacom_w8001: Add one finger touch support
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
