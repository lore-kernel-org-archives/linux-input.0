From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx data
Date: Thu, 16 Jul 2009 12:00:00 +0200
Message-ID: <200907161200.01020.marek.vasut@gmail.com>
References: <200907151106.47917.david-b@pacbell.net> <20090716071529.GA28840@n2100.arm.linux.org.uk> <200907160028.05114.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42397 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbZGPKAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2009 06:00:19 -0400
Received: by fxm9 with SMTP id 9so4427fxm.1
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2009 03:00:17 -0700 (PDT)
In-Reply-To: <200907160028.05114.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Alessandro Rubini <rubini-list@gnudd.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Dne =C4=8Ct 16. =C4=8Dervence 2009 09:28:04 David Brownell napsal(a):
> On Thursday 16 July 2009, Russell King - ARM Linux wrote:
> > Clearly David has no knowledge of DMA cache line handing and has no=
t
> > read the DMA API document.  I really suggest that you ignore him un=
til
> > he gets a fucking clue.
>
> Clearly common courtesy is too much for Russell.  I suggest you
> ignore him until he learns to restrain his baser impulses ...
> his personal attacks have no place in technical discussions.

It's very interesting. I experienced no problems when it came to commun=
icating=20
with him (which I cant say about you though).
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
