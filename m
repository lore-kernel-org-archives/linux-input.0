From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: udraw-ps3: Add support for the uDraw tablet for
 PS3
Date: Tue, 15 Nov 2016 14:22:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611151422371.29400@cbobk.fhfr.pm>
References: <20161115120205.3364-1-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbcKONWy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 08:22:54 -0500
In-Reply-To: <20161115120205.3364-1-hadess@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 Nov 2016, Bastien Nocera wrote:

> This adds support for the THQ uDraw tablet for the PS3, as
> 4 separate device nodes, so that user-space can easily consume
> events coming from the hardware.
> 
> Note that the touchpad two-finger support is fairly unreliable,
> and a right-click can only be achieved with a two-finger tap
> with the two fingers slightly apart (about 1cm should be enough).

Applied to hid.git#for-4.10/udraw-ps3

-- 
Jiri Kosina
SUSE Labs

