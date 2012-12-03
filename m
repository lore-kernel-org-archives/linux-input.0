From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 0/4] Cypress PS/2 Trackpad driver
Date: Mon, 3 Dec 2012 08:50:04 +0100
Message-ID: <20121203075004.GA2817@polaris.bitmath.org>
References: <1354226281-3476-1-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:41318 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab2LCHsV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Dec 2012 02:48:21 -0500
Content-Disposition: inline
In-Reply-To: <1354226281-3476-1-git-send-email-kamal@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Dudley Du <dudl@cypress.com>, Cypress Semiconductor Corporation <customercare@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>

Hi Kamal,

>   Patch #2 (main driver), as recommended by Henrik Rydberg[2]:
>   - use input_mt_assign_slots; drop cypress_cal_finger_id.
>   - enable 2-finger-only SEMI_MT; drop cypress_simulate_fingers.
>   - various code clean-ups.
> 
>   Henrik, does patch #2 appear to properly use assign_slots and SEMI_MT as
>   you intended?  This SEMI_MT method does work (with 2 finger support only),
>   but I'm not clear why we wouldn't want to handle >2 fingers also, so ...

It looks pretty good, please see the patch comments for details. As
Dmitry said, one can report the number of fingers separately from the
two guiding contacts, and this semi-mt behavior is well supported in
userspace.

> 
>   Patch #4 (new) reintroduces simulated multitouch for up to 5 fingers
>   (#if CYPRESS_SIMULATE_MT), disabling SEMI_MT again.
> 
>   If that functionality (support for >2 fingers) can be acheived in some
>   better way, please advise.

Yes, as above, so this patch will not be needed.

Thanks,
Henrik
