From: rydberg@euromail.se
Subject: Re: [RFC 6/8] HID: uhid: use generic hidinput_input_event()
Date: Thu, 18 Jul 2013 21:53:24 +0200
Message-ID: <20130718195324.GA570@polaris.bitmath.org>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
 <1373908217-16748-7-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:39561 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933590Ab3GRTwP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Jul 2013 15:52:15 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id A5284E95AB
	for <linux-input@vger.kernel.org>; Thu, 18 Jul 2013 21:52:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1373908217-16748-7-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Oliver Neukum <oliver@neukum.org>

Hi David,

> HID core provides the same functionality and can convert the input event
> to a raw output report. We can thus drop UHID_OUTPUT_EV and rely on the
> mandatory UHID_OUTPUT.
> 
> User-space wasn't able to do anything with UHID_OUTPUT_EV, anyway. They
> don't have access to the report fields.

I like your patchset overall, but this looks like userspace breakage?

Thanks,
Henrik
