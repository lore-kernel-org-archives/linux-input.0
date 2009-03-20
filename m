From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Fri, 20 Mar 2009 07:35:20 +0100
Message-ID: <49C33928.1050806@cosmosbay.com>
References: <20090318215812.15496a86@infradead.org> <20090319085628.GA6167@in.ibm.com> <20090319071841.63334eff@infradead.org> <20090320020750.GA6807@linux.vnet.ibm.com> <20090319202032.4c971d92@infradead.org> <20090320044541.GE6807@linux.vnet.ibm.com> <49C3296B.1020209@cosmosbay.com> <20090320060128.GC6167@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw1.cosmosbay.com ([212.99.114.194]:42296 "EHLO
	gw1.cosmosbay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbZCTGfu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2009 02:35:50 -0400
In-Reply-To: <20090320060128.GC6167@in.ibm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dipankar@in.ibm.com
Cc: paulmck@linux.vnet.ibm.com, Arjan van de Ven <arjan@infradead.org>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

Dipankar Sarma a =E9crit :
> On Fri, Mar 20, 2009 at 06:28:11AM +0100, Eric Dumazet wrote:
>> Paul E. McKenney a =E9crit :
>> Hmm... point is to make linux boot as fast as possible, so ...
>>
>> Use a special variant of udelay() in offending drivers that make app=
ropriate
>> RCU call to increment quiescent state ?
>=20
> It may not be safe to do this it is in a RCU read-side critical secti=
on.

Yes, this is why I suggested a variant of udelay, not udelay() itself,
used by selected drivers (probably not so many drivers hog cpu so long)

void udelay_rcu_quiescent(unsigned long usecs)
{
	preempt_disable();
	rcu_qsctr_inc(smp_processor_id());
	preempt_enable();

	udelay(usecs);
}


Or maybe we have a way to detect we are in a RCU-side critical section =
at runtime ?

void __udelay(unsigned long usecs)
{
	if (!in_rcu_critical_section()) {
		preempt_disable();
		rcu_qsctr_inc(smp_processor_id());
		preempt_enable();
	}
	...
}


Thank you

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
