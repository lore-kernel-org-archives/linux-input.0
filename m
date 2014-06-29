From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] HID: roccat: Drop cast
Date: Sun, 29 Jun 2014 11:25:49 -0700
Message-ID: <1404066349.9064.60.camel@joe-AO725>
References: <20140626172852.GA2878@himangi-Dell>
	 <1403804286.7977.58.camel@joe-AO725>
	 <alpine.DEB.2.02.1406270729110.2016@localhost6.localdomain6>
	 <1403848366.7977.92.camel@joe-AO725>
	 <alpine.DEB.2.02.1406291832430.2036@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:37994 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753311AbaF2SZx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jun 2014 14:25:53 -0400
In-Reply-To: <alpine.DEB.2.02.1406291832430.2036@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Himangi Saraogi <himangi774@gmail.com>, Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2014-06-29 at 18:34 +0200, Julia Lawall wrote:
> On Thu, 26 Jun 2014, Joe Perches wrote:
> > void func(const void * const p)
> > {
> > 	char *p2 = p;
> > 
> > 	p2[0] = 1;
> > }
> 
> Is this a real example?

No, it's not.

I think I've seen code in the kernel like
	char *p2 = (void *)p;
where p is const and p2 is dereferenced and set.


