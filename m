From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 2/3] HID: rmi: Support touchpads with external
 buttons
Date: Mon, 12 Jan 2015 10:14:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501121014220.15299@pobox.suse.cz>
References: <1420757496-3955-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420757496-3955-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Thu, 8 Jan 2015, Andrew Duggan wrote:

> The external buttons on HID touchpads are connected as pass through devices and
> button events are not reported in the rmi registers. As a result on these
> devices we need to allow the HID generic desktop button events to be processed
> by hid-input. Unfortunately, there is no way to query the touchpad to determine
> that it has pass through buttons so the RMI_DEVICE_HAS_PHYS_BUTTONS should be
> set manually when adding the device to rmi_id[].
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to for-3.20/rmi.

-- 
Jiri Kosina
SUSE Labs
