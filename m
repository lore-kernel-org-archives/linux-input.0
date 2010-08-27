From: Stephen Hemminger <shemminger@vyatta.com>
Subject: HID Belkin lockup with 2.6.36-rc2
Date: Fri, 27 Aug 2010 16:31:34 -0700
Message-ID: <20100827163134.7db49039@s6510>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:47675 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab0H0Xbh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Aug 2010 19:31:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

A couple times now with my cheap Belkin Flip KVM, the system
has appeared to freeze after changing back.

Today, I managed to get in over network connection and discovered
that everything was fine, except no input was coming in (mouse/keyboard).
Doing rmmod/modprobe on hid_belkin cleared the problem.

This is new in 2.6.36, haven't seen it in previous releases.
