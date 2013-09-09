From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 7/7] HID: logitech-dj: validate output report details
Date: Mon, 09 Sep 2013 15:44:36 +0200
Message-ID: <522DD0C4.2080408@redhat.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org> <1378312645-27736-8-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46200 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab3IINop (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Sep 2013 09:44:45 -0400
In-Reply-To: <1378312645-27736-8-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

On 04/09/13 18:37, Kees Cook wrote:
> A HID device could send a malicious output report that would cause the
> logitech-dj HID driver to leak kernel memory contents to the device, or
> trigger a NULL dereference during initialization:
> 
> [  304.424553] usb 1-1: New USB device found, idVendor=046d, idProduct=c52b
> ...
> [  304.780467] BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
> [  304.781409] IP: [<ffffffff815d50aa>] logi_dj_recv_send_report.isra.11+0x1a/0x90
> 
> CVE-2013-2895
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---
>  drivers/hid/hid-logitech-dj.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index cd33084..404f2d0 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -461,7 +461,7 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
>  	struct hid_report *report;
>  	struct hid_report_enum *output_report_enum;
>  	u8 *data = (u8 *)(&dj_report->device_index);
> -	int i;
> +	unsigned int i, length;
>  
>  	output_report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
>  	report = output_report_enum->report_id_hash[REPORT_ID_DJ_SHORT];
> @@ -471,7 +471,9 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
>  		return -ENODEV;
>  	}
>  
> -	for (i = 0; i < report->field[0]->report_count; i++)
> +	length = min_t(size_t, sizeof(*dj_report) - 1,
> +			       report->field[0]->report_count);
> +	for (i = 0; i < length; i++)

I would rather simply do:
	for (i = 0; i < DJREPORT_SHORT_LENGTH - 1; i++)


>  		report->field[0]->value[i] = data[i];
>  
>  	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
> @@ -783,6 +785,12 @@ static int logi_dj_probe(struct hid_device *hdev,
>  		goto hid_parse_fail;
>  	}
>  
> +	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, REPORT_ID_DJ_SHORT,
> +				 0, 3)) {

and here:
	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, REPORT_ID_DJ_SHORT,
				 0, DJREPORT_SHORT_LENGTH - 1)) {

3 seems to come from nowhere, and is also wrong because in logi_dj_recv_switch_to_dj_mode(), we write 4 bytes.

Besides this small nitpick, there is the same problem that I spotted in hid-steelseries, in case of a failure, the hid device is not cleaned correctly.

Cheers,
Benjamin

> +		retval = -ENODEV;
> +		goto hid_parse_fail;
> +	}
> +
>  	/* Starts the usb device and connects to upper interfaces hiddev and
>  	 * hidraw */
>  	retval = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> 

