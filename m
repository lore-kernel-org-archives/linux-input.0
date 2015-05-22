From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
Date: Fri, 22 May 2015 09:49:09 -0700
Message-ID: <20150522164909.GA40101@dtor-ws>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33246 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757720AbbEVQtO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 12:49:14 -0400
Received: by iebgx4 with SMTP id gx4so35453001ieb.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2015 09:49:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org

On Fri, May 22, 2015 at 04:37:12PM +0200, Ulf Hansson wrote:
> On 14 April 2015 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > The legacy system PM support has long time ago been dropped from the
> > AMBA bus. Align to that by converting to the modern system PM
> > callbacks.
> >
> > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> What happened with this one? Can we queue it for 4.2?

I was hoping that Russel could give it a spin since he has the
relevant hardware.

Thanks.

-- 
Dmitry
