From: Hendrik Sattler <post@hendrik-sattler.de>
Subject: Re: [patch 01/23] fjkeyinf driver for FSC Lifebook laptops
Date: Mon, 10 Mar 2008 14:53:39 +0100
Message-ID: <20080310145339.mid5ib7bk8k0g80s@v1539.ncsrv.de>
References: <200803101008.m2AA8d1N011222@imap1.linux-foundation.org>
	<Pine.LNX.4.64.0803101334150.15209@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v1539.ncsrv.de ([89.110.150.23]:36729 "EHLO v1539.ncsrv.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbYCJOY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2008 10:24:59 -0400
In-Reply-To: <Pine.LNX.4.64.0803101334150.15209@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Stephen Hemminger <shemminger@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org

Zitat von Jiri Kosina <jkosina@suse.cz>:
> On Mon, 10 Mar 2008, akpm@linux-foundation.org wrote:
>> From: Hendrik Sattler <post@hendrik-sattler.de>
>> This is another approach for FJKEYINF support for the FSC Lifebook laptop
>> series.  In comparison to the apanel driver that was posted lately, it
>> supports more than one entry in the table and slits off the actual   
>> handling of
>> the I2C devices to seperate drivers, allowing resuse in other scenarios.
>
> s/resuse/reuse, right?

Right.

> Also, is there any effort to merge this with Stephen's apanel driver? Or
> what is the advantage of having these two drivers separately?

Cleaner.
The original author of apanel did (in anothere approach for BSD)  
actually the same. He was also my source for OZ990 documentation. The  
apanel driver does mix several devices into one driver.
Even though it doesn't work for my laptop, I see to gain in hacking  
more into it if it can be done in a better way. The current I2C  
framework makes a separation easy enough.
Additionally, the OZ99x driver checks that there actually is such a  
chip at that I2C address.

Note that those are normal I2C chips used, thus generic drivers for  
them can be reused somewhere else. Again, this is not possible with  
the apanel driver.

This is not a full replacement for apanel, though, as it addresses not  
the same hardware (different laptops). I asked Stephen to show me his  
fjkeyinf data but he did not respond to my mail.

HS


