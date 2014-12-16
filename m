From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: The return value of hid_input_report and raw_event
Date: Tue, 16 Dec 2014 10:27:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412161022480.1680@pobox.suse.cz>
References: <7774789.jK4HDCWEI4@al>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46097 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbaLPJ11 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2014 04:27:27 -0500
In-Reply-To: <7774789.jK4HDCWEI4@al>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: linux-input@vger.kernel.org

On Mon, 15 Dec 2014, Peter Wu wrote:

> Hi Jiri and list,
> 
> The HID core has a hid_input_report function which returns an integer,
> but all its callers are not really changing their behavior based on the
> return value. The few^Wonly exception that does not completely ignore
> the return value is the hid-logitech-dj driver which prints a debugging
> message.
> 
> Should this method be changed to return void? The kerneldoc does not
> document its return value anyway.

Hi Peter,

yes, that definitely would be an acceptable cleanup.

> Confusion 2: the raw_event callback of the hid_driver structure returns
> an int, but over time non-negative values are ignored by
> hid_input_report. This happened in the following change:
> --------------------------------------------------
> commit b1a1442a23776756b254b69786848a94d92445ba
> Author: Jiri Kosina <jkosina@suse.cz>
> Date:   Mon Jun 3 11:27:48 2013 +0200
> 
>     HID: core: fix reporting of raw events
>     
>     hdrw->raw event can return three different return value types:
>     
>     - ret < 0   indicates that the hdrv driver found an error while parsing
>     - ret == 0  indicates no error has been encountered, and the driver has
>                 processed the report
>     - ret > 0   indicates that there was no parsing error, and the driver hasn't
>                 processed the event.
>     
>     Calling hid_report_raw_event() has to be called appropriately so that it
>     reflects what has been done by ->raw_event() callback, otherwise we might
>     updates of the in-kernel structure are lost upon arrival of the report, which
>     is wrong.
>     
>     Reported-and-tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>     Reported-and-tested-by: Daniel Leung <daniel.leung@linux.intel.com>
>     Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index c272078..8f616bd 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1293,7 +1293,7 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
>  
>         if (hdrv && hdrv->raw_event && hid_match_report(hid, report)) {
>                 ret = hdrv->raw_event(hid, report, data, size);
> -               if (ret != 0) {
> +               if (ret < 0) {
>                         ret = ret < 0 ? ret : 0;
>                         goto unlock;
>                 }
> --------------------------------------------------
> 
> So now it does not matter whether the raw_event method returns 0 or 1.
> The documentation says:
> 
>     raw_event and event should return 0 on no action performed, 1 when
>     no further processing should be done and negative on error
> 
> What does "no further processing" mean? I guess that the intention was
> to signal from a HID driver to ignore the packet, but that the above
> change was done to update the state and allow hidraw to pick up the
> report.

This change was done so that we don't call hid_report_raw_event() when 
->raw_event() callback encountered error during parsing (and therefore 
returned negative value).

See this thread

	https://lkml.org/lkml/2013/4/8/540

for an example.

-- 
Jiri Kosina
SUSE Labs
