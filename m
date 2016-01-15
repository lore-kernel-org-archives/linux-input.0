From: Lauri Kasanen <cand@gmx.com>
Subject: MOUSE_PS2_VMMOUSE and input/mice
Date: Fri, 15 Jan 2016 12:39:28 +0200
Message-ID: <20160115123928.d06e1fed.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:55814 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176AbcAOKj3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 05:39:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: thellstrom@vmware.com, dmitry.torokhov@gmail.com

Hi,

Seems the new and shiny VMWare mouse driver does not pass events
to /dev/input/mice, rudely breaking userspace that doesn't
support absolute input devices.

Can this be changed? Would there be any downside to passing those
events?

- Lauri
