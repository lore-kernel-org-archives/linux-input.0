From: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Thu, 19 Mar 2009 14:26:28 +0530
Message-ID: <20090319085628.GA6167@in.ibm.com>
References: <20090318215812.15496a86@infradead.org>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42284 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390AbZCSI4g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2009 04:56:36 -0400
Content-Disposition: inline
In-Reply-To: <20090318215812.15496a86@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Wed, Mar 18, 2009 at 09:58:12PM -0700, Arjan van de Ven wrote:
> Hi,
> 
> the input layer does a "synchronize_rcu()" after a list_add_tail_rcu(), which
> is costing me 1 second of boot time.....
> And based on my understanding of the RCU concept, you only need to synchronize on delete,
> not on addition... so I think the synchronize is entirely redundant here...
> 

The more appropriate question is - why is synchronize_rcu() taking
1 second ? Any idea what the other CPUs are doing at the time
of calling synchronize_rcu() ? What driver is this ? How early
in the boot is this happening ? 

Thanks
Dipankar
