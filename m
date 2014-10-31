From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i8042: Add noloop quirk for Asus X750LN
Date: Fri, 31 Oct 2014 09:46:21 -0700
Message-ID: <20141031164621.GA32331@dtor-ws>
References: <1413032946-19748-1-git-send-email-hdegoede@redhat.com>
 <20141011183523.GA20881@dtor-ws>
 <20141030183410.GG36444@dtor-ws>
 <545346A1.3070708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:56633 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaJaQq0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 12:46:26 -0400
Received: by mail-ie0-f180.google.com with SMTP id y20so1680547ier.11
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 09:46:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <545346A1.3070708@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Fri, Oct 31, 2014 at 09:21:53AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 10/30/2014 07:34 PM, Dmitry Torokhov wrote:
> > On Sat, Oct 11, 2014 at 11:35:23AM -0700, Dmitry Torokhov wrote:
> >> On Sat, Oct 11, 2014 at 03:09:06PM +0200, Hans de Goede wrote:
> >>> Without this the aux port does not get detected, and consequently the touchpad
> >>> will not work.
> >>>
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=1110011
> >>>
> >>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >> Applied, thank you.
> > 
> > Hans,
> > 
> > Do you still have dmidecode for this laptop around?
> 
> No I took the necessary identification strings from the dmesg, which is here:
> 
> https://bugzilla.redhat.com/attachment.cgi?id=944389
> 
> I'll drop you a private mail with the users email address, then you
> can get into contact with him directly, I expect him to be willing to
> help debug this further.

Thanks!

> 
> > Can I see it? I am
> > just wondering what part of AUX_LOOP was causing issues. Was it aux
> > delivery test or loop test itself?
> 
> I was wondering myself, which is why the above dmesg is with:
> 
> "dyndbg=file drivers/input/serio/* +p"
> 
> But that does not seem to print anything extra ..., is the i8042 code
> properly using one of the foo_dbg macro's ?
>

The debug facilities in i8042 were done way before dynamic debug so if
you want to see the data stream you need i8042.debug. That works on all
kernels regardless of config.
 
Thanks.

-- 
Dmitry
