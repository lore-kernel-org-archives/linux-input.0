From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/3] Input: wacom - Provide a range for the ABS_MISC axis
Date: Sun, 25 Aug 2013 10:43:49 -0700
Message-ID: <CANRwn3SjV-Esz8_smnGc9F7bZ0eGYcJ+fzO+8FKEmQcmoU6fsg@mail.gmail.com>
References: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
	<1377220537-1474-2-git-send-email-killertofu@gmail.com>
	<20130824235039.GG4454@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:41329 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475Ab3HYRnv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Aug 2013 13:43:51 -0400
Received: by mail-qc0-f176.google.com with SMTP id u20so532044qcx.35
        for <linux-input@vger.kernel.org>; Sun, 25 Aug 2013 10:43:50 -0700 (PDT)
In-Reply-To: <20130824235039.GG4454@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linuxwacom-devel <linuxwacom-devel@lists.sourceforge.net>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Sat, Aug 24, 2013 at 4:50 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jason,
>
> On Thu, Aug 22, 2013 at 06:15:36PM -0700, Jason Gerecke wrote:
> > Android marks found axes as 'valid' only if they have a minimum
> > and maximum value that aren't equal. Since we don't actually
> > assign any range information for ABS_MISC, Android doesn't bother
> > to mark it such. This prevents userspace from being able to make
> > use of tool serial information.
>
> That should be fixed in Android code. Min/max are filled on best effo=
rt
> basis and 0/0 is effectively unknown.
>
> Thanks.
>
> --
> Dmitry

If userspace is written with the assumption that 0/0 =3D=3D unknown, th=
en
this patch changes nothing since the consumer will expect any value
between INT_MIN and INT_MAX anyway. Furthermore, if some userspace
program strictly interprets 0/0 to mean "will always be equal to 0",
then this patch actually provides it with the correct range. Either
way, setting the values to INT_MIN and INT_MAX does nothing more than
explicitly state the correct range.

I agree that Google should re-visit the function which does this
"valid" filtering, but I don't see a problem with this patch.

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
