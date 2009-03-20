From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Question about usage of RCU in the input layer
Date: Fri, 20 Mar 2009 06:50:58 -0700
Message-ID: <20090320065058.65d01771@infradead.org>
References: <20090318215812.15496a86@infradead.org>
	<20090319085628.GA6167@in.ibm.com>
	<20090319071841.63334eff@infradead.org>
	<20090320020750.GA6807@linux.vnet.ibm.com>
	<20090319202032.4c971d92@infradead.org>
	<20090320044541.GE6807@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51051 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZCTNuD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2009 09:50:03 -0400
In-Reply-To: <20090320044541.GE6807@linux.vnet.ibm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Thu, 19 Mar 2009 21:45:41 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > single CPU is soooo last decade ;-)
> > But seriously I no longer have systems that aren't dual core or SMT
> > in some form... 
> 
> OK, I will ask the stupid question...
> 
> Why not delay bringing up the non-boot CPUs until later in boot?

that'd be throwing out the baby with the bathwater... I'm trying to use 
the other cpus to do some of the boot work (so that the total goes
faster); not using the other cpus would be counter productive to that.
(As is just sitting in synchronize_rcu() when the other cpu is
working.. hence this discussion ;-)

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
