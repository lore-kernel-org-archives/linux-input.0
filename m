From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ADXL34X orientation definition
Date: Mon, 09 Dec 2013 03:18:22 -0800
Message-ID: <51385335.KEjN2ZpnT5@dtor-d630.eng.vmware.com>
References: <20131207095335.GA10573@core.coreip.homeip.net> <52A57B3A.7030607@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53913 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932483Ab3LILS1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Dec 2013 06:18:27 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so5235930pbb.22
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 03:18:27 -0800 (PST)
In-Reply-To: <52A57B3A.7030607@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Monday, December 09, 2013 09:11:38 AM Michael Hennerich wrote:
> On 12/07/2013 10:53 AM, Dmitry Torokhov wrote:
> > Hi Michael,
> > 
> > I was going though Coverity reports and it looks like definition of
> > 
> > #define ADXL346_2D_ORIENT(x)            (((x) & 0x3) >> 4)
> > 
> > is not correct as it will always evaluate to 0. Should the mask be 0x30
> > instead?
> > 
> > Thanks.
> 
> Hi Dmitry,
> 
> Good catch!
> 
> Yes, of course  - the mask should be 0x30.
> Shall I send a patch?

That would be great.

-- 
Dmitry
