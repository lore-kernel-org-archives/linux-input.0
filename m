From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH 0/7] input:use module_i2c{spi}_driver in input drivers
Date: Mon, 19 Dec 2011 22:23:18 +0800
Message-ID: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1LSOYl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 09:24:41 -0500
Received: by iaeh11 with SMTP id h11so8615511iae.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 06:24:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Greg Kroah-Hartman <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

Hi Dmitry,all:
Since Greg has queued this patchset to driver-core-next.
http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=907d0ed1c84114d4e8dafd66af982515d3739c90
http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=7c92784a546d2945b6d6973a30f7134be78eb7a4
http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=3acbb0142d48713a8f65cde678a54f419801c189

So, is it time to queue these pathes to input-next, too?

Just use module_i2c_driver() and module_spi_driver() in input i2c
and spi drivers instead.


Thanks
-Wanlong Gao
