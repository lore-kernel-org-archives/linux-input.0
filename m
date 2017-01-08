From: Tomasz Kramkowski <tk@the-tk.com>
Subject: Re: [PATCH 0/2] patches for Innomedia INNEX GENESIS/ATARI adapter
Date: Sun, 8 Jan 2017 14:59:25 +0000
Message-ID: <20170108145925.GA18649@gaia.local>
References: <20161216213130.19303-1-tk@the-tk.com>
 <alpine.LSU.2.20.1612191144240.19203@cbobk.fhfr.pm>
 <alpine.LSU.2.20.1612222153560.19203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:47502 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbdAHPAB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 8 Jan 2017 10:00:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1612222153560.19203@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 22, 2016 at 10:00:10PM +0100, Jiri Kosina wrote:
> We've discussed with Tomasz off-list, and it looks like that there likely 
> is a better and more general way to fix it; this seems to have actually 
> been caused by 6da7066906e977d4 ("HID: ignore absolute values which don't 
> fit between logical min and max"), as it turns out that this check should 
> be applied only in case Null state is set (refer to HID specification 
> 1.11, section 6.2.2.5, p.31), bko#68621.
> 
> Tomasz comitted to look into this after coming back from christmas/new 
> year vacation. I'm putting the innomedia branch on hold for now.
> 
> -- 
> Jiri Kosina
> SUSE Labs

I've tested the patch from the bugzilla and it does indeed prevent the
values being discarded. evtest reports the minimum and maximums
correctly as -1 and 1 but the events give values -2 and 1, I'm not sure
if this will be an issue as jstest correctly sees left/up presses as
-32767 and right/down presses as 32767. The device still needs the
HID_QUIRK_MULTI_INPUT quirk to correctly show up as two event/js
devices.

I will still need to do a few more tests to make sure there are no
issues in other applications and to make sure that other devices still
operate correctly too.

Once that is done I will go ahead and send two patches, one with the
authorship preserved for the bugzilla patch and one patch to add the
quirks.

-- 
Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/
