From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i8042: Add noloop quirk for Asus X750LN
Date: Thu, 30 Oct 2014 11:34:10 -0700
Message-ID: <20141030183410.GG36444@dtor-ws>
References: <1413032946-19748-1-git-send-email-hdegoede@redhat.com>
 <20141011183523.GA20881@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35750 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760725AbaJ3SeO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2014 14:34:14 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so5668436pdj.28
        for <linux-input@vger.kernel.org>; Thu, 30 Oct 2014 11:34:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141011183523.GA20881@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Sat, Oct 11, 2014 at 11:35:23AM -0700, Dmitry Torokhov wrote:
> On Sat, Oct 11, 2014 at 03:09:06PM +0200, Hans de Goede wrote:
> > Without this the aux port does not get detected, and consequently the touchpad
> > will not work.
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1110011
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Applied, thank you.

Hans,

Do you still have dmidecode for this laptop around? Can I see it? I am
just wondering what part of AUX_LOOP was causing issues. Was it aux
delivery test or loop test itself?

Thanks.

-- 
Dmitry
