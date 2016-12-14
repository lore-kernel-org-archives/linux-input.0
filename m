From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Issue in applying patch [hid-sensor-hub: clear memory to avoid
 random data]
Date: Wed, 14 Dec 2016 21:33:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612142130490.16984@cbobk.fhfr.pm>
References: <1480546127-3539-1-git-send-email-linux@rasmusvillemoes.dk>  <alpine.LNX.2.00.1612021504170.29400@cbobk.fhfr.pm> <1481740037.3319.3.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933238AbcLNUdH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Dec 2016 15:33:07 -0500
In-Reply-To: <1481740037.3319.3.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Wed, 14 Dec 2016, Srinivas Pandruvada wrote:

> As per the comment here, it seems that you applied v4 version of patch.
> 
> https://patchwork.kernel.org/patch/9428715/
> 
> But when I look at the upstream kernel, the very first version of the
> patch was applied, which was wrong.
> 
> Basically the change should be in sensor_hub_get_feature() not in
> sensor_hub_set_feature().
> Otherwise it breaks sensor functionality.
> 
> How should we handle this?

Hi Srinivas,

my whole queue is now merged by Linus, so any fixups should be submitted 
as standalone patches on top of current Linus' tree; I'll push the fix to 
Linus then for 4.10 still.

Ideally we also put proper "Fixes:" tag, so that it gets picked up by 
4.9-stable once/if there is one.

Thanks, and sorry for my brainfart; I'll check my archives to see what 
went wrong.

-- 
Jiri Kosina
SUSE Labs

