From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] HID: roccat: Drop cast
Date: Fri, 27 Jun 2014 07:29:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1406270729110.2016@localhost6.localdomain6>
References: <20140626172852.GA2878@himangi-Dell> <1403804286.7977.58.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:18906
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbaF0F3o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2014 01:29:44 -0400
In-Reply-To: <1403804286.7977.58.camel@joe-AO725>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Himangi Saraogi <himangi774@gmail.com>, Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On Thu, 26 Jun 2014, Joe Perches wrote:

> On Thu, 2014-06-26 at 22:58 +0530, Himangi Saraogi wrote:
> > This patch removes the cast on data of type void* as it is not needed.
> 
> Hi Himangi
> 
> The cast of a const void * to a void * was odd.
> 
> Maybe a mechanism to verify appropriateness of
> loss of constness for any pointer might be useful.

I tried the following, but didn't find anything interesting:

@disable drop_cast@
type T;
const T e;
@@

* (T)e

julia
