From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: wacom: Set button bits based on a new
 numbered_buttons
Date: Fri, 28 Aug 2015 20:45:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508282045000.25821@pobox.suse.cz>
References: <1440111917-4496-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39931 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbbH1SpW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 14:45:22 -0400
In-Reply-To: <1440111917-4496-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Skomra <skomra@gmail.com>
Cc: benjamin.tissoires@redhat.com, killertofu@gmail.com, pinglinux@gmail.com, linux-input@vger.kernel.org, Aaron Skomra <aaron.skomra@wacom.com>

On Thu, 20 Aug 2015, Aaron Skomra wrote:

> Prior to this commit, numbered button bit setting was done separately
> for each device type in wacom_setup_pad_capabilities(). Here we add a
> numbered_buttons property to the wacom_features struct and extract the
> repeated bit setting code to a new function:
> wacom_settup_numbered_buttons().
> 
> Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
>  drivers/hid/wacom_wac.c | 175 +++++++++++++++++-------------------------------
>  drivers/hid/wacom_wac.h |   1 +
>  2 files changed, 61 insertions(+), 115 deletions(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index baba9a0..a19aeae 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2513,11 +2513,23 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>  	return 0;
>  }
>  
> +void wacom_setup_numbered_buttons(struct input_dev *input_dev,

I made this static, and applied both patches. Thanks,

-- 
Jiri Kosina
SUSE Labs

