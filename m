From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 0/4] HID: implement new transport-driver callbacks
Date: Wed, 22 Jan 2014 13:49:40 -0500
Message-ID: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:51501 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbaAVSuS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 13:50:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

These patches are originally the work of David Herrmann who suggested that I 
update and submit them as their functionality is required for some pending
patches to the hid-sony driver.

These patches implement the SET/GET_REPORT and raw intr OUTPUT requests for all
transport drivers.  It adds two callbacks to the hid_ll_driver struct:

int (*raw_request)(struct hid_device *hdev, unsigned char reportnum,
		   __u8 *buf, size_t len, unsigned char rtype, int reqtype);

int (*output_report)(struct hid_device *hdev, __u8 *buf, size_t len);

along with the necessary support fuctions in the USBHID, and HIDP drivers.

UHID is not converted yet.
