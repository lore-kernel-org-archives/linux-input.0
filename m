From: Dave Young <hidave.darkstar@gmail.com>
Subject: touchpad stuck sometimes
Date: Sun, 2 Aug 2009 16:16:13 +0800
Message-ID: <20090802081612.GA14646@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:51879 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZHBIQS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2009 04:16:18 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

My touchpad sometimes will stuck for a while, and then it will be ok.

I can see kernel message like this:

[ 1293.426227] psmouse.c: GlidePoint at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
[ 1293.969357] psmouse.c: resync failed, issuing reconnect request

Hardware is dell e5400, kernel version: 2.6.31-rc5

--
Regards
dave
