From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom: Fix "can not retrieve extra class
 descriptor" for 24HDT
Date: Sun, 7 Apr 2013 21:08:55 -0700
Message-ID: <20130408040855.GC6479@core.coreip.homeip.net>
References: <1365029572-1527-1-git-send-email-killertofu@gmail.com>
 <CAF8JNhLC3uz5SUFYP8AZVTic8PDhxv+03_ANNvJUpmocxQp2qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:56999 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab3DHEI6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Apr 2013 00:08:58 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa11so3044339pad.13
        for <linux-input@vger.kernel.org>; Sun, 07 Apr 2013 21:08:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNhLC3uz5SUFYP8AZVTic8PDhxv+03_ANNvJUpmocxQp2qg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Fri, Apr 05, 2013 at 03:55:13PM -0700, Ping Cheng wrote:
> On Wed, Apr 3, 2013 at 3:52 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> 
> > The MFT device in the Cintiq 24HDT has two interfaces sharing the
> > same configuration. Without this patch, the driver attempts to
> > make use of both interfaces, even though the second interface is
> > not compatible with this driver.
> >
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> >
> 
> Tested-by: Ping Cheng <pingc@wacom.com>

Applied, thank you Jason and Ping.

-- 
Dmitry
