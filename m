From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add IRTOUCH infrared USB to
 hid_have_special_driver
Date: Wed, 16 Feb 2011 00:04:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102160003420.2160@pobox.suse.cz>
References: <1297780428-3805-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297780428-3805-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 15 Feb 2011, Benjamin Tissoires wrote:

> Without this patch, the device is handled by hidinput and does
> not have the right behavior.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---
> Hi guys,
> 
> In the previous patch including the support to IRTOUCH devices, I forgot 
> to add it to hid_have_special_driver. Sorry.

Hmm, this happens quite often to people submitting patches, but I normally 
catch it. This time my eyes have failed.

Thanks for the fix, applied.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
