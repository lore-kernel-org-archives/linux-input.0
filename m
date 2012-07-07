From: Cedric Sodhi <manday@gmx.net>
Subject: Regression in hid-multitouch?
Date: Sat, 7 Jul 2012 23:55:41 +0200
Message-ID: <20120707215541.GB2484@slate.Speedport_W723_V_Typ_A_1_00_092>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:41604 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751095Ab2GGNzf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jul 2012 09:55:35 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@enac.fr

What previously seems to have been fixed by 

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=3ac36d15557d1bedfb1151d9911b9587b2d40759

has again stopped working in 3.5.0-rc5 - at least I get the exact same
problems I used to have before 3ac36d... although the code from 3ac36d
is still there.

regards,
Cedric
