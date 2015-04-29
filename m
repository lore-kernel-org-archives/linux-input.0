From: Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH V3] Add support for mouse logitech m560
Date: Wed, 29 Apr 2015 20:24:13 +0200
Message-ID: <1430331854-11206-1-git-send-email-kreijack@libero.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-32.italiaonline.it ([212.48.25.160]:58652 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751155AbbD2SYY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2015 14:24:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>

Hi All,

sorry for the repost, but I mistaked with git-email :-)

This is the 3rd attempt for a Logitech mouse M560 hid driver. Finally
I was able to use the input_report*() function as suggested by Benjamin.

I tested the code and it works for me (TM); of course because the change in big
further tests/testers are welcome.

Special thanks to Antonio for his support and testing.

Comments are welcome.

BR
G.Baroncelli


Changelog:
- v1 first issue
- v2 accepted Benjamin Tissoires suggestions
- v3 use input_report*() function instead of rewriting the hid-report


--
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D 17B2 0EDA 9B37 8B82 E0B5
