From: simon@mungewell.org
Subject: Re: [PATCHv4 0/5] HID: sony: Dualshock3 USB and LED support
Date: Fri, 22 Nov 2013 21:35:28 -0500
Message-ID: <14946321e34bb704a90c5c95f880dd9d.squirrel@mungewell.org>
References: <1384889192-18488-1-git-send-email-sven@narfation.org>
    <alpine.LNX.2.00.1311201002360.31451@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:43292 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002Ab3KWCfd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Nov 2013 21:35:33 -0500
In-Reply-To: <alpine.LNX.2.00.1311201002360.31451@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Sven Eckelmann <sven@narfation.org>, linux-input@vger.kernel.org

> On Tue, 19 Nov 2013, Sven Eckelmann wrote:
>
>> this is a resent of the patchset "[PATCHv3 0/5] HID: sony: Dualshock3
>> USB FF
>> deadlock fix and LED support". It is necessary because the patches 2-5
>> of that
>> patchset cannot be applied anymore. This happened because the v2 of the
>> patch
>> "HID: sony: Send FF commands in non-atomic context" instead of the v3
>> was
>> applied in the repository jikos/hid.git. The differences between these
>> two
>> patch versions can now be found in the new patch "[PATCHv4 1/5] HID:
>> sony:
>> Rename rumble_* functions/variables to state_*"
>
> Queued for 3.14. Thanks,

I'm a little confused about which kernel this should be in. I believe the
first in this patch series is required for 3.13 (but does not seemed to be
included (1)).

Without this, the kernel will be subject to lockups if anyone actually
uses the force feedback.
Simon

(1) -
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/hid/hid-sony.c

