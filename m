From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix hid_device_id for cross compiling
Date: Thu, 30 Oct 2008 00:23:32 -0700
Message-ID: <20081030002332.4ef1fac4.akpm@linux-foundation.org>
References: <jevdvgl345.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754123AbYJ3HYP@vger.kernel.org>
In-Reply-To: <jevdvgl345.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-input@ver.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 26 Oct 2008 00:30:18 +0200 Andreas Schwab <schwab@suse.de> wrote:

> struct hid_device_id contains hidden padding which is bad for cross
> compiling.  Make the padding explicit and consistent across
> architectures.
> 

What is "bad" about it?  Can you expand a bit on the problem which is
being fixed here?  Before-and-after user-visible behaviour?

Thanks.

> ---
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index eb71b45..0e4f303 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -135,6 +135,7 @@ struct usb_device_id {
>  
>  struct hid_device_id {
>  	__u16 bus;
> +	__u16 pad1;
>  	__u32 vendor;
>  	__u32 product;
>  	kernel_ulong_t driver_data
