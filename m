From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Fri, 21 May 2010 08:40:51 -0700
Message-ID: <AANLkTimemw0iAslk6jeuwf0LGRgCo0-2Mvpgso42CP5Z@mail.gmail.com>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se>
	 <1274213429-22667-2-git-send-email-rydberg@euromail.se>
	 <AANLkTikpmYwEYh5Dh-p3478cDMVo9hXOsDkt54ltHW6J@mail.gmail.com>
	 <4BF4E00A.30206@euromail.se>
	 <AANLkTinYX96zokFF6Rc-3_gxIrMZmvMS_pw3YdQD6CG4@mail.gmail.com>
	 <1274455140.1871.8.camel@tron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:65042 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880Ab0EUPkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 May 2010 11:40:52 -0400
In-Reply-To: <1274455140.1871.8.camel@tron>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Michael Poole <mdpoole@troilus.org>

On Fri, May 21, 2010 at 8:19 AM, Rafi Rubin <rafi@seas.upenn.edu> wrote=
:
>> ABS_MT_BLOB_ID 11
>> ABS_MT_TRACKING_ID 45
>> ABS_MT_SLOT_ID 0
>> ABS_MT_POSITION_X x[0]
>> ABS_MT_POSITION_Y y[0]
>> ABS_MT_SLOT_ID 1
>> ABS_MT_POSITION_X x[1]
>> ABS_MT_POSITION_Y y[1]
>> ABS_MT_SLOT_ID 2
>> ABS_MT_POSITION_X x[2]
>> ABS_MT_POSITION_Y y[2]
>> SYN_MT_BLOB
>> ABS_MT_BLOB_ID 89
>> ABS_MT_SLOT_ID 3
>> ABS_MT_TRACKING_ID 30
>> ABS_MT_POSITION_X x[3]
>> ABS_MT_POSITION_Y y[3]
>> SYN_MT_BLOB
>> SYN_REPORT
>>
>> where we have two blob of data. They represent finger 1 and finger 2=
=2E
>> Finger 1 has a tracking number 11 while finger 2 has 30.=A0 We do no=
t
>> track the three contacts inside the blob since they all belong to th=
e
>> same finger.=A0 We could even combine type A and B as:
>
> ???
>
> Ping: please confirm, are you actually talking about each finger simu=
ltaneously sending multiple positions?

You are definitely on the right track.  The fingers/touch objects can
be represented two-dimensionally (x,y) instead of one-dimensionally
(ABS_MT_TRACKING_ID).  I think we can survive with the current MT_BLOB
definition although some optimization would be helpful, especially for
filtering. For the sake of Henrik great effort, I'd like to see his
current patchset gets in the tree before we start another round of
"suggestions".

Thank you for asking.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
