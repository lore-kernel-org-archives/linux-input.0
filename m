From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHv4 0/5] HID: sony: Dualshock3 USB and LED support
Date: Wed, 20 Nov 2013 10:02:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311201002360.31451@pobox.suse.cz>
References: <1384889192-18488-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44433 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855Ab3KTJCs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Nov 2013 04:02:48 -0500
In-Reply-To: <1384889192-18488-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-input@vger.kernel.org

On Tue, 19 Nov 2013, Sven Eckelmann wrote:

> this is a resent of the patchset "[PATCHv3 0/5] HID: sony: Dualshock3 USB FF
> deadlock fix and LED support". It is necessary because the patches 2-5 of that
> patchset cannot be applied anymore. This happened because the v2 of the patch
> "HID: sony: Send FF commands in non-atomic context" instead of the v3 was
> applied in the repository jikos/hid.git. The differences between these two
> patch versions can now be found in the new patch "[PATCHv4 1/5] HID: sony:
> Rename rumble_* functions/variables to state_*"

Queued for 3.14. Thanks,

-- 
Jiri Kosina
SUSE Labs
