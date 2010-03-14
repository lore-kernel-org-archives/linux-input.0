From: micki@n-trig.com
Subject: HID: N-trig MTM Driver fix And cleanup patch 7 - comments
Date: Sun, 14 Mar 2010 10:22:17 +0200
Message-ID: <1268554937-3679-1-git-send-email-micki@n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxout12.netvision.net.il ([194.90.6.37]:63162 "EHLO
	mxout12.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab0CNIWN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Mar 2010 04:22:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, dmitry.torokhov@gmail.com, rafi@seas.upenn.edu, chatty@enac.fr, peterhuewe@gmx.de, micki@n-trig.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: micki <micki@n-trig.com>

We reviewed all your comments with regard to our code and as mentioned in previous e-mail the relevant ones were fixed.

Our driver works together with a user-space application which will be released as installation package suitable for

several Distros (RPM/DEB).

The purpose of the package is to provide better performance and thus user-experience working with N-trig sensor.
If you have any more comments about the code please send them to me, so I can update the patch.

Thank you,

Micki

Signed-off-by: Micki Balanga <micki@n-trig.com>
---
-- 
1.6.3.3

