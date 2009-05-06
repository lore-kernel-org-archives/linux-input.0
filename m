From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: Input: add MAX7359 key switch controller driver
Date: Wed, 6 May 2009 13:57:05 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090172C682@mi8nycmail19.Mi8.com>
References: <4A012C64.1020101@samsung.com> <5d5443650905060638l52b3c17dle0d138b689a23252@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob117.obsmtp.com ([64.18.1.38]:50409 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756081AbZEFR5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2009 13:57:08 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5d5443650905060638l52b3c17dle0d138b689a23252@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>, Kim Kyuwon <q1.kim@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

On Wednesday, May 06, 2009 6:38 AM, Trilok Soni wrote:
>> +
>> +#define KEY(row, col, val) =A0 =A0 (((row) << 28) | ((col) << 24) |=
 (val))
>
> Looks like this macro is highly used by many input drivers, anyone
> looking at it to place it at common location?

Hello,

I submitted a patch series around early Feb that did just that. The onl=
y
archive for linux-input that I can find to reference the original submi=
t
is at http://markmail.org/browse/org.kernel.vger.linux-input/2009-01.
The first message in the series is $SUBJECT
"[PATCH 0/5] input: Common macro for keypad drivers".

At this point the series would probably need to be updated.  If wanted =
I
will create a new one.

Regards,
Hartley
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
