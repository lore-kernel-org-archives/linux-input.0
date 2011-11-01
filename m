From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v7 0/3] Input: Cypress TTSP device driver
Date: Tue, 1 Nov 2011 19:51:39 +0100
Message-ID: <CAAwP0s3qfTKFngj3bXgZdOHVqDPEuqNB2MxezkCp7+WTaiEwLw@mail.gmail.com>
References: <1319396024-28558-1-git-send-email-martinez.javier@gmail.com>
 <CAAwP0s0g8pu8zz8J+wEeD6iqH8XN8bqzT-rOQwPYA9jyw8RL7g@mail.gmail.com> <20111101152015.GA2183@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65467 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724Ab1KASwA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2011 14:52:00 -0400
Received: by gyb13 with SMTP id 13so7328366gyb.19
        for <linux-input@vger.kernel.org>; Tue, 01 Nov 2011 11:52:00 -0700 (PDT)
In-Reply-To: <20111101152015.GA2183@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Tue, Nov 1, 2011 at 4:20 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Hi Javier,
>
>> Any comments on this version of the driver?
>
> I am still looking at them, sorry. =C2=A0I take it the patches have b=
een
> tested and work well for you?

Thank you Henrik.

Yes I test the driver before every resubmission.

But probably the driver has bugs that I didn't catch and needs more
testing. On every submit I only make sure that the driver is still
working and the input layer is receiving the information correctly.

>
>> Is the driver still too far away for being in a merge-able state? Do
>> you think would be a better approach to try to pushing it through
>> staging or should I keep resending to merge it via drivers/input?
>
> I still worry about some of error states, so I can only sign off the
> MT part for now. Perhaps Dmitry would like to answer the general
> question.
>

Ok, thank you Henrik. I will work on every issue that you find with
the error states.

Lets wait for Dmitry to answer what approach he thinks is better to
get the driver merged.

>> I can make it either way, whatever works better for you.
>>
>> Thanks a lot and best regards,
>
> Thank you, too.
>
> Henrik
>

I have no problem to keep resending as many times as necessary until
the driver get accepted.

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
