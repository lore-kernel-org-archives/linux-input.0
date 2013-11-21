From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: Introduce INPUT_PROP_MT
Date: Wed, 20 Nov 2013 20:57:52 -0800
Message-ID: <20131121045750.GB4702@core.coreip.homeip.net>
References: <1384983141-31019-1-git-send-email-benjamin.tissoires@redhat.com>
 <1384983141-31019-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384983141-31019-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Antonio Ospite <ospite@studenti.unina.it>, simon@mungewell.org, case@corpsmoderne.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Nov 20, 2013 at 04:32:20PM -0500, Benjamin Tissoires wrote:
> There may be a clash with devices presenting a lot of absolute axis
> (like the PS3 Sixaxis) and true multitouch devices. Both those kinds
> of devices may present some ABS_MT_* capabilities, so setting this
> property ensures user-space knows what to do with the input device.
> 

No, let's not use the same ABS_* values to mean different things and
define proper values instead.

Thanks.

-- 
Dmitry
