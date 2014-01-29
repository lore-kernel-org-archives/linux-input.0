From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/4] HID: implement new transport-driver callbacks
Date: Wed, 29 Jan 2014 14:25:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401291424560.21385@pobox.suse.cz>
References: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50414 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbaA2NZP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 08:25:15 -0500
In-Reply-To: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, dh.herrmann@gmail.com

On Wed, 22 Jan 2014, Frank Praznik wrote:

> These patches are originally the work of David Herrmann who suggested that I 
> update and submit them as their functionality is required for some pending
> patches to the hid-sony driver.
> 
> These patches implement the SET/GET_REPORT and raw intr OUTPUT requests for all
> transport drivers.  It adds two callbacks to the hid_ll_driver struct:
> 
> int (*raw_request)(struct hid_device *hdev, unsigned char reportnum,
> 		   __u8 *buf, size_t len, unsigned char rtype, int reqtype);
> 
> int (*output_report)(struct hid_device *hdev, __u8 *buf, size_t len);
> 
> along with the necessary support fuctions in the USBHID, and HIDP drivers.
> 
> UHID is not converted yet.

I have finished reviewing the patchset and don't have any objections. I am 
queuing them for 3.15.

-- 
Jiri Kosina
SUSE Labs
