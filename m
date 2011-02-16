From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add IRTOUCH infrared USB to
 hid_have_special_driver
Date: Wed, 16 Feb 2011 18:38:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102161837140.2160@pobox.suse.cz>
References: <1297780428-3805-1-git-send-email-benjamin.tissoires@enac.fr> <alpine.LNX.2.00.1102160003420.2160@pobox.suse.cz> <AANLkTi=QF-9QtGK8V795R9ZO4-c6sQ8MSTW+JMxwd2+d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40289 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab1BPRiO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Feb 2011 12:38:14 -0500
In-Reply-To: <AANLkTi=QF-9QtGK8V795R9ZO4-c6sQ8MSTW+JMxwd2+d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 Feb 2011, Benjamin Tissoires wrote:

> Thanks for applying those two patches.
> BTW I'm a little worried: apparently you applied this patch in the
> branch upstream-fixes but you didn't applied "HID: hid-multitouch:
> introduce IrTouch Infrared USB..." and it's parents in this branch....
> I'm afraid this will broke compilation of the upstream branch
> (USB_VENDOR_ID_IRTOUCHSYSTEMS and USB_DEVICE_ID_IRTOUCH_INFRARED_USB
> are not defined).

Hi,

yes, I pushed the patch to wrong remote branch yesterday, but apparently 
sync to git.kernel.org in which I fixed it hasn't made it yet for some 
reason.

Sorry for the noise,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
