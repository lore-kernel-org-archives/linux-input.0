From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: hid-sony: Fix DS4 controller reporting rate
 issues
Date: Wed, 29 Jul 2015 14:19:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507291419110.925@pobox.suse.cz>
References: <1438069127-24710-1-git-send-email-atomnuker@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438069127-24710-1-git-send-email-atomnuker@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rostislav Pehlivanov <atomnuker@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>
List-Id: linux-input@vger.kernel.org

On Tue, 28 Jul 2015, Rostislav Pehlivanov wrote:

>  This commit removes the cap on the DualShock 4 controller reporting
> rate when connected using Bluetooth. The previous value of '0xB0'
> capped the rate to only 20.83 Hz which many userspace utilities
> mistook as a sign of a bad signal. Since a 'B' and an '8' can look
> similar it's possible that someone mistook the one for another.
> The new value of '0x80' enables the full 1000 Hz peak reporting
> rate that the controller is capable of.
> 
> Signed-off-by: Rostislav Pehlivanov <atomnuker@gmail.com>
> ---
>  drivers/hid/hid-sony.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index ed2f008..3a6b6a9 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1836,7 +1836,7 @@ static void dualshock4_state_worker(struct work_struct *work)
>  	} else {
>  		memset(buf, 0, DS4_REPORT_0x11_SIZE);
>  		buf[0] = 0x11;
> -		buf[1] = 0xB0;
> +		buf[1] = 0x80;
>  		buf[3] = 0x0F;
>  		offset = 6;

This got added by Frank in commit fdcf105d3d ("HID: sony: Add Dualshock 4 
Bluetooth output report formatting"). Adding him to CC to double-check.

-- 
Jiri Kosina
SUSE Labs
