From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] HID: wacom: Add module description
Date: Thu, 29 Mar 2012 16:46:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1203291641330.25526@pobox.suse.cz>
References: <1332969217-10727-1-git-send-email-przemo@firszt.eu> <1332969217-10727-3-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab2C2Oqo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 10:46:44 -0400
In-Reply-To: <1332969217-10727-3-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: pinglinux@gmail.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org

On Wed, 28 Mar 2012, Przemo Firszt wrote:

> Add description for hid-wacom module: "Driver for Wacom Graphire Bluetooth
> and Wacom Intuos4 WL"
> 
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> ---
>  drivers/hid/hid-wacom.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index f130f40..fb0fe16 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -687,5 +687,5 @@ static void __exit wacom_exit(void)
>  
>  module_init(wacom_init);
>  module_exit(wacom_exit);
> +MODULE_DESCRIPTION("Driver for Wacom Graphire Bluetooth and Wacom Intuos4 WL");

I am a little bit unsure about having the information about supported 
models duplicate in Kconfig and MODULE_DESCRIPTION() ... it's just adding 
more places that we will forget to update once support for a new device 
line is added.

Applied, but not fully convinced.

Thanks,

-- 
Jiri Kosina
SUSE Labs
