From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH 4/4] input: evdev: only wake poll on EV_SYN
Date: Fri, 25 Mar 2011 16:07:40 -0700
Message-ID: <AANLkTinipkcuT=bBo39GWeQt5-tHGMf_pnHGCot6N95E@mail.gmail.com>
References: <1300842244-42723-1-git-send-email-jeffbrown@android.com>
 <1300842244-42723-5-git-send-email-jeffbrown@android.com> <20110325083448.GA5738@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48846 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab1CYXIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 19:08:47 -0400
In-Reply-To: <20110325083448.GA5738@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>> - =A0 =A0 if (event->type =3D=3D EV_SYN)
>> + =A0 =A0 if (event->type =3D=3D EV_SYN && event->code !=3D SYN_MT_R=
EPORT)
>
> It is not clear what should happen at the other SYN events. =A0Maybe
> event->code =3D=3D SYN_REPORT instead?
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kill_fasync(&client->fasync, SIGIO, POLL=
_IN);
>> =A0}

The reasoning here is that we want to wake up (for poll) or signal
(for fasync) the waiters when a complete packet is available.

SYN_CONFIG, SYN_REPORT and the proposed SYN_DROPPED are all
indications of a complete packet being ready or at least an indication
that the reader should do something.  The odd one out is
SYN_MT_REPORT.

>> - =A0 =A0 wake_up_interruptible(&evdev->wait);
>> + =A0 =A0 if (type =3D=3D EV_SYN && code !=3D SYN_MT_REPORT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&evdev->wait);
>
> Ah, this is a good one. Since the code depends on the same logic bein=
g
> applied in evdev_pass_event as well, a boolean argument to that
> function would be good.

I agree.  We could pass a flag to evdev_pass_event to indicate whether
to signal fasync processes that are waiting for data.

Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
