From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: The address of query8 must be calculated based
 on which query registers are present
Date: Tue, 9 Dec 2014 09:08:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412090907490.14413@pobox.suse.cz>
References: <1418079720-11766-1-git-send-email-aduggan@synaptics.com> <1418079720-11766-2-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418079720-11766-2-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Mon, 8 Dec 2014, Andrew Duggan wrote:

> If a touchpad does not report relative data then query 6 will not be present and the address
> of query 8 will be one less. This patches calculates the location of query 8 instead of
> hardcoding the offset.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to hid.git#for-3.19/rmi as well.

-- 
Jiri Kosina
SUSE Labs
