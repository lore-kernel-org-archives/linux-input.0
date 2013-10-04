From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/2] Input: wacom - add support for three new Intuos devices
Date: Fri, 4 Oct 2013 09:47:26 -0700
Message-ID: <CANRwn3RRtsWF4j9TsmUMfC=W_XaUNCazbo8PSTEtR1iZYUPu0A@mail.gmail.com>
References: <1380833590-25267-1-git-send-email-pingc@wacom.com>
	<2980943.RVh73cvMGD@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53096 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab3JDQr1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Oct 2013 12:47:27 -0400
Received: by mail-qa0-f53.google.com with SMTP id k4so1226017qaq.19
        for <linux-input@vger.kernel.org>; Fri, 04 Oct 2013 09:47:26 -0700 (PDT)
In-Reply-To: <2980943.RVh73cvMGD@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pingc@wacom.com>

On Thu, Oct 3, 2013 at 2:54 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thursday, October 03, 2013 01:53:10 PM Ping Cheng wrote:
>> This series of models added a hardware switch to turn touch
>> data on/off. To report the state of the switch, SW_TOUCH_ENABLED
>> is added in include/uapi/linux/input.h.
>
>
> Hmm, should we just postpone creating of input device until touch is =
enabled
> instead?
>
> --
> Dmitry
> --

The idea of SW_TOUCH_ENABLED is to allow userspace to be a bit more
helpful and display a "disabled" message rather than disappearing the
device entirely when the switch is 'off'. In theory this could also be
achieved through the libwacom support library (by scanning the list of
event devices to see if any of the expected interfaces are missing),
but the approach is somewhat fragile and I'm not convinced that
linking the switch to device creation/removal is correct.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
