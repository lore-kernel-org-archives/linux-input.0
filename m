From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Wed, 28 Aug 2013 22:42:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308282241270.22181@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz> <521E60CE.6050000@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58556 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab3H1UmM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 16:42:12 -0400
In-Reply-To: <521E60CE.6050000@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, Kees Cook <keescook@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, srinivas pandruvada <srinivas.pandruvada@intel.com>

On Wed, 28 Aug 2013, Srinivas Pandruvada wrote:

> > A HID device could send a malicious feature report that would cause the
> > sensor-hub HID driver to read past the end of heap allocation, leaking
> > kernel memory contents to the caller.
> > 
> > CVE-2013-2898
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Cc: stable@kernel.org
> > ---
> >   drivers/hid/hid-sensor-hub.c |    3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> > index ca749810..aa34755 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -221,7 +221,8 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device
> > *hsdev, u32 report_id,
> >     	mutex_lock(&data->mutex);
> >   	report = sensor_hub_report(report_id, hsdev->hdev,
> > HID_FEATURE_REPORT);
> > -	if (!report || (field_index >=  report->maxfield)) {
> > +	if (!report || (field_index >=  report->maxfield) ||
> > +	    report->field[field_index]->report_count < 1) {
> Is it based on some HID device is sending junk report or just from a code
> review?

My understanding is that this whole Kees' patchset is about potentially 
evil devices doing bad things (on purpose).

> >   		ret = -EINVAL;
> >   		goto done_proc;
> >   	}
> Thanks,
> Srinivas
> 

-- 
Jiri Kosina
SUSE Labs
