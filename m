From: Ari Entlich <atrigent@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Fri, 7 Aug 2015 09:41:07 -0400
Message-ID: <CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
	<20150807132639.GB21627@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37735 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbbHGNlJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 09:41:09 -0400
Received: by wibhh20 with SMTP id hh20so66463899wib.0
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2015 06:41:07 -0700 (PDT)
In-Reply-To: <20150807132639.GB21627@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Aug 7, 2015 at 9:26 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> Hello,
>
> ALPS devices does not support pass-throw mode like Synaptics devices.

Hmm... Then what are all of these references to passthrough in alps.c?
Does the alps driver use the term "passthrough" in a different way
than the synaptics driver does?

Are we 100% sure that alps devices can't do this? Is there any
possibility that we just don't know how to do it?

Thanks.

Ari

> But our ALPS driver is good and can detect packet from device contain=
s
> data for touchpad or trackpoint. So ALPS driver create two input devi=
ces
> and send events to userspace via correct input device and userspace s=
ee
> that there are two different devices (touchpad and trackstick) and no=
t
> one "combined".
>
> Looks like that ALPS devices does not support any speed or accelerati=
on
> configuration, so everything needs to be implemented in software -- i=
n
> userspace. X drivers already have such configuration ether via xorg.c=
onf
> or runtime via xinput. Speed or acceleration can be configured per in=
put
> device, so this is something which you probably want.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
