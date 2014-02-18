From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 0/3] HID: sony: Various cleanups and fixes for the sony module
Date: Tue, 18 Feb 2014 17:22:00 -0500
Message-ID: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:64423 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaBRWWL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Feb 2014 17:22:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Since the new ll_driver functions allow for reports to be sent on the control
channel the LEDs and force-feedback can be enabled for the Sixaxis/Dualshock 3.

The second patch only sets the force-feedback flags for devices that actually
support force feedback.  It also moves the cancel_work_sync function out of the
ff shutdown function since the worker functions are initialized and used for
the LEDs even when force-feedback support is disabled at compile time.

The final patch is an updated version of the duplicate controller detection code
that was originally part of the Bluetooth patch set.  It now works on both the
Sixaxis and Dualshock 4.  On USB the MAC can be retrieved via feature reports.
Unfortunately, neither controller supports retrieving the MAC address via a
feature report when connected via Bluetooth so it needs to be parsed from the
uniq string where HIDP stores it.  Based on previous discussions
(http://www.spinics.net/lists/linux-input/msg29530.html), uniq should provide a
stable way for retrieving a Bluetooth MAC address under normal circumstances,
unless the behavior in HIDP changes for some reason.  If a MAC cannot be parsed
from the uniq string the duplicate check will be skipped and the connection will
proceed, so even in the case of a uHID device or the behavior of HIDP changing
in the future, a user's controller will still work.
