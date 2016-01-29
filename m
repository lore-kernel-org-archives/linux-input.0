From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: quirks: Add no_init_reports for AKAI midi
 controller
Date: Fri, 29 Jan 2016 16:40:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601291640090.21446@cbobk.fhfr.pm>
References: <alpine.LNX.2.00.1601272230070.21446@cbobk.fhfr.p> <1454074687-17073-1-git-send-email-shorne@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454074687-17073-1-git-send-email-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stafford Horne <shorne@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 29 Jan 2016, Stafford Horne wrote:

> The midi controller times-out while initializing reports, this
> causes boot to take an extra 10 seconds. The device descriptor
> advertises that it has an internal HID device but seems to not
> actually do anything useful.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Resending the same patch for the keyboard to simply disable init reports,
> as discussed with Oliver there might be some hidden functionality which
> I will look into.  At the moment I dont want to worry about time timeouts. 
> 
> Also, I did create and test a patch to use HID_QUIRK_IGNORE which I can 
> send if you feel strongly about it. 

Applied to for-4.5/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
