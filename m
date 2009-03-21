From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Question about usage of RCU in the input layer
Date: Fri, 20 Mar 2009 21:58:25 -0700
Message-ID: <20090320215825.19b8baae@infradead.org>
References: <20090318215812.15496a86@infradead.org>
	<20090319085628.GA6167@in.ibm.com>
	<20090319071841.63334eff@infradead.org>
	<20090320020750.GA6807@linux.vnet.ibm.com>
	<20090319202032.4c971d92@infradead.org>
	<20090320044541.GE6807@linux.vnet.ibm.com>
	<20090320065058.65d01771@infradead.org>
	<20090320143104.GA6698@linux.vnet.ibm.com>
	<20090320111354.679ab53d@infradead.org>
	<20090321012746.GM6698@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42566 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZCUE51 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2009 00:57:27 -0400
In-Reply-To: <20090321012746.GM6698@linux.vnet.ibm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Fri, 20 Mar 2009 18:27:46 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > I've seen only this (input) one to take a long time
> 
> Ouch!!!  A -single- synchronize_rcu() taking a full second???  That
> indicates breakage.

I'll do a debug mode tomorrow and visualize it as part of the bootgraph;
hopefully it'll be an interesting result.
I'll share the graph when I have it....



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
