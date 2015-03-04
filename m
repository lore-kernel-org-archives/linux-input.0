From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Kconfig: add USB_HID dependency to UC-LOGIC
Date: Wed, 4 Mar 2015 17:34:16 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503041734000.26925@pobox.suse.cz>
References: <1425486295-27283-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425486295-27283-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On Wed, 4 Mar 2015, Benjamin Tissoires wrote:

> In commit 08177f4 (HID: uclogic: merge hid-huion driver in hid-uclogic)
> HID_HUION depends explicitely on USB_HID because it contained quite some
> USB-isms.
> 
> Now that hid-uclogic is the new home of Huion tablets, we need to also
> add the dependency on USB_HID to this driver.
> 
> Reported-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> [CCing the DIGImend folks as a followup, this one is for upstream only]

Applied to for-4.1/huion-uclogic-merge branch, thanks.

-- 
Jiri Kosina
SUSE Labs
