From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input: ad714x - fix endianness issues
Date: Tue, 23 Aug 2011 09:50:25 -0700
Message-ID: <20110823165025.GA25627@core.coreip.homeip.net>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com>
 <1313957345-22608-2-git-send-email-dmitry.torokhov@gmail.com>
 <20110823162257.GC26317@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59737 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab1HWQuc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 12:50:32 -0400
Received: by ywf7 with SMTP id 7so228484ywf.19
        for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 09:50:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110823162257.GC26317@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org

On Tue, Aug 23, 2011 at 05:22:57PM +0100, Mark Brown wrote:
> On Sun, Aug 21, 2011 at 01:09:03PM -0700, Dmitry Torokhov wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> > 
> > Allow driver to be used on Big Endian boxes.
> > 
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> Might the regmap API be helpful here?

Looks like it might ;)... But as a follow-up for 3.2.

Thanks.

-- 
Dmitry
