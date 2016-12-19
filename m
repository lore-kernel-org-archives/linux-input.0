From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: multitouch: enable the Surface 4 Type Cover Pro
 (JP) to report multitouch data
Date: Mon, 19 Dec 2016 11:32:46 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191132390.19203@cbobk.fhfr.pm>
References: <OSXPR01MB07910E8C8EB8956289148EC6F2910@OSXPR01MB0791.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48381 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755115AbcLSKct (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 05:32:49 -0500
In-Reply-To: <OSXPR01MB07910E8C8EB8956289148EC6F2910@OSXPR01MB0791.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yuta Kobayashi <alu.ula@outlook.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 19 Dec 2016, Yuta Kobayashi wrote:

> From: Yuta Kobayashi <alu.ula@outlook.com>
> 
> Since commit 8fe89ef076fa1 ("HID: multitouch: enable the Surface 3 Type
> Cover to report multitouch data"), the TypeCover can be properly handled
> by hid-multitouch and don't require any special quirk in the kernel.
> 
> Remove the support of the Surface 4 Type Cover Pro (JP) from
> hid-microsoft so it can properly report multitouch from the touchpad.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

