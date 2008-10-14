From: Oliver Neukum <oliver@neukum.org>
Subject: question on LEDs on keyboards
Date: Tue, 14 Oct 2008 15:20:59 +0200
Message-ID: <200810141521.00225.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:48099 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYJNNWO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 09:22:14 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@vger.kernel.org

Hi,

I found an error in the hid autosuspend patches. Keyboards can have
more than one LED. Is there a way to query the HID layer about active
LEDs?

	Regards
		Oliver
