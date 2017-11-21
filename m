From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 4/4] HID: multitouch: Combine all left-button events
 in a frame
Date: Tue, 21 Nov 2017 13:11:39 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711211310230.11505@cbobk.fhfr.pm>
References: <20171113163259.18150-1-hdegoede@redhat.com> <20171113163259.18150-4-hdegoede@redhat.com> <20171114080229.GE403@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbdKUMLl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Nov 2017 07:11:41 -0500
In-Reply-To: <20171114080229.GE403@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

On Tue, 14 Nov 2017, Benjamin Tissoires wrote:

> > According to the Win8 Precision Touchpad spec, inside the HID_UP_BUTTON
> > usage-page usage 1 is for a clickpad getting clicked, 2 for an external
> > left button and 3 for an external right button. Since Linux uses
> > BTN_LEFT for a clickpad being clicked we end up mapping both usage 1
> > and 2 to BTN_LEFT and if a single report contains both then we ended
> > up always reporting the value of both in a single SYN, e.g. :
> > BTN_LEFT 1, BTN_LEFT 0, SYN. This happens for example with Hantick
> > HTT5288 i2c mt touchpads.
> > 
> > This commit fixes this by not immediately reporting left button when we
> > parse the report, but instead storing or-ing together the values and
> > reporting the result from mt_sync_frame() when we've a complete frame.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> 
> Thanks Hans for the re-spin of the series.
> I think we are good now, series is:
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks. Hans, last request for you -- HID_DG_SCANTIME handling has in the 
meantime added for forwarding the MSC_TIMESTAMP (commit 29cc309d8bf1). 
Could you please respin your patch on top of that (basically just merge 
your handling with the one added for MSC_TIMESTAMP) and resend? I'll then 
queue it for 4.16. Thanks,

-- 
Jiri Kosina
SUSE Labs

