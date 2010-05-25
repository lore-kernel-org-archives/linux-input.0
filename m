From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/2] input: mt: Add EVIOC mechanism for MT slots
Date: Tue, 25 May 2010 13:52:57 +0200
Message-ID: <1274788379-11026-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:41278 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752310Ab0EYLxS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 May 2010 07:53:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>, Henrik Rydberg <rydberg@euromail.se>

These patches are in response to the discussion about input state
retrieval.

The current EVIOCGABS method does not work with MT slots.  These
patches provides a mechanism where a slot is first selected via a call
to EVIOCSABS, after which the corresponding MT events can be extracted
with calls to EVIOCGABS.

The symmetric operation, to set the MT state via EVIOCSABS, seems to
violate input data integrity, and is therefore not implemented.

Henrik Rydberg (2):
  input: mt: Add method to extract the MT slot state
  input: mt: Add EVIOC mechanism to extract the MT slot state

 drivers/input/evdev.c |    9 ++++++++-
 drivers/input/input.c |   31 +++++++++++++++++++++++++++++++
 include/linux/input.h |    2 ++
 3 files changed, 41 insertions(+), 1 deletions(-)

