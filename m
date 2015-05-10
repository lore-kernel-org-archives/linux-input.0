From: Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH V5] Add support for mouse logitech m560
Date: Sun, 10 May 2015 18:49:31 +0200
Message-ID: <1431276572-3258-1-git-send-email-kreijack@libero.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-33.italiaonline.it ([212.48.25.161]:54900 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751612AbbEJQtn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 10 May 2015 12:49:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>


Hi All,

This is the 5th attempt for a Logitech mouse M560 hid driver.
On the basis of the feedback received, I made some cleanup to the code:
- simplified the checks inside m560_raw_event()
- rearranged the return codes in m560_raw_event(): 0 in case the frame is not
  corrected, 1 if the data are correct. This is the behavior observed in
  other drivers, even if the returned values may vary.


The patch is against v4.1-rc2.

Special thanks to Antonio and Benjamin for their support and testing.

BR
G.Baroncelli

--
gpg  <at> keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
