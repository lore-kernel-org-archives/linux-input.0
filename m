From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v3 0/1] Input: gpio-keys: support for disabling GPIOs
Date: Thu, 3 Dec 2009 08:19:12 +0200
Message-ID: <20091203061912.GA5626@gw.healthdatacare.com>
References: <cover.1259674171.git.ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54737 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZLCGTK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 01:19:10 -0500
Received: by bwz27 with SMTP id 27so829056bwz.21
        for <linux-input@vger.kernel.org>; Wed, 02 Dec 2009 22:19:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1259674171.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

On Tue, Dec 01, 2009 at 03:53:45PM +0200, Mika Westerberg wrote:
>
> This is third version of the series. Purpose of this patch is to allow
> userland to disable GPIO buttons interrupting the CPU. There is now sysfs
> interface that can be used to control the buttons by key code or by switch
> code.
> 
> I merged those previous 2 patches as one. This is because it made little
> sense of having separate patch for adding the 'can_disable' field.
> 
> Changes in v3:
> 	- merged previous 2 patches into one
> 	- buttons have 'can_disable' field instead of irqflags field
> 
> Tested with RX-51.

Hi Dmitry,

Any comments on this? Is it OK to be applied or do I need to change
something.

Thanks again,
MW
