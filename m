From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] hid: sony: Fix duplicate check logic and other
 cleanups
Date: Mon, 26 Sep 2016 15:36:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609261536250.22028@cbobk.fhfr.pm>
References: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935875AbcIZNgh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Sep 2016 09:36:37 -0400
In-Reply-To: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com

On Thu, 22 Sep 2016, Frank Praznik wrote:

> This set of patches fixes a case where the duplicate check incorrectly
> rejects valid devices and cleans up the behavior when a DualShock 3 is
> initially connected.  It also adds a bit of documentation regarding the
> DualShock 4 reporting rate as there have been a few cases where users
> needed to slow it down since the full rate can be too much for some
> slow embedded devices.

Applied to hid.git#for-4.9/sony. Thanks,

-- 
Jiri Kosina
SUSE Labs

