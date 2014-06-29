From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] HID: roccat: Drop cast
Date: Sun, 29 Jun 2014 18:34:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1406291832430.2036@localhost6.localdomain6>
References: <20140626172852.GA2878@himangi-Dell>  <1403804286.7977.58.camel@joe-AO725>  <alpine.DEB.2.02.1406270729110.2016@localhost6.localdomain6> <1403848366.7977.92.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38253 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbaF2QeS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jun 2014 12:34:18 -0400
In-Reply-To: <1403848366.7977.92.camel@joe-AO725>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Himangi Saraogi <himangi774@gmail.com>, Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On Thu, 26 Jun 2014, Joe Perches wrote:

> On Fri, 2014-06-27 at 07:29 +0200, Julia Lawall wrote:
> > On Thu, 26 Jun 2014, Joe Perches wrote:
> > > The cast of a const void * to a void * was odd.
> > > 
> > > Maybe a mechanism to verify appropriateness of
> > > loss of constness for any pointer might be useful.
> > 
> > I tried the following, but didn't find anything interesting:
> > 
> > @disable drop_cast@
> > type T;
> > const T e;
> > @@
> > 
> > * (T)e
> 
> What code does this match?
> Do you have an example match?
> 
> This doesn't find a cast of a void type like:
> 
> void func(const void * const p)
> {
> 	char *p2 = p;
> 
> 	p2[0] = 1;
> }

Is this a real example?  Because gcc complains about this sort of problem.  
I made a semantic patch that detects this, but since gcc does the same 
thing, it doesn't seem very interesting.  Coccinelle gives a few false 
positives due to lack of type information.

julia
