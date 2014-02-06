From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3 0/6] HID: sony: Add full Bluetooth support for the Dualshock 4
Date: Wed,  5 Feb 2014 20:03:43 -0500
Message-ID: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:56652 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbaBFBEO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:04:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

v3 of this patch series rebases the code against Benjamin Tissoires' HID
transport layer changes to use the safe inline hid_hw_* functions which
eliminates the need to check the function pointers manually.

It adds an explicit Bluetooth initialization function instead of the controller
input report state being set as a side effect of initializing the LED system.

It also uses a new DUALSHOCK4_CONTROLLER macro to simplify conditional cases
where the connection type is irrelevant.
