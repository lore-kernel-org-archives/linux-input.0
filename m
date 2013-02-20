From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 5/7] input: atmel_mxt_ts: only apply mxt_platform_data
 blen and threshold on mxt224, not mxt224e
Date: Wed, 20 Feb 2013 10:50:55 -0800
Message-ID: <CANLzEksqdtsqLM-pNa=EeaSS0jp7nJ7LJcgGSd_d1aXVsmOPyA@mail.gmail.com>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
	<1360246668-2291-6-git-send-email-pmeerw@pmeerw.net>
	<CAPDwgkPK2Eb_7Sc_MJggkhEXJV-7+H992NO-Vo8FPC=-h5Y_5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:62685 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934598Ab3BTSu4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 13:50:56 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so7876163obc.4
        for <linux-input@vger.kernel.org>; Wed, 20 Feb 2013 10:50:56 -0800 (PST)
In-Reply-To: <CAPDwgkPK2Eb_7Sc_MJggkhEXJV-7+H992NO-Vo8FPC=-h5Y_5w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yufeng Shen <miletus@google.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

Furthermore, this patch has the effect of only applying blen and
tchthr when voltage is present.

If this is a 224 device, but the platform data does not specify
voltage (say, we are ok with the existing value loaded from NVRAM),
then we won't apply blen and tchthr either.


On Wed, Feb 20, 2013 at 10:29 AM, Yufeng Shen <miletus@google.com> wrote:
> On Thu, Feb 7, 2013 at 9:17 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>>         /* Set touchscreen voltage */
>>         if (pdata->voltage && data->info.family_id == MXT224_ID) {
>
> As Benson noted in patch 5, what about the device that is neither 224
> nor 224E ? burst length
> and  threshold will no longer be applied.
>


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
