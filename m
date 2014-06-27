From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] HID: roccat: Drop cast
Date: Thu, 26 Jun 2014 22:52:46 -0700
Message-ID: <1403848366.7977.92.camel@joe-AO725>
References: <20140626172852.GA2878@himangi-Dell>
	 <1403804286.7977.58.camel@joe-AO725>
	 <alpine.DEB.2.02.1406270729110.2016@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:49602 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750734AbaF0Fwu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2014 01:52:50 -0400
In-Reply-To: <alpine.DEB.2.02.1406270729110.2016@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Himangi Saraogi <himangi774@gmail.com>, Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2014-06-27 at 07:29 +0200, Julia Lawall wrote:
> On Thu, 26 Jun 2014, Joe Perches wrote:
> > The cast of a const void * to a void * was odd.
> > 
> > Maybe a mechanism to verify appropriateness of
> > loss of constness for any pointer might be useful.
> 
> I tried the following, but didn't find anything interesting:
> 
> @disable drop_cast@
> type T;
> const T e;
> @@
> 
> * (T)e

What code does this match?
Do you have an example match?

This doesn't find a cast of a void type like:

void func(const void * const p)
{
	char *p2 = p;

	p2[0] = 1;
}


