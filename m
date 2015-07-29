From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: hid-lg: Add USBID for Logitech G29 Wheel
Date: Wed, 29 Jul 2015 14:10:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507291410230.925@pobox.suse.cz>
References: <1437700203-4546-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437700203-4546-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 23 Jul 2015, Simon Wood wrote:

> Since this wheel is now available, and the USBID is listed on their website,
> this patch adds it to allow the hid-lg4ff force feedback driver to find it.
> 
> I do not have this wheel to test with, but this should at least get it working
> in emulation mode.
> 
> Note: There is probably more work required for adjust HID descriptor and handle
> switching between emulation and native modes.
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

I have applied this to for-4.3/logitech (and kept the "Note:" above in the 
changelog).

-- 
Jiri Kosina
SUSE Labs
