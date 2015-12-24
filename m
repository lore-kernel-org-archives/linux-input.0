From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 0/8] Input: atmel_mxt_ts - raw data via debugfs
Date: Thu, 24 Dec 2015 13:49:19 +0000
Message-ID: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:19717 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752078AbbLXNth (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 08:49:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>

Hello-

This is an updated series of patches to add diagnostic data support to the
Atmel maXTouch driver.

There's an existing implementation in the open-source mxt-app tool, however
there are performance advantages to moving this code into the driver.  The
algorithm for retrieving the data has been fairly consistent across a range of
chips, with the exception of the mXT1386 series (see patch).  It would be good
if we could agree a single debugfs interface which could be supported by all
touchscreen chips that have this kind of feature, so I've attempted to
keep that part of this vendor neutral.

Changes since v1:
* adding a way to retrieve a single node at high performance
* adding some locking
* switching to using seq_file.
* numerous minor refactorings

This patch sequence is also available from:
    https://github.com/ndyer/linux/commits/diagnostic-debug

A utility to display this data has now been released, and you can find it at:
    https://github.com/ndyer/heatmap

I've recorded a couple of videos of the utility in action on a Pixel 2:
    https://youtu.be/M0VD2gZt8Zk and https://youtu.be/nwDLB4zikzU

Any feedback appreciated.

Best regards

Nick Dyer

