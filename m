From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH 0/7] msi-wmi driver and cleanups
Date: Thu, 10 Dec 2009 14:18:12 +0100
Message-ID: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42837 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758969AbZLJN1Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 08:27:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>, Anisse Astier <anisse@astier.eu>

This driver adds support for WMI-based hotkeys and backlight for some MSI 
laptops and all-in-one computers.

This driver was sent in the end of october by Thomas Renninger
(cf http://patchwork.kernel.org/patch/55944/ ). I'm re-sending it as-is (I
just added my Reviewed-by:); it is the first patch of this serie because 
it doesn't look like it has been integrated yet in Len's ACPI tree.

Other patches are just a follow-up to my previous comments on this driver,
that I would like to see merged for 2.6.33.

Please note that the last patch of this serie requires Dmitry's input next
tree to have the sparse keymap library.

Regards,

Anisse


Anisse Astier (6):
  msi-wmi: remove useless includes
  msi-wmi: rework init
  msi-wmi: remove custom runtime debug implementation
  msi-wmi: remove unused field 'instance' in key_entry structure
  msi-wmi: replace one-condition switch-case with if statement
  msi-wmi: switch to using input sparse keymap library

Thomas Renninger (1):
  X86 drivers: Introduce msi-wmi driver

 drivers/platform/x86/Kconfig   |   11 ++
 drivers/platform/x86/Makefile  |    1 +
 drivers/platform/x86/msi-wmi.c |  286 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/msi-wmi.c

