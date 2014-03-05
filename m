From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: Unknown ALPS device
Date: Wed, 5 Mar 2014 21:00:24 +0800
Message-ID: <CA+F6ckN5fHkf=BU9vEtSLOXog77dL39QwE7cLJTpN5hAQas58A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:45309 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbaCENAZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Mar 2014 08:00:25 -0500
Received: by mail-la0-f52.google.com with SMTP id ec20so676470lab.11
        for <linux-input@vger.kernel.org>; Wed, 05 Mar 2014 05:00:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hanno@hboeck.de
Cc: ag4ve.us@gmail.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vge=
r.kernel.org] On Behalf Of Hanno Bock
> Sent: Friday, February 28, 2014 12:30 AM
> To: shawn wilson
> Cc: linux-input@vger.kernel.org
> Subject: Re: Unknown ALPS device
>
> On Thu, 27 Feb 2014 11:28:10 -0500
> shawn wilson <ag4ve.us@gmail.com> wrote:
>
>> What kernel are you running? My ALPS device is identified correctly
>> and seems to work on 3.13 (IIRC, it also worked with 3.12 but not
>> before).
>
> 3.13 also here.
>
> Just to make it clear: The device works. It just shows me a message t=
hat I'd consider a warning that the device is "Unknown"
> and it might be better (support more features?) if the kernel new abo=
ut it and wouldn't consider it unknown.

Hi Hanno,

I checked touchpad driver of ThinkPad T61 on Lenovo's website and
found it seems use Synaptics's device.
Maybe that's why ALPS kernel driver could not recognize it correctly.

http://support.lenovo.com/en_US/detail.page?LegacyDocID=3DMIGR-67853
# Please search by keyword "Mouse".

Thanks
--=20
Best Regards,
Tommy Will

>
> --
> Hanno B=F6ck
> http://hboeck.de/
>
> mail/jabber: hanno@hboeck.de
> GPG: BBB51E42
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
