From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Use LED_CORE_SUSPENDRESUME
Date: Mon, 6 Mar 2017 13:47:16 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061345350.31814@cbobk.fhfr.pm>
References: <20170208185843.5822-1-frank.praznik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753862AbdCFMrU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 07:47:20 -0500
In-Reply-To: <20170208185843.5822-1-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, roderick.colenbrander@sony.com, simon@mungewell.org, tim.bird@am.sony.com, dmitry.torokhov@gmail.com

On Wed, 8 Feb 2017, Frank Praznik wrote:

> The LED subsystem provides the LED_CORE_SUSPENDRESUME flag to handle
> automatically turning off and restoring the state of device LEDs during
> suspend/resume.  Use this flag instead of saving and restoring the state
> locally.
> 
> Signed-off-by: Frank Praznik <frank.praznik@gmail.com>

Applied to for-4.11/sony. Thanks,

-- 
Jiri Kosina
SUSE Labs

