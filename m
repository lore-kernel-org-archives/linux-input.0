From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH resend 2/2] input/serio/8042: Add firmware_id support
Date: Wed, 9 Apr 2014 19:29:26 +0100
Message-ID: <20140409182926.GB3196@srcf.ucam.org>
References: <1397033270-29597-1-git-send-email-hdegoede@redhat.com>
 <1397033270-29597-3-git-send-email-hdegoede@redhat.com>
 <20140409182434.GA25308@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47790 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933323AbaDIS3b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 14:29:31 -0400
Content-Disposition: inline
In-Reply-To: <20140409182434.GA25308@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

On Wed, Apr 09, 2014 at 11:24:34AM -0700, Dmitry Torokhov wrote:

> Do we need all IDs? I'd expect we only interested in HID, not CIDs?

I think HID handles the cases we've seen so far, but we could imagine a 
system vendor providing their own HID, a trackpad vendor's CID and then 
the generic mouse CID. It seems better to err on the side of including 
them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
