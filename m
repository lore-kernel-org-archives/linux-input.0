From: Daniel Martin <daniel.martin@secunet.com>
Subject: [v3] synaptics: match PNP-Id is not sufficient for min/max quirks
Date: Fri, 6 Feb 2015 14:25:03 +0100
Message-ID: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:41570 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbbBFNT1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 08:19:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi folks,

this is the third version of my patches to address the bug:
    https://bugzilla.kernel.org/show_bug.cgi?id=91541

One task on top of patch 5 remains: Find suitable board id ranges.
I.e. in the first comment of the bug, the board id 2962 is the lowest
one that I know of for a post-2013 model. So, the quirk with PnP id
LEN0036 could have a max board id of 2961.

Changes to v2 are:

[PATCH 3/5] Input: synaptics - Query min dimensions for fw v8.1
- Here I have replaced the "safe fw" list with a simple check for
  version 8.1

[PATCH 4/5] Input: synaptics - Remove obsolete min/max quirk for X240
- This patch has been moved from the patch set tail here.

[PATCH 5/5] Input: synaptics - Support min/max board id in
- With that we can restrict min/max quirks by board id ranges. It
  replaces the previous patch:
      Input: synaptics - Skip quirks when post-2013 dimensions


Cheers,
    Daniel Martin
