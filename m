From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Bug#622231: xserver-xorg-input-synaptics: synaptics driver not
 always used
Date: Mon, 21 Jan 2013 16:00:31 -0800
Message-ID: <20130122000031.GC16638@core.coreip.homeip.net>
References: <20120628014208.GA3372@burratino>
 <20120628075544.GA11210@xvii.vinc17.org>
 <20120820004328.GD15370@xvii.vinc17.org>
 <20120820005448.GA614@mannheim-rule.local>
 <20130108195618.GA1634@ypig.lip.ens-lyon.fr>
 <20130110070116.GA5121@elie.Belkin>
 <20130110210515.GA17973@xvii.vinc17.org>
 <20130111003101.GF30784@google.com>
 <20130111084850.GA12470@ioooi.vinc17.net>
 <1358631319.24121.62.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:57681 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab3AVAAe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2013 19:00:34 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so2915871dad.22
        for <linux-input@vger.kernel.org>; Mon, 21 Jan 2013 16:00:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358631319.24121.62.camel@deadeye.wl.decadent.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>, 622231@bugs.debian.org, Vincent Lefevre <vincent@vinc17.net>, linux-input@vger.kernel.org

Hi Ben,

On Sat, Jan 19, 2013 at 09:35:19PM +0000, Ben Hutchings wrote:
> Vincent Lefevre reported that on a Dell Latitude E6400 the ALPS
> DualPoint touchpad is sometimes detected as using generic PS/2 protocol
> and not the ALPS protocol.  This can happen either at boot time or after
> resume and with kernel versions ranging from at least 2.6.38 to 3.5.
> 
> He has now provided logs of the good and bad probes with i8042.debug=1,
> which are attached to <http://bugs.debian.org/622231#160>.
> 
> Is there any more information he could provide that would help to debug
> this?  Have you had any similar reports?

No, I did not recall specifically any such reports. I'll try to check
the logs and see if anything jumps out at me.

Thanks.

-- 
Dmitry
