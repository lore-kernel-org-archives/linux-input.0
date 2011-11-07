From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v7 0/3] Input: Cypress TTSP device driver
Date: Mon, 7 Nov 2011 09:17:57 +0100
Message-ID: <CAAwP0s0H5-cpGGn-x9+5praGs2+7kTyG==k36Y7zB_-d8SHO7Q@mail.gmail.com>
References: <1319396024-28558-1-git-send-email-martinez.javier@gmail.com>
 <CAAwP0s0g8pu8zz8J+wEeD6iqH8XN8bqzT-rOQwPYA9jyw8RL7g@mail.gmail.com>
 <20111101152015.GA2183@polaris.bitmath.org> <CAAwP0s3qfTKFngj3bXgZdOHVqDPEuqNB2MxezkCp7+WTaiEwLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38273 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1KGISS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2011 03:18:18 -0500
Received: by ywf7 with SMTP id 7so5017970ywf.19
        for <linux-input@vger.kernel.org>; Mon, 07 Nov 2011 00:18:17 -0800 (PST)
In-Reply-To: <CAAwP0s3qfTKFngj3bXgZdOHVqDPEuqNB2MxezkCp7+WTaiEwLw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Tue, Nov 1, 2011 at 7:51 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> On Tue, Nov 1, 2011 at 4:20 PM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
>> Hi Javier,
>>
>>> Any comments on this version of the driver?
>>
>> I am still looking at them, sorry. =C2=A0I take it the patches have =
been
>> tested and work well for you?
>
> Thank you Henrik.
>
> Yes I test the driver before every resubmission.
>
> But probably the driver has bugs that I didn't catch and needs more
> testing. On every submit I only make sure that the driver is still
> working and the input layer is receiving the information correctly.
>
>>
>>> Is the driver still too far away for being in a merge-able state? D=
o
>>> you think would be a better approach to try to pushing it through
>>> staging or should I keep resending to merge it via drivers/input?
>>
>> I still worry about some of error states, so I can only sign off the
>> MT part for now. Perhaps Dmitry would like to answer the general
>> question.
>>
>
> Ok, thank you Henrik. I will work on every issue that you find with
> the error states.
>
> Lets wait for Dmitry to answer what approach he thinks is better to
> get the driver merged.
>

Hello Dmitry,

Do you have any comments on this issue?

Thank you and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
