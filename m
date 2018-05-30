From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: fix calculation of last slot field in
 multi-touch reports
Date: Wed, 30 May 2018 08:54:07 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1805300853520.27054@cbobk.fhfr.pm>
References: <20180529225655.214380-1-benchan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529225655.214380-1-benchan@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Chan <benchan@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, dtor@chromium.org, drinkcat@chromium.org
List-Id: linux-input@vger.kernel.org

On Tue, 29 May 2018, Ben Chan wrote:

> According to [1] and also seemingly agreed by [2], the Scan Time usage
> (0x0D 0x56) is a report level usage, not a contact level usage.
> 
> However, the hid-multitouch driver currently includes HID_DG_SCANTIME
> when calculating `td->last_slot_field', which may lead to
> mt_complete_slot() being prematurely called in certain cases (e.g. when
> each touch input report includes more than one contact and the Scan Time
> usage appears before any contact logical collection).
> 
> This patch fixes the issue by skipping mt_store_field() on
> HID_DG_SCANTIME, similar to how HID_DG_CONTACTCOUNT and
> HID_DG_CONTACTMAX are handled.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-precision-touchpad-required-hid-top-level-collections#windows-precision-touchpad-input-reports
> [2] https://patchwork.kernel.org/patch/1742181/
> 
> Fixes: 29cc309d8bf19 ("HID: hid-multitouch: forward MSC_TIMESTAMP")
> Signed-off-by: Ben Chan <benchan@chromium.org>

Applied, thanks Ben.

-- 
Jiri Kosina
SUSE Labs
