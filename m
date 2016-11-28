From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: handle external buttons for Precision
 Touchpads
Date: Mon, 28 Nov 2016 14:37:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611281437210.29400@cbobk.fhfr.pm>
References: <1480068490-32765-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932295AbcK1Nhg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 08:37:36 -0500
In-Reply-To: <1480068490-32765-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Chris Chiu <chiu@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 25 Nov 2016, Benjamin Tissoires wrote:

> According to https://msdn.microsoft.com/en-us/library/windows/hardware/mt604195(v=vs.85).aspx
> external buttons have some weird usage mapping:
> - Button 2 Indicates Button State for external button for primary
>   (default left) clicking.
> - Button 3 Indicates Button State for external button for secondary
>   (default right) clicking.
> 
> So in the current state, the buttons are mapped to right and middle.
> Move the usage by one to correctly map the external buttons.
> 
> Tested-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.10/multitouch. Thanks,

-- 
Jiri Kosina
SUSE Labs

