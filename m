From: Terry Junge <terry.junge@plantronics.com>
Subject: [PATCH v2 2/2] HID: hid-plantronics: Update Kconfig HID_PLANTRONICS default setting
Date: Fri, 15 May 2015 17:35:12 -0700
Message-ID: <1431736512-23161-2-git-send-email-terry.junge@plantronics.com>
References: <1431736512-23161-1-git-send-email-terry.junge@plantronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail4.plantronics.com ([198.231.10.50]:53925 "EHLO
	mail4.plantronics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934523AbbEPAhJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 20:37:09 -0400
In-Reply-To: <1431736512-23161-1-git-send-email-terry.junge@plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Terry Junge <terry.junge@plantronics.com>, jkosina@suse.cz

Althought the general rule of thumb is to not add any new default-to-on
options for things that are not crucial core infrastructure of the kernel,
the hid-plantronics driver prevents hid-input from mapping unknown
Plantronics vendor unique usages to random mouse events.

The result of this default mapping of unknown usages is that unexpected
mouse or touchpad events can occur or be blocked when buttons are pressed
on some Plantronics devices. Having this driver available as a module
will prevent this core mapping.

Patched against git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
with part 1 of this patch set applied.

Signed-off-by: Terry Junge <terry.junge@plantronics.com>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index cc4c664..6bfcafb 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -632,6 +632,7 @@ config HID_PICOLCD_CIR

 config HID_PLANTRONICS
        tristate "Plantronics USB HID Driver"
+       default m
        depends on HID
        ---help---
          Provides HID support for Plantronics USB audio devices.
--
1.9.1


________________________________

CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential and/or legally privileged. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, please DO NOT disclose the contents to another person, store or copy the information in any medium, or use any of the information contained in or attached to this transmission for any purpose. If you have received this transmission in error, please immediately notify the sender by reply email or at privacy@plantronics.com, and destroy the original transmission and its attachments without reading or saving in any manner.

For further information about Plantronics - the Company, its products, brands, partners, please visit our website www.plantronics.com.
