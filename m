From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Question about usage of RCU in the input layer
Date: Thu, 19 Mar 2009 07:02:21 -0700
Message-ID: <20090319070221.6aca7245@infradead.org>
References: <20090318215812.15496a86@infradead.org>
	<200903190023.56929.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52618 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379AbZCSOB1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2009 10:01:27 -0400
In-Reply-To: <200903190023.56929.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dipankar@in.ibm.com, linux-kernel@vger.kernel.org

On Thu, 19 Mar 2009 00:23:56 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Arjan,
> 
> On Wednesday 18 March 2009 21:58:12 Arjan van de Ven wrote:
> > Hi,
> >
> > the input layer does a "synchronize_rcu()" after a
> > list_add_tail_rcu(), which is costing me 1 second of boot time.....
> > And based on my understanding of the RCU concept, you only need to
> > synchronize on delete, not on addition... so I think the
> > synchronize is entirely redundant here...
> 
> 
> It is there to guarantee that once we registered the handle all
> subsequent input events will be delivered through it.


afaik rcu already guarantees that even without a synchronize;
the only reason you would need a synchronize is to guarantee that
people STOPPED using your memory. Or am I now totally misunderstanding
RCU ?
