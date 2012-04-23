From: Ming Lei <tom.leiming@gmail.com>
Subject: HID regression: Quanta touchscreen, device ID: 0408:3008
Date: Mon, 23 Apr 2012 15:26:20 +0800
Message-ID: <CACVXFVPTMPGRcvgdBd9Z=rsPCUGdmyoejU208Wy=c3c38U-ZkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44777 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab2DWH0U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 03:26:20 -0400
Received: by obbta14 with SMTP id ta14so12309730obb.19
        for <linux-input@vger.kernel.org>; Mon, 23 Apr 2012 00:26:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@enac.fr>

Hi,

Quanta touchscreen, device ID: 0408:3008, works well on 3.0, but
double click doesn't work on 3.4-rc2, please refer to detailed report
on the below link.



https://bugs.launchpad.net/ubuntu/+source/linux/+bug/913164/comments/15
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/913164/comments/32

Thanks,
-- 
Ming Lei
