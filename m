From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom - Advertise BTN_TOOL_PEN and BTN_STYLUS for
 PenPartner
Date: Fri, 26 Aug 2011 23:30:12 -0700
Message-ID: <20110827063012.GB29434@core.coreip.homeip.net>
References: <1314394285-6994-1-git-send-email-killertofu@gmail.com>
 <CAF8JNhJyptbc6YHH2K3+C=Fxto94GoVApVepStQLGzcepyHUXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:38413 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab1H0GaR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Aug 2011 02:30:17 -0400
Received: by yie30 with SMTP id 30so2193225yie.19
        for <linux-input@vger.kernel.org>; Fri, 26 Aug 2011 23:30:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNhJyptbc6YHH2K3+C=Fxto94GoVApVepStQLGzcepyHUXQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org

On Fri, Aug 26, 2011 at 02:48:43PM -0700, Ping Cheng wrote:
> On Fri, Aug 26, 2011 at 2:31 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> > The Wacom PenPartner should advertise its stylus tip and button
> > in addition to the eraser tool. These are both physically
> > present on the hardware, and emitted from 'wacom_penpartner_irq'.
> >
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> 
> Reviewed-by: Ping Cheng <pingc@wacom.com>

Applied, thanks Jason.

-- 
Dmitry
