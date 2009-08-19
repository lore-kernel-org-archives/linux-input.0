From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] input: i8042 - add Acer Aspire 5536 to the noloop list
Date: Wed, 19 Aug 2009 10:56:32 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0908191055590.2744@twin.jikos.cz>
References: <1250471002-20780-1-git-send-email-eugen@debian.org> <20090818055542.CB3F6526EA5@mailhub.coreip.homeip.net> <20090818165326.GA3844@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39879 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbZHSI4c (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2009 04:56:32 -0400
In-Reply-To: <20090818165326.GA3844@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eugeniy Meshcheryakov <eugen@debian.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, 18 Aug 2009, Eugeniy Meshcheryakov wrote:

> I tried your patch and it does not fix the problem. I still need to add
> i8042.noloop=1 to the kernel command line to be able to reenable the
> touchpad. 

What chasis type do you see in the 'dmidecode' output on the affected 
system?

-- 
Jiri Kosina
SUSE Labs

