From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 0/2] Input: joystick - documentation fixes
Date: Mon, 16 Dec 2013 09:57:13 +0100
Message-ID: <1387184235-20169-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:47935 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab3LPI53 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 03:57:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

here are a couple of fixes for the joystick API documentation.

Ciao,
   Antonio

Antonio Ospite (2):
  Input: joystick - refer to /dev/input/js0 in documentation
  Input: joystick - use sizeof(VARIABLE) in documentation

 Documentation/input/joystick-api.txt | 12 ++++++------
 Documentation/input/joystick.txt     |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
