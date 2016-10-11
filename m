From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] input/alps: Add touchstick support for SS5 hardware
Date: Tue, 11 Oct 2016 10:20:45 -0700
Message-ID: <20161011172045.GA26305@dtor-glaptop>
References: <20161003121630.5285-1-ben@smart-cactus.org>
 <20161004184710.GA5083@dtor-ws>
 <alpine.LNX.2.00.1610111545550.31629@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34760 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbcJKRUs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Oct 2016 13:20:48 -0400
Received: by mail-pa0-f68.google.com with SMTP id fn2so1072424pad.1
        for <linux-input@vger.kernel.org>; Tue, 11 Oct 2016 10:20:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1610111545550.31629@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.cz>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

On Tue, Oct 11, 2016 at 03:46:42PM +0200, Jiri Kosina wrote:
> On Tue, 4 Oct 2016, Dmitry Torokhov wrote:
> 
> > > Add touchstick support for the so-called SS5 hardware, which uses a
> > > variant of the SS4 protocol.
> > > 
> > > Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
> > > Tested-by: Michal Hocko <mhocko@suse.com>
> > > Signed-off-by: Ben Gamari <ben@smart-cactus.org>
> > > ---
> > 
> > Applied the lot, thanks.
> 
> Thanks. I see this wasn't in the d4e65476b merge; what are your plans with 
> this, please? Still for this merge window?

Yeah, I'll include in my 2nd pull later this week.

Thanks.

-- 
Dmitry
