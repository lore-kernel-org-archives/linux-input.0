From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 0/6] HID: sony: Add full Dualshock 4 support in Bluetooth mode
Date: Thu, 30 Jan 2014 12:24:02 -0500
Message-ID: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:59584 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbaA3RYN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 12:24:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

This updated set of patches adds NULL pointer checking for the ll_driver
functions and makes the battery calculation code more robust.

The last patch from the first set that checked for duplicate controllers is
on-hold for now as without a guaranteed way to retrieve the MAC address
of a Bluetooth device from a module it has the potential to break.
