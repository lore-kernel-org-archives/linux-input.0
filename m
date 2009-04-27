From: "Ba, Zheng" <zheng.ba@intel.com>
Subject: [PATCH 0/1] input: keypad controller driver for Intel low power
 Moorestown platform
Date: Mon, 27 Apr 2009 15:13:48 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C1771595B035@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5232 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbZD0HQH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2009 03:16:07 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

This is a description for the patch:
1. Patch for keypad controller driver for Intel low power platform "Moorestown".
2. The driver depends on a GPIO driver for Intel Moorestown platform.
3. The patch will:
a. Add moorestown_kpd.c to kernel dir "drivers/input/keyboard"
b. Add items into kernel files "drivers/input/keyboard/Makefile" and "drivers/input/keyboard/Kconfig"

The attachment will be included in another mail. Please kindly review it and let me know for any questions.

Thanks,
Zheng
