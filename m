From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/6] input: resend of pending patches
Date: Wed, 28 Jan 2009 11:23:43 +0100
Message-ID: <1233138229-12489-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:48420 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750947AbZA1KX4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 05:23:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Dmitry,

here are the outstanding input patches.

Cheers,
Henrik

Henrik Rydberg (6):
  input: bcm5974: Prepare for a new trackpad header type
  input: bcm5974: Add quad-finger tapping
  input: bcm5974: Add support for the Macbook 5 (Unibody)
  input: bcm5974: Augmented debug information
  input: Allow certain EV_ABS events to bypass all filtering
  input: Add a detailed multi-touch finger data report protocol (rev2)

 drivers/input/input.c         |   36 +++++++++++++++
 drivers/input/mouse/bcm5974.c |   99 ++++++++++++++++++++++++++++++----------
 include/linux/input.h         |   29 ++++++++++++
 3 files changed, 139 insertions(+), 25 deletions(-)

