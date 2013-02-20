From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 5/7] input: atmel_mxt_ts: only apply mxt_platform_data
 blen and threshold on mxt224, not mxt224e
Date: Wed, 20 Feb 2013 23:33:58 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1302202323380.18013@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net> <1360246668-2291-6-git-send-email-pmeerw@pmeerw.net> <CAPDwgkPK2Eb_7Sc_MJggkhEXJV-7+H992NO-Vo8FPC=-h5Y_5w@mail.gmail.com> <CANLzEksqdtsqLM-pNa=EeaSS0jp7nJ7LJcgGSd_d1aXVsmOPyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56721 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab3BTWeC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 17:34:02 -0500
In-Reply-To: <CANLzEksqdtsqLM-pNa=EeaSS0jp7nJ7LJcgGSd_d1aXVsmOPyA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: Yufeng Shen <miletus@google.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, y0922.shim@samsung.com

Hello,

> Furthermore, this patch has the effect of only applying blen and
> tchthr when voltage is present.
 
> If this is a 224 device, but the platform data does not specify
> voltage (say, we are ok with the existing value loaded from NVRAM),
> then we won't apply blen and tchthr either.

I think all those specific settings in handle_pdata() should be removed 
altogether:

burst length is only the upper 4 bits actually;
for the touchscreen threshold I think there are additional registers 
elsewhere which should be kept in sync

expect not using pdata at all, there is no way to NOT make these settings

I think there are other places (on the mxt224e) as well where the 
orientation has to be set, so pdata->orient setting 
MXT_TOUCH_MULTI_T9@MXT_TOUCH_ORIENT is only half of the story, you still 
need correct pdata->config and pdata->orient is basically useless

the idea of the patch was to preserve the behaviour on the mxt224 but 
disable at least those two dubious settings; clearly not perfect

> On Wed, Feb 20, 2013 at 10:29 AM, Yufeng Shen <miletus@google.com> wrote:
> > On Thu, Feb 7, 2013 at 9:17 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> >>         /* Set touchscreen voltage */
> >>         if (pdata->voltage && data->info.family_id == MXT224_ID) {
> >
> > As Benson noted in patch 5, what about the device that is neither 224
> > nor 224E ? burst length
> > and  threshold will no longer be applied.

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
