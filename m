From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 1 Apr 2012 21:49:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204012147270.16928@pobox.suse.cz>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz> <CALu8Fe9=itXEMO38vMQ9GsER0s-J=XxQ4+RAxZvMX7gEGuTHrA@mail.gmail.com> <CANq1E4QrSdoEHtJeNH3k4FU7S0WQKRadJB9qMTG+q+khVgqBsg@mail.gmail.com>
 <4F78B036.8070207@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59410 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab2DATta (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Apr 2012 15:49:30 -0400
In-Reply-To: <4F78B036.8070207@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input <linux-input@vger.kernel.org>

On Sun, 1 Apr 2012, Nikolai Kondrashov wrote:

> However, I plan to make a non-HID driver for Waltop tablets, using their 
> proprietary, HID-incompatible protocol and there I will probably use 
> that.

Hi Nick,

is this for new tablets only, or are you planning to move the support from 
hid-waltop away into this new driver?

The ones currently supported by hid-waltop seem to be covered pretty 
nicely with only report descriptors fixups being necessary; is this still 
a limited support not covering the full device capabilities?

Just curious.

Thanks,

-- 
Jiri Kosina
SUSE Labs
