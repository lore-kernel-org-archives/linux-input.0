From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Question about usage of RCU in the input layer
Date: Thu, 19 Mar 2009 07:18:41 -0700
Message-ID: <20090319071841.63334eff@infradead.org>
References: <20090318215812.15496a86@infradead.org>
	<20090319085628.GA6167@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757051AbZCSOR4@vger.kernel.org>
In-Reply-To: <20090319085628.GA6167@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dipankar@in.ibm.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 19 Mar 2009 14:26:28 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> On Wed, Mar 18, 2009 at 09:58:12PM -0700, Arjan van de Ven wrote:
> > Hi,
> > 
> > the input layer does a "synchronize_rcu()" after a
> > list_add_tail_rcu(), which is costing me 1 second of boot time.....
> > And based on my understanding of the RCU concept, you only need to
> > synchronize on delete, not on addition... so I think the
> > synchronize is entirely redundant here...
> > 
> 
> The more appropriate question is - why is synchronize_rcu() taking
> 1 second ? Any idea what the other CPUs are doing at the time
> of calling synchronize_rcu() ?

one cpu is doing a lot of i2c traffic which is a bunch of udelay()s
in loops.. then it does quite a bit of uncached memory access, and
the lot takes quite while.

> What driver is this ? How early
> in the boot is this happening ? 

during kernel boot.

I suppose my question is also more generic.. why synchronize when it's
not needed? At least based on my understanding of RCU (but you're the
expert), you don't need to synchronize for an add, only between a
delete and a (k)free.....



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
