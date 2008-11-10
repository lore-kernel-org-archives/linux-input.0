From: Craig Milo Rogers <rogers@ISI.EDU>
Subject: kernel: logips2pp: Detected unknown logitech mouse model 14
Date: Sun, 9 Nov 2008 23:35:16 -0800
Message-ID: <20081110073516.GA9908@isi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vapor.isi.edu ([128.9.64.64]:35391 "EHLO vapor.isi.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbYKJH6G (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2008 02:58:06 -0500
Received: from jib.isi.edu (jib.isi.edu [128.9.128.193])
	by vapor.isi.edu (8.13.8/8.13.8) with ESMTP id mAA7ZHDf025919
	for <linux-input@vger.kernel.org>; Sun, 9 Nov 2008 23:35:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

	Hi.  I recently updated drom SuSE 10.3 to SuSE 11.0.  I had some
trouble, and noticed the following entry in "/var/log/messages" when
I investigated:

Nov  9 10:28:14 jib2 kernel: logips2pp: Detected unknown logitech mouse model 14

	The Logitech mouse in question has a scroll wheel.  I think it
also has an extra button on top, whit an icon that looks like a
rectangle overlapping and obscuring a second rectangle.

	It would be nice for me if the standard kernel knew about this
mouse.  Should I submit a patch for "logips2pp.c" to this list?
Thanks.

					Craig Milo Rogers

