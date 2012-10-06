From: Yann Cantin <yann.cantin@laposte.net>
Subject: [ebeam PATCH v2 0/2] new eBeam input driver
Date: Sat,  6 Oct 2012 15:14:45 +0200
Message-ID: <1349529287-23193-1-git-send-email-yann.cantin@laposte.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:37967 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242Ab2JFNSh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Oct 2012 09:18:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

Hi,

New USB input driver for eBeam devices.

Currently supported (tested) :
- Luidia eBeam classic projection and edge projection models
- Nec "interactive solution" NP01Wi1 & NP01Wi2 accessories.

Patch 1 to blacklist the devices for hid generic-usb.

Patch 2 is the actual driver.

Change from v1 : the driver don't send coordinates outside the specified
ranges when calibrated.

The module run fine with a 3.3.6 and a 3.5.0 kernel, both x86_32 and 64.

Thanks for your help.


