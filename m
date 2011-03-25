From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH 3/4] input: evdev: Indicate buffer overrun with SYN_DROPPED.
Date: Fri, 25 Mar 2011 16:12:01 -0700
Message-ID: <AANLkTinqbLShaVGL6NJCMamHNWzMGT7DLXb7OQ6dxLVX@mail.gmail.com>
References: <1300842244-42723-1-git-send-email-jeffbrown@android.com>
 <1300842244-42723-4-git-send-email-jeffbrown@android.com> <20110325090210.GA5860@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58829 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1CYXMm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 19:12:42 -0400
In-Reply-To: <20110325090210.GA5860@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Fri, Mar 25, 2011 at 2:02 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> My last comment was not right, the SYN_DROPPED is pushed ahead in the
> buffer, sorry about that. However, this change does not shrink the
> number of buffered elements in case of an overrun, which has been
> discussed before as a possibly important feature of the current
> code. I would be more comfortable prepending the head with a
> SYN_DROPPED, like this:
>
> if (client->head =3D=3D client->tail) {
> =A0 =A0 =A0 =A0struct input_event drop;
>
> =A0 =A0 =A0 =A0drop.time =3D event->time;
> =A0 =A0 =A0 =A0drop.type =3D EV_SYN;
> =A0 =A0 =A0 =A0drop.code =3D SYN_DROPPED;
> =A0 =A0 =A0 =A0drop.value =3D 0;
> =A0 =A0 =A0 =A0client->buffer[client->head++] =3D drop;
> =A0 =A0 =A0 =A0client->head &=3D client->bufsize - 1;
>
> =A0 =A0 =A0 =A0client->buffer[client->head++] =3D *event;
> =A0 =A0 =A0 =A0client->head &=3D client->bufsize - 1;
> }
>
> The main point is that if we end up having to drop an event, it is
> likely we will have to drop the next one, too.

I think that's a good idea.  If the client is far behind then we might
as well truncate the buffer as you suggest.  I'll do that.

Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
