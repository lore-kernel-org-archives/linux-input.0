From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/1] HID: multitouch: enable palm rejection if device
 implements confidence usage
Date: Thu, 26 Nov 2015 15:21:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511261521350.20111@pobox.suse.cz>
References: <1448014866-25348-1-git-send-email-allen_hung@dell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448014866-25348-1-git-send-email-allen_hung@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Allen Hung <allen_hung@dell.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, 20 Nov 2015, Allen Hung wrote:

> The usage Confidence is mandary to Windows Precision Touchpad devices. The
> appearance of this usage is checked in hidinput_connect but the quirk
> MT_QUIRK_VALID_IS_CONFIDENCE is not applied to device accordingly.
> Apply this quirk and also remove quirk MT_QUIRK_ALWAYS_VALID to enable palm
> rejection for the WIN 8 touchpad devices which have implemented usage
> Confidence in its input reports.
> 
> Tested on Dell XPS 13 laptop.
> 
> Signed-off-by: Allen Hung <allen_hung@dell.com>

Applied to for-4.5/multitouch. Thanks,

-- 
Jiri Kosina
SUSE Labs
