From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: Synchronize MT frame on reset_resume
Date: Wed, 30 Mar 2016 09:46:28 +0200
Message-ID: <20160330074628.GE20424@mail.corp.redhat.com>
References: <1459282241-25154-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55814 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbcC3Hqd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Mar 2016 03:46:33 -0400
Content-Disposition: inline
In-Reply-To: <1459282241-25154-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bleung@chromium.org

On Mar 29 2016 or thereabouts, Gabriele Mazzotta wrote:
> input_mt_get_slot_by_key() requires input_mt_sync_frame() to be called
> at each frame. Do it when releasing the touches, or else we won't get
> a proper slot number after mt_reset_resume().
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Thanks for the fix (I should have spot that earlier :( )

Reviewed-by: Benjamin TIssoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-multitouch.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 25d3c43..c741f5e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1169,6 +1169,7 @@ static void mt_release_contacts(struct hid_device *hid)
>  							   MT_TOOL_FINGER,
>  							   false);
>  			}
> +			input_mt_sync_frame(input_dev);
>  			input_sync(input_dev);
>  		}
>  	}
> -- 
> 2.8.0.rc3
> 
