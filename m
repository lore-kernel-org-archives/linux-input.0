From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: atmel_mxt_ts and mxt224e
Date: Thu,  7 Feb 2013 15:17:41 +0100
Message-ID: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47030 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499Ab3BGOR7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:17:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, djkurtz@chromium.org, y0922.shim@samsung.com

Hello,

I had some issues in using the atmel_mxt_ts driver with different mxt224 parts 
(different firmware version, mxt224 vs. mxt224); configuration of the chip
via mxt_platform_data.config is super-fragile when device objects change

mxt_handle_pdata() assumes that certain object table entries are present and
fails on the mxt224e

the patch series aims to support the mxt224e better and adds a message to detect
inconsistencies between config data and the device object table

if there is interest I can propose a more robust mechanism to set the config data;
similar patches are floating around for Android in various trees

thanks, regards, p.

