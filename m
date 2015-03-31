From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] hid-ids.h: fix typo
Date: Tue, 31 Mar 2015 22:00:36 +0200
Message-ID: <551AFCE4.80106@suse.cz>
References: <1427805377-13568-1-git-send-email-oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33632 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbbCaUAl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 16:00:41 -0400
In-Reply-To: <1427805377-13568-1-git-send-email-oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>, linux-input@vger.kernel.org
Cc: stable@vger.kernel.org

On 03/31/2015, 02:36 PM, Oliver Neukum wrote:
> There is a typo in a device ID

Hi, this should have gone to jikos instead ;).

> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> CC: stable@vger.kernel.org
> ---
>  drivers/hid/hid-ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 56a4ed6..4ee0fb0 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -555,7 +555,7 @@
>  
>  #define USB_VENDOR_ID_LOGITECH		0x046d
>  #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
> -#define USB_DEVICE_ID_LOGITECH_C077	0xc007
> +#define USB_DEVICE_ID_LOGITECH_C077	0xc077
>  #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
>  #define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST  0xc110
>  #define USB_DEVICE_ID_LOGITECH_HARMONY_LAST 0xc14f
> 


-- 
js
suse labs
