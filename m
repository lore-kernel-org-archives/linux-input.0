From: "Phil Endecott" <phil_dubhl_endecott@chezphil.org>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Tue, 14 Oct 2008 17:18:33 +0100
Message-ID: <1224001113932@dmwebmail.dmwebmail.chezphil.org>
References: <20081014111236.2495140c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:1468 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbYJNQSg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 12:18:36 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_dubhl_endecott@chezphil.org>)
	id 1KpmbT-0003oD-Ho
	for linux-input@vger.kernel.org; Tue, 14 Oct 2008 17:18:35 +0100
In-Reply-To: <20081014111236.2495140c@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-input <linux-input@vger.kernel.org>

Arjan van de Ven wrote:
> the real thing is to not wait on this while booting;
> my fastboot git tree has the patches to fix that part..

Hi Arjan,

Actually I got your fastboot tree yesterday and have been using your 
bootgraph.pl script to track down things like this "pcspkr takes 2 
seconds" problem.  But I haven't yet got the async initcalls to work.  
I'll admit that I haven't really looked into it yet, but I'm guessing 
that either I have messed up with git and I don't really have your 
fastboot tree at all, or there is some config option that I need to 
toggle somewhere.  Can you give me a clue?  (And in general, where 
would you prefer to discuss fastboot-related things?  I have posted 
another message related to pcie hotplug, which I need because I have 
wireless networking enabled and which currently adds 4 seconds to the 
boot, here: http://thread.gmane.org/gmane.linux.kernel.pci/1311)

Cheers,  Phil.



