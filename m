From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Fix a issue that Alps Touchpad cursor does not work
Date: Tue, 27 Sep 2016 13:52:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609271351470.22028@cbobk.fhfr.pm>
References: <1474952677-22887-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58971 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933499AbcI0Lw3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Sep 2016 07:52:29 -0400
In-Reply-To: <1474952677-22887-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kai.heng.feng@canonical.com, masaki.ota@jp.alps.com

On Tue, 27 Sep 2016, Masaki Ota wrote:

> fix Touchpad cursor does not work after touching Touchpad 
> by 3 or more fingers.
> 
> Issue reproduction procedure
> 1.Three or more fingers put on Touchpad.
> 2.release fingers from Touchpad.
> 3.move the cursor by one finger.
> 4.the cursor does not move.
> 
> Cause
> This code does not notify multi fingers state correctly to system.
> For example, when three fingers release from Touchpad,
> fingers state is 3 -> 0. It needs to notify
> first, second and third finger's releasing state.
> But this code does not notify second and third finger's
> releasing state by "break" code.
> 
> Solution
> Delete "break" code, and move xyz input code to the correct place.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>

I have slightly reworded the changelog and applied to for-4.9/alps. 
Thanks,

-- 
Jiri Kosina
SUSE Labs

