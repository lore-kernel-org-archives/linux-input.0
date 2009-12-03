From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/1] Input: gpio-keys: support for disabling GPIOs
Date: Wed, 2 Dec 2009 22:26:41 -0800
Message-ID: <20091203062641.GH9121@core.coreip.homeip.net>
References: <cover.1259674171.git.ext-mika.1.westerberg@nokia.com> <20091203061912.GA5626@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58826 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZLCG0j (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 01:26:39 -0500
Received: by pwi3 with SMTP id 3so832052pwi.21
        for <linux-input@vger.kernel.org>; Wed, 02 Dec 2009 22:26:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091203061912.GA5626@gw.healthdatacare.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: linux-input@vger.kernel.org

On Thu, Dec 03, 2009 at 08:19:12AM +0200, Mika Westerberg wrote:
> On Tue, Dec 01, 2009 at 03:53:45PM +0200, Mika Westerberg wrote:
> >
> > This is third version of the series. Purpose of this patch is to allow
> > userland to disable GPIO buttons interrupting the CPU. There is now sysfs
> > interface that can be used to control the buttons by key code or by switch
> > code.
> > 
> > I merged those previous 2 patches as one. This is because it made little
> > sense of having separate patch for adding the 'can_disable' field.
> > 
> > Changes in v3:
> > 	- merged previous 2 patches into one
> > 	- buttons have 'can_disable' field instead of irqflags field
> > 
> > Tested with RX-51.
> 
> Hi Dmitry,
> 
> Any comments on this? Is it OK to be applied or do I need to change
> something.
> 

Hi Mika,

SOrry, I am still pondering how to go about it. I am sure that the sysfs
interface is proper, so at this point it is just implementation details
that I am not quite sure yet...

-- 
Dmitry
