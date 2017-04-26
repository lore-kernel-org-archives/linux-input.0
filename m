From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: Add HID_QUIRK_NOGET for Aten CS-1758 KVM
 switch
Date: Wed, 26 Apr 2017 10:36:03 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704261035540.12121@cbobk.fhfr.pm>
References: <20170425082644.6375-1-vliaskovitis@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170425082644.6375-1-vliaskovitis@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com
List-Id: linux-input@vger.kernel.org

On Tue, 25 Apr 2017, Vasilis Liaskovitis wrote:

> Like other switches, the Aten CS-1758 KVM switch needs a quirk to avoid
> spewing errors:
> 
> [12599018.071059] usb 5-2: input irq status -75 received
> [12599018.079053] usb 5-2: input irq status -75 received

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
