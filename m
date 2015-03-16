From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] pidff driver should work correctly with more than one
 concurrent effect
Date: Mon, 16 Mar 2015 16:12:53 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503161612250.25438@pobox.suse.cz>
References: <0000014bc52a127f-0356eeb8-db7b-4e77-b285-0ab07359baf0-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000014bc52a127f-0356eeb8-db7b-4e77-b285-0ab07359baf0-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Keir <jimkeir@oracledbadirect.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 26 Feb 2015, Jim Keir wrote:

> The PID driver (usbhid/hid-pidff.c) does not set the effect ID when
> uploading an effect. The result is that the initial upload works but
> subsequent uploads to modify effect parameters are all directed at the
> last-created effect.
> 
> The targeted effect ID must be passed back to the device when effect
> parameters are changed. This is done at the start of
> "pidff_set_condition_report", "pidff_set_periodic_report" etc. based on
> the value of "pidff->block_load[PID_EFFECT_
> BLOCK_INDEX].value[0]".
> 
> This value is only ever set during pidff_request_effect_upload.
> The result is stored in "pidff->pid_id[effect->id]" at the end of
> pid_upload_effect, for later use. However, if an effect is modified and
> re-sent then this identifier is not being copied back from
> pidff->pid_id[effect->id] before sending the command to the device. The
> fix is to do this at the start of pidff_upload_effect.
> 
> Signed-off-by: Jim Keir <jimkeir@oracledbadirect.com>

Applied to for-4.1/upstream.

-- 
Jiri Kosina
SUSE Labs
