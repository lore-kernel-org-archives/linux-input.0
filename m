From: "benjamin.tissoires" <benjamin.tissoires@gmail.com>
Subject: [patch 0/5] Autohandling of multitouch devices through hid-multitouch
Date: Tue,  6 Mar 2012 17:57:01 +0100
Message-ID: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33223 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081Ab2CFQ5Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 11:57:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Guys,

In this patch series, I introduce 1 trivial patch plus 4 patches that need review I think:
- the first is trivial (I missed it this morning, sorry)
- the second fixes a problem detected with LG panels. The detection of the end of the
  report was not accurate, and needed to be rewritten. I'm worried about it because I got
  warnings under Ubuntu for this patch (-Warray-bounds) whereas I don't get any warnings
  under Fedora.
- the third should not be a problem as it relies on the presence of the QUIRK_MULTITOUCH
  and will impact only unknown devices.
- the fourth worries me more. I introduce changes in hid_device, and I'd like to have your opinion.
- Then, the last one allows us to be compliant with Microsoft's description for Win 7 devices.

Cheers,
Benjamin

PS: Thanks Henrik and Jiri for the series of this morning.


