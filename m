From: Anisha Kaul <born.rebel.83@gmail.com>
Subject: Re: How to physically rotate the joystick wheel through the code/terminal.
Date: Fri, 6 Jan 2012 09:46:38 +0530
Message-ID: <CAM1yFZ9771JoKDr0Y0YQeQOzQKZwFxTBudRHY4V0LXFzwCkbUg@mail.gmail.com>
References: <CAM1yFZ9kHjJBhWH3NFTTaOJ3NdBYMH599U0=FXZ_AQVsYoJkUQ@mail.gmail.com>
	<c66035e82efa0d09c54a1cec3f06cfae.squirrel@mungewell.org>
	<CAM1yFZ8ni1C9PJ4_1nsi7smT1rCT7i8hU26zJK8qMqUAYUgxnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:33377 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758151Ab2AFEQj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Jan 2012 23:16:39 -0500
Received: by obcwo16 with SMTP id wo16so1430096obc.19
        for <linux-input@vger.kernel.org>; Thu, 05 Jan 2012 20:16:38 -0800 (PST)
In-Reply-To: <CAM1yFZ8ni1C9PJ4_1nsi7smT1rCT7i8hU26zJK8qMqUAYUgxnA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On 5 January 2012 20:37, <simon@mungewell.org> wrote:
>
> Hi Anisha,
> You don't mention which distro you are on, but some/most have a test
> application 'ffcfstress' which cycles the position of a wheel/joystic=
k.
>
> There is a 'spring force' which has an adjustable center, but most wh=
eels
> don't support this. 'ffcfstress' uses a 'constant force' (to the left=
 or
> right) and monitors the position of the wheel.
>
> Thus using a control loop it modulates the amount of force, lowering =
it as
> the wheel approaches it's target.
>
> If you don't want to use the icotl interface, then you could look at =
a
> userspace lib such as SDL1.3 which (mostly) supports ForceFeedback.
>
> Cheers,
> Simon


Thanks for following up, Simon. I am grateful to you.
"ffcfstress" does indeed look=A0promising. The distro is OpenSuse 11.3
and this program
is already there. I'll take a look. :)

-Anisha
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
