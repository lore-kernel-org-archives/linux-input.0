From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: hid-sensor-hub: do not process feature reports in
 raw_even
Date: Wed, 29 May 2013 14:48:10 -0700
Message-ID: <51A6779A.6050709@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21615 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935180Ab3E2VnX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 May 2013 17:43:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi Jiri,

Daniel has tested and confirmed that this patch fixes issue.

Thanks,
Srinivas

-------- Original Message --------
Subject:     Re: Fwd: Re: [PATCH] HID: hid-sensor-hub: do not process 
feature reports in raw_event
Date:     Wed, 29 May 2013 12:49:42 -0700
From:     Daniel Leung <daniel.leung@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>



With this patch, the sensor hub works on the Acer Iconia W700.
The accelerometer and gyroscope are both powered on and are sending
readings.


Daniel


On Wed, 29 May 2013 07:55:44 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

 >
 > Hi Daniel,
 >
 > Can you test this? I will test on the hub I have also.
 >
 > Thanks,
 > Srinivas
 >
 > -------- Original Message --------
 > Subject:     Re: [PATCH] HID: hid-sensor-hub: do not process feature
 > reports in raw_event
 > Date:     Wed, 29 May 2013 16:19:49 +0200 (CEST)
 > From:     Jiri Kosina <jkosina@suse.cz>
 > To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 > CC:     Daniel Leung <daniel.leung@linux.intel.com>,
 > srinivas.pandruvada@intel.com, linux-input@vger.kernel.org,
 > linux-kernel@vger.kernel.org
 >
 >
 >
 > On Wed, 10 Apr 2013, Srinivas Pandruvada wrote:
 >
 > > I don't know if this should be fixed in client drivers since other 
drivers may
 > > have this issue.
 >
 > Agreed.
 >
 > Srinivas, how about the patch below, could you please test it in your
 > scenario to see whether it actually fixes the issue?
 >
 > Thanks.
 >
 >
 > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
 > index 264f550..65879b9 100644
 > --- a/drivers/hid/hid-core.c
 > +++ b/drivers/hid/hid-core.c
 > @@ -1293,7 +1293,7 @@ int hid_input_report(struct hid_device *hid, 
int type, u8 *data, int size, int i
 >
 >       if (hdrv && hdrv->raw_event && hid_match_report(hid, report)) {
 >           ret = hdrv->raw_event(hid, report, data, size);
 > -        if (ret != 0) {
 > +        if (ret < 0) {
 >               ret = ret < 0 ? ret : 0;
 >               goto unlock;
 >           }
 > --
 > Jiri Kosina
 > SUSE Labs
 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-input" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at http://vger.kernel.org/majordomo-info.html
