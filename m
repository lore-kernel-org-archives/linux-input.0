From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: A tablet driver question
Date: Thu, 21 May 2009 10:35:05 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905211033450.29030@twin.jikos.cz>
References: <7f83a3ba0905192149k338f3932u25e2d0f1b2d70e2f@mail.gmail.com>  <20090520051222.GA11638@kroah.com> <7f83a3ba0905192316u4753fbefi37257a7e3d20f3ef@mail.gmail.com>  <4A13AEEC.7010707@gmail.com> <7f83a3ba0905200858l7f78e5c7s675fea46b4ceb1c5@mail.gmail.com>
  <4A142EC4.70202@gmail.com> <45cc95260905200950n4d57b3emb21f09cd0c90a28f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbZEUIfH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2009 04:35:07 -0400
In-Reply-To: <45cc95260905200950n4d57b3emb21f09cd0c90a28f@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Steven Hunt <srhlefty@gmail.com>, Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org, linux-input@vger.kernel.org

On Wed, 20 May 2009, Mohamed Ikbel Boulabiar wrote:

> > You still can read the events through hidraw (or via
> > deprecated hiddev).
> Why hiddev is deprecated ?

Well, "deprecated" is maybe too strong expression. It's not flexible 
enough -- it is USB-only, it interprets the data "too much" (parses them 
according to the device report descriptor), which sometimes makes it 
harder to write specialized drivers which require no parsing at all, etc.

-- 
Jiri Kosina
SUSE Labs

