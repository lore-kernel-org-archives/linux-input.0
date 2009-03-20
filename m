From: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Fri, 20 Mar 2009 11:31:28 +0530
Message-ID: <20090320060128.GC6167@in.ibm.com>
References: <20090318215812.15496a86@infradead.org> <20090319085628.GA6167@in.ibm.com> <20090319071841.63334eff@infradead.org> <20090320020750.GA6807@linux.vnet.ibm.com> <20090319202032.4c971d92@infradead.org> <20090320044541.GE6807@linux.vnet.ibm.com> <49C3296B.1020209@cosmosbay.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43340 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbZCTGBi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2009 02:01:38 -0400
Content-Disposition: inline
In-Reply-To: <49C3296B.1020209@cosmosbay.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: paulmck@linux.vnet.ibm.com, Arjan van de Ven <arjan@infradead.org>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Fri, Mar 20, 2009 at 06:28:11AM +0100, Eric Dumazet wrote:
> Paul E. McKenney a =E9crit :
> Hmm... point is to make linux boot as fast as possible, so ...
>=20
> Use a special variant of udelay() in offending drivers that make appr=
opriate
> RCU call to increment quiescent state ?

It may not be safe to do this it is in a RCU read-side critical section=
=2E

Thanks
Dipankar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
