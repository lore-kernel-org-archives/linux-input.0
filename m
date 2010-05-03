From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] hid/hid-sony: fix sony_set_operational_bt
Date: Mon, 3 May 2010 17:19:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005031719460.9849@pobox.suse.cz>
References: <1272578374-9250-1-git-send-email-ospite@studenti.unina.it> <1272583410.2582.441.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272583410.2582.441.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 30 Apr 2010, Bastien Nocera wrote:

> > Don't send the report type as part of the data, this prevents the
> > controller from going into the operational state at all.
> > 
> > This is completely equivalent to what the code originally meant to accomplish:
> > as per in net/bluetooth/hidp/core.c::hidp_output_raw_report(), by using
> > HID_FEATURE_REPORT here, what will be actually sent is
> > (HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE) which is exactly 0x53.
> > 
> > Signed-off-by: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
> Signed-off-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
