From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Switch turbox/mosart touchscreen to hid-mosart
Date: Sat, 8 Jan 2011 16:28:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101081627250.26685@pobox.suse.cz>
References: <1294485342-2492-1-git-send-email-benjamin.tissoires@enac.fr> <1294485342-2492-2-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294485342-2492-2-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 8 Jan 2011, Benjamin Tissoires wrote:

> This device used the MULTI_INPUT quirk whereas it could be used
> with hid-mosart instead to support the multitouch part.
> 
> Reference: https://bugs.launchpad.net/ubuntu/+bug/620609/
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Applied to 'multitouch' part, and will be pushing it to Linus together 
with the hid-multitouch bits in the second merge round. Thanks,

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
