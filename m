From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: lg: restrict filtering out of first interface to
 G29 only
Date: Wed, 2 Dec 2015 14:55:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512021455310.32500@pobox.suse.cz>
References: <1448961984-27413-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448961984-27413-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 1 Dec 2015, Benjamin Tissoires wrote:

> Looks like 29fae1c85 ("HID: logitech: Add support for G29") was a little
> bit aggressive and broke other devices.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=108121
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi Jiri,
> 
> as reported in #108121, this is 4.4-rc material. At least 2 people already
> started complaining about it on the mailing list, so it should definitively
> be fixed before 4.4 is out.

Applied to for-4.4/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs
