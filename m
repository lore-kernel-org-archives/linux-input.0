From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] hid/hid-sony: fix sony_set_operational_bt
Date: Fri, 30 Apr 2010 00:23:30 +0100
Message-ID: <1272583410.2582.441.camel@localhost.localdomain>
References: <1272578374-9250-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272578374-9250-1-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 2010-04-29 at 23:59 +0200, Antonio Ospite wrote:
> Don't send the report type as part of the data, this prevents the
> controller from going into the operational state at all.
> 
> This is completely equivalent to what the code originally meant to accomplish:
> as per in net/bluetooth/hidp/core.c::hidp_output_raw_report(), by using
> HID_FEATURE_REPORT here, what will be actually sent is
> (HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE) which is exactly 0x53.
> 
> Signed-off-by: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>

My mistake there. I should have tested the patch at run-time, and not
trusted my copy-paste skills :(

Signed-off-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
