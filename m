From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCHv2] hid: remove duplicate ID for D-WAV eGalax 0x7224
Date: Tue, 07 May 2013 16:48:05 +0200
Message-ID: <51891425.5070300@redhat.com>
References: =?ISO-8859-1?Q?=20<1367936944-1624?= =?ISO-8859-1?Q?9-2-git-send-ema?=
	=?ISO-8859-1?Q?il-andriy.shevch?= =?ISO-8859-1?Q?enko@linux.intel?=
	=?ISO-8859-1?Q?.com=1B[B=1B[B=1B[B>?= <1367937493-16844-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17401 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031Ab3EGOsK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 May 2013 10:48:10 -0400
In-Reply-To: <1367937493-16844-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 05/07/2013 04:38 PM, Andy Shevchenko wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

I bet it will be easier to track for Jiri if you resend the full series:
- the egalax reordering
- the remove of the duplicate ID

As mentioned previously, also remove the entry in hid-multitouch (the
one containing MT_CLS_EGALAX, not the _SERIAL one).

Cheers,
Benjamin

>  drivers/hid/hid-ids.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 2378a0b..a5520ba 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -268,7 +268,6 @@
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C	0x720c
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
> -#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A	0x722A
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E	0x725e
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262	0x7262
> 

