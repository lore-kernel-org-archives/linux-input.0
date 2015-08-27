From: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
Subject: [PATCH 0/1] Allow negative attack/fade ramps
Date: Thu, 27 Aug 2015 14:03:41 +0300
Message-ID: <1440673422-12279-1-git-send-email-kalle.jokiniemi@jolla.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp80.ord1c.emailsrvr.com ([108.166.43.80]:43727 "EHLO
	smtp80.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484AbbH0LLm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2015 07:11:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jolla.com>

Hi,

We're using ff-memless in Sailfish OS for vibrator / haptics support,
and I've noticed this annoying issue with the periodic force feedback effects
that declining attack ramps don't work with it properly.

I.e This kind of effect:

\
 \
  '-------------.
                 \
                  \

turns into something like this:

--+
  |
  +-------------.
                 \
                  \

It turned out to be quite simple fix to get declining attack ramps
and rising fades to behave linearly. Please check, comment, and apply
if seen fit.

Kalle Jokiniemi (1):
  input: ff-memless: Allow negative attack / fade ramps

 drivers/input/ff-memless.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1

