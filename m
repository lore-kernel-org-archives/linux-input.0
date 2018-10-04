From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] Input: reserve 2 events code because of HID
Date: Thu, 4 Oct 2018 21:09:43 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810042109100.14430@cbobk.fhfr.pm>
References: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 4 Oct 2018, Benjamin Tissoires wrote:

> Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
> a duplicate is found") from the v4.18 kernel, HID used to shift the
> event codes if a duplicate usage was found. This ended up in a situation
> where a device would export a ton of ABS_MISC+n event codes, or a ton
> of REL_MISC+n event codes.
> 
> This is now fixed, however userspace needs to detect those situation.
> Fortunately, ABS_MT_SLOT-1 (ABS_MISC+6) was never assigned a code, and
> so libinput can detect fake multitouch devices from genuine ones by
> checking if ABS_MT_SLOT-1 is set.
> 
> Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
> true high res mice from some other device in a pre-v4.18 kernel.
> 
> Set in stone that the ABS_MISC+6 and REL_MISC+1 are reserved and should not
> be used so userspace can properly work around those old kernels.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Dmitry, I did not take your Acked-by, as I added 2 new events and wanted to
> be sure you are still OK.
> 
> Jiri, this will still need to go through your tree, as the input-event-codes
> changes that introduce REL_WHEEL_HI_RES are in your for-4.20/logitech-highres.

Applied, thanks Benjamin.

-- 
Jiri Kosina
SUSE Labs
