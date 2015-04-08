From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.0 REGRESSION FIX 0/1] alps: Fix left touchpad button getting stuck
Date: Wed,  8 Apr 2015 17:38:51 +0200
Message-ID: <1428507532-25533-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54017 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753311AbbDHPjC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Apr 2015 11:39:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus, Dmitry,

Sorry for the last minute regression fix, but the existence of this regression
was not entirely clear until Hans de Bruin send a very clear reproducer this
morning.

I'm not sure if this is 4.0 material, it does fix a real regression, the fix
is pretty simple and safe (*), and when triggered the behavior (stuck mouse
button) is nasty, which all counts in favor of fixing this. OTOH this only
affects somewhat older hardware and only a certain usage pattern (using the
trackpoint with the touchpad buttons). Anyways the call if this is 4.0 material
is up to you (Linus and Dmitry), I'm just trying to make sure you're aware of
this issue and the patch.

The details of the actual bug + fix can be found in the commit msg of the
patch.

Regards,

Hans

*) The fix restores 3.19 behavior for alps v2 dualpoint touchpad/stick combos
