From: Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH V6] Add support for mouse logitech m560
Date: Sat, 30 May 2015 11:00:25 +0200
Message-ID: <1432976427-12013-1-git-send-email-kreijack@libero.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-36.italiaonline.it ([212.48.25.164]:57110 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751413AbbE3JAj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 30 May 2015 05:00:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, linux-input@vger.kernel.org


Hi All,

This is the 6th attempt for a Logitech mouse M560 hid driver.


On the basis of the feedback received, I made some changes in the code:
v6:
- hid-core.c: rename extract() to hid_field_extract() and make it linkage
  external
- hid-logitech-hidpp.c: use hid_field_extract() instead of hidpp_extract()
  as per Jiri request.
- update the error message in m560_raw_event() to be more specific
v5:
- simplified the checks inside m560_raw_event()
- rearranged the return codes in m560_raw_event(): 0 in case the frame is not
  corrected, 1 if the data are correct. This is the behavior observed in
  other drivers, even if the returned values may vary.


The patch is against v4.1-rc5.

Special thanks to Antonio and Benjamin for their support and testing.

BR
G.Baroncelli

--
gpg  <at> keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
