From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: kye: Fix missing break in kye_report_fixup()
Date: Mon, 02 Dec 2013 09:34:54 -0500
Message-ID: <529C9A8E.2070605@redhat.com>
References: <1385838747.2760.4.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17397 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab3LBOfE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Dec 2013 09:35:04 -0500
In-Reply-To: <1385838747.2760.4.camel@deadeye.wl.decadent.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>, Jiri Kosina <jkosina@suse.cz>
Cc: Adam Kulagowski <fidor@fidor.org>, linux-input@vger.kernel.org

On 30/11/13 14:12, Ben Hutchings wrote:
> The change to support Genius Manticore Keyboard also changed behaviour
> for Genius Gx Imperator Keyboard, as there is no break between the
> cases.  This is presumably a mistake.
> 
> Reported by Coverity as CID 1134029.
> 
> Fixes: 4a2c94c9b6c0 ('HID: kye: Add report fixup for Genius Manticore Keyboard')
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/hid/hid-kye.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
> index ecb5ca6..e776963 100644
> --- a/drivers/hid/hid-kye.c
> +++ b/drivers/hid/hid-kye.c
> @@ -341,6 +341,7 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  	case USB_DEVICE_ID_GENIUS_GX_IMPERATOR:
>  		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 83,
>  					"Genius Gx Imperator Keyboard");
> +		break;
>  	case USB_DEVICE_ID_GENIUS_MANTICORE:
>  		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
>  					"Genius Manticore Keyboard");
> 

Jiri already applied this one, but FWIW:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for spotting this,
Benjamin
