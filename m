From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] msm: trout: add keypad support
Date: Thu, 9 Dec 2010 14:01:49 -0800
Message-ID: <AANLkTi=3LHHNJUh35AUkq--KtRCnRaBHx8Ky2bhxxzE4@mail.gmail.com>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
	<4D00800E.7050004@codeaurora.org>
	<1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65127 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0LIWBw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 17:01:52 -0500
In-Reply-To: <1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 9, 2010 at 9:45 AM, Daniel Walker <dwalker@codeaurora.org> =
wrote:
> On Thu, 2010-12-09 at 12:36 +0530, Trilok Soni wrote:
>
>> > +static char *keycaps =3D "--qwerty";
>> > +#undef MODULE_PARAM_PREFIX
>> > +#define MODULE_PARAM_PREFIX "board_trout."
>> > +module_param_named(keycaps, keycaps, charp, 0);
>>
>> I would like to know what is the use of this param?
>
> No idea .. It was part of Google's implementation ..
>

You removed the code that uses it. If you look at the original file
you can see how it is used:
http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Darch/arm=
/mach-msm/board-trout-keypad.c;hb=3Drefs/heads/android-msm-2.6.35
It is set by the bootloader according to the hardware version.

You can also see that the "/* userspace needs to know about these
changes as well */" comments refer to the code that changes the name
of the input device.

I don't think this change will work correctly with our existing
user-space code though since you are now reporting the power-key,
camera-key and slide-switch from a separate input device.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
