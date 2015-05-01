From: Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH V4] Add support for mouse logitech m560
Date: Fri, 01 May 2015 10:56:29 +0200
Message-ID: <55433FBD.40606@libero.it>
References: <1430469813-3303-1-git-send-email-kreijack@libero.it>
Reply-To: kreijack@inwind.it
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-17.italiaonline.it ([212.48.25.145]:38447 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752989AbbEAI4d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 May 2015 04:56:33 -0400
In-Reply-To: <1430469813-3303-1-git-send-email-kreijack@libero.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>

Hi All,

This is the 4th attempt for a Logitech mouse M560 hid driver.
In the previous attempt I didn't check carefully the arguments of the function
m560_raw_event() this leaded sometime to a system crash.
On the basis of the feedback received, I made some cleanup to the code.

The patch is against v4.1-rc1.

Special thanks to Antonio and Benjamin for their support and testing.

BR
G.Baroncelli


Changelog:
- v1 first issue
- v2 accepted Benjamin Tissoires suggestions
- v3 use input_report*() function instead of rewriting the hid-report
- v4 add check of the arguments in m560_raw_event()


--
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D 17B2 0EDA 9B37 8B82 E0B5
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
