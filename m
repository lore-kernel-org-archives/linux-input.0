From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 0/5] HID: sony: Various fixes and improvements for the Sony driver
Date: Thu, 20 Feb 2014 11:35:59 -0500
Message-ID: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:53948 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbaBTQgL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 11:36:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

v2 of this patch set addresses the code review issues raised in v1 as well as
adding a patch that fixes the styling of multi-line comments to conform to
kernel coding standards, adds a check to protect against a potential
out-of-bounds read in the Sixaxis battery code and adds a note in hidp/core.c
that a device module now depends on the current behavior of the uniq string.
