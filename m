From: Randy Dunlap <rdunlap@xenotime.net>
Subject: touchpad rate limiting
Date: Thu, 9 Oct 2008 12:55:47 -0700
Message-ID: <20081009125547.d7928542.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:38350 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752309AbYJITzx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Oct 2008 15:55:53 -0400
Received: from chimera.site ([71.117.247.66]) by xenotime.net for <linux-input@vger.kernel.org>; Thu, 9 Oct 2008 12:55:48 -0700
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I could swear that I saw a patch that limits how messy some touchpads
can act by looking for deltas in X/Y positions and tempering the
movement based on that.

Does anyone recall this patch?  I can't find it.
Pointers or Subject: ?

TIA,
---
~Randy
