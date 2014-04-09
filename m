From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend 2/2] input/serio/8042: Add firmware_id support
Date: Wed, 9 Apr 2014 13:09:23 -0700
Message-ID: <20140409200923.GA25808@core.coreip.homeip.net>
References: <1397033270-29597-1-git-send-email-hdegoede@redhat.com>
 <1397033270-29597-3-git-send-email-hdegoede@redhat.com>
 <20140409182434.GA25308@core.coreip.homeip.net>
 <20140409182926.GB3196@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36915 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933342AbaDIUJ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 16:09:26 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so2945366pab.23
        for <linux-input@vger.kernel.org>; Wed, 09 Apr 2014 13:09:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140409182926.GB3196@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

On Wed, Apr 09, 2014 at 07:29:26PM +0100, Matthew Garrett wrote:
> On Wed, Apr 09, 2014 at 11:24:34AM -0700, Dmitry Torokhov wrote:
> 
> > Do we need all IDs? I'd expect we only interested in HID, not CIDs?
> 
> I think HID handles the cases we've seen so far, but we could imagine a 
> system vendor providing their own HID, a trackpad vendor's CID and then 
> the generic mouse CID. It seems better to err on the side of including 
> them.

OK, fair enough. Another question - do we want to prefix IDs with "PNP:"
prefix so that if we add device tree in the future we'll know what kind
of IDs we are dealing with?

-- 
Dmitry
