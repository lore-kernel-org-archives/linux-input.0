From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] Support more Mayflash game contoller adapters.
Date: Wed, 11 Jan 2017 22:13:08 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701112213010.25515@cbobk.fhfr.pm>
References: <20170107110926.GA14173@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45131 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760273AbdAKVNh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2017 16:13:37 -0500
In-Reply-To: <20170107110926.GA14173@arch-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Hasler <mahasler@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Robert de Rooy <robert.de.rooy@gmail.com>

On Sat, 7 Jan 2017, Marcel Hasler wrote:

> This patchset improves support for the Mayflash DolphinBar and GameCube adapters. These have been tested by Robert de Rooy and confirmed to work correctly using the following patches. See Bugzilla entry 115841 (https://bugzilla.kernel.org/show_bug.cgi?id=115841) for more information.
> 
> Marcel Hasler (2):
>   hid: Add a new device ID for updated Mayflash/Dragonrise GameCube adapter.
>   hid-mf: Add force feedback support for Mayflash DolphinBar and GameCube adapters.
> 
>  drivers/hid/hid-core.c          |  3 +++
>  drivers/hid/hid-ids.h           |  3 ++-
>  drivers/hid/hid-mf.c            | 19 ++++++++++++++-----
>  drivers/hid/usbhid/hid-quirks.c |  2 +-
>  4 files changed, 20 insertions(+), 7 deletions(-)

Applied to for-4.11/mayflash, thanks.

-- 
Jiri Kosina
SUSE Labs

