From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 1/1] Don't Send Feature Reports on Interrupt
 Endpoint
Date: Wed, 22 Sep 2010 13:23:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009221322310.26813@pobox.suse.cz>
References: <4C98EAAE.3020409@signal11.us> <1285106792-5818-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285106792-5818-1-git-send-email-alan@signal11.us>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Tue, 21 Sep 2010, Alan Ott wrote:

> Feature reports should only be sent on the control endpoint.
> 
> The USB HID standard is unclear and confusing on this issue. It seems to
> suggest that Feature reports can be sent on a HID device's Interrupt OUT
> endpoint.  This cannot be the case because the report type is not encoded in
> transfers sent out the Interrput OUT endpoint.  If Feature reports were sent
> on the Interrupt OUT endpint, they would be indistinguishable from Output
> reports in the case where Report IDs were not used.
> 
> Further, Windows and Mac OS X do not send Feature reports out the interrupt
> OUT Endpoint.  They will only go out the Control Endpoint.
> 
> In addition, many devices simply do not hande Feature reports sent out the Interrupt OUT endpoint.
> 
> Reported-by: simon@mungewell.org
> Signed-off-by: Alan Ott <alan@signal11.us>
> ---
>  drivers/hid/usbhid/hid-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index b729c02..b0ccc42 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -807,7 +807,7 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
>  	struct usb_host_interface *interface = intf->cur_altsetting;
>  	int ret;
>  
> -	if (usbhid->urbout) {
> +	if (usbhid->urbout && report_type != HID_FEATURE_REPORT) {
>  		int actual_length;
>  		int skipped_report_id = 0;
>  		if (buf[0] == 0x0) {

Applied to the 'logitech' branch (as Simon's new Logitech driver is 
depending on this).

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
