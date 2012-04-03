From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Tue, 3 Apr 2012 16:46:44 +0200
Message-ID: <20120403144644.GA16506@polaris.bitmath.org>
References: <4F78BF82.70903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:39143 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2DCOpQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 10:45:16 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 7D18DC565
	for <linux-input@vger.kernel.org>; Tue,  3 Apr 2012 16:45:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4F78BF82.70903@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org

Hi Jiri,

> From: Jiri Kosina <jkosina@xxxxxxx>
> Subject: [PATCH] HID: make hid_parse() reentrant

> It is possible to rebind the drivers on HID bus manually from userspace
> (through sysfs bind/unbind facility). This way, we can easily allow drivers to
> claim device IDs even if this doesn't happen automatically through explicit
> hid_have_special_driver[] entry.

> If driver is rebound, hid_parse() sees the HID_STATE_PARSED flag set, and
> doesn't proceed parsing the report descriptor again.

> This might however be unwanted in cases when the newly rebound driver does
> a report descriptor fixup, as it doesn't get parsed again with the replaced
> values.

> Instead of bailing out directly when HID_STAT_PARSED flag is set, throw
> away the old report descriptor stored in hid_device->rdesc, and let the
> whole rdesc parsing be restarted (with ->report_fixup callback of the newly
> rebound driver being called prior to the actual parsing).

> Signed-off-by: Jiri Kosina <jkosina@xxxxxxx>
> ---
>  include/linux/hid.h |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)

> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 3a95da6..f771eba 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -807,8 +807,16 @@ static inline int __must_check hid_parse(struct hid_devic> e *hdev)
>  {
>  	int ret;
>  
> -	if (hdev->status & HID_STAT_PARSED)
> -		return 0;
> +	if (hdev->status & HID_STAT_PARSED) {
> +		/*
> +		 * We want to be re-entrant to allow for dynamic driver
> +		 * rebinding and still allow rdescs to be replaced and
> +		 * and re-parsed once the driver has been dynamically
> +		 * rebound
> +		 */
> +		kfree(hdev->rdesc);
> +		hdev->status &= ~HID_STAT_PARSED;
> +	}
>  
>  	ret = hdev->ll_driver->parse(hdev);
>  	if (!ret)

It seems an equivalent patch would be to remove HID_STAT_PARSED
altogether, replacing it with something like this:

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 1e68543..456fdbf 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -454,7 +454,6 @@ struct hid_output_fifo {
 #define HID_CLAIMED_HIDRAW     4
 
 #define HID_STAT_ADDED         1
-#define HID_STAT_PARSED                2
 
 struct hid_input {
        struct list_head list;
@@ -811,16 +810,10 @@ static inline void hid_map_usage_clear(struct hid_input *hidinput,
  */
 static inline int __must_check hid_parse(struct hid_device *hdev)
 {
-       int ret;
+       kfree(hdev->rdesc);
+       hdev->rdesc = NULL;
 
-       if (hdev->status & HID_STAT_PARSED)
-               return 0;
-
-       ret = hdev->ll_driver->parse(hdev);
-       if (!ret)
-               hdev->status |= HID_STAT_PARSED;
-
-       return ret;
+       return hdev->ll_driver->parse(hdev);
 }

which makes me wonder if something will break or be called
unnecessarily often as a result?

I think the main logic problem stems from viewing hid devices as being
on the same level as usb/bt devices.  Perhaps report fixups should be
part of the hid_ll_driver layer instead.

Thanks,
Henrik
