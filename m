From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Fri, 20 Mar 2009 22:46:15 -0700
Message-ID: <200903202246.15772.dmitry.torokhov@gmail.com>
References: <20090318215812.15496a86@infradead.org> <20090320020750.GA6807@linux.vnet.ibm.com> <20090319202032.4c971d92@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f208.google.com ([209.85.217.208]:53572 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbZCUFqX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2009 01:46:23 -0400
In-Reply-To: <20090319202032.4c971d92@infradead.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: paulmck@linux.vnet.ibm.com, dipankar@in.ibm.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 19 March 2009 20:20:32 Arjan van de Ven wrote:
> > I don't claim to understand the code in question, so it is entirely
> > possible that the following is irrelevant.  But one other reason for
> > synchronize_rcu() is:
> >
> > 1.    Make change.
> >
> > 2.    synchronize_rcu()
> >
> > 3.    Now you are guaranteed that all CPUs/tasks/whatever
> > currently running either are not messing with you on the one hand, or
> >       have seen the change on the other.
>
> ok so this is for the case where someone is already iterating the list.
>
> I don't see anything in the code that assumes this..

This is something that input core guarantees to its users: by the time
input core calls hander->start() or, in its absence, by the time
input_register_handle() returns, events from input drivers will be
passed into the handle being registered, i.e. the presence of the
new item in the list is noticed by all CPUs.

Now, it is possible to stop using RCU primitives in the input core
but I think that you'd want to figure out why synchronize_rcu()
takes so long first, otheriwse you may find another "abuser"
down the road.

-- 
Dmitry

