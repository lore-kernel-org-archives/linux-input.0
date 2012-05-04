From: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Fri, 04 May 2012 05:14:53 -0300
Message-ID: <4FA38FFD.6080805@osvaldobarrera.com.ar>
References: <20120503052000.GC15205@burratino> <20120503052420.GD15205@burratino> <4FA217B7.7070908@osvaldobarrera.com.ar> <20120503055051.GA15960@burratino> <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com> <20120503130821.GB16978@burratino> <20120503131356.GC16978@burratino> <20120504024054.GA19355@hugoo.com.ar> <20120504074137.GB6451@burratino> <20120504081031.GA30509@hugoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from customer-static-210-108-249.iplannetworks.net ([190.210.108.249]:60056
	"EHLO hyperion.ubertech.com.ar" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752474Ab2EDIO6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 4 May 2012 04:14:58 -0400
In-Reply-To: <20120504081031.GA30509@hugoo.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

On 2012-05-04 05:10, Hugo Osvaldo Barrera wrote:
> On 2012.05.04 02:41, Jonathan Nieder wrote:
>> Hugo Osvaldo Barrera wrote:
>>
>>> Here goes, I'm pretty sure a few of the first lines aren't relevant, but I
>>> prefer to send a couple too many instead of a couple to few :)
>>
>> Thanks!  That was fast.  I'd also be interested in the corresponding
>> output from an Intel architecture machine with the same kernel version
>> for comparison.
>>
>> I'm hoping some obvious difference will jump out --- otherwise I or
>> some other reader will have to look at the actual code. ;-)
>>
>> Hope that helps,
>> Jonathan
> 
> Here you go - *I* certainly can't make anything out of it, but hope it helps :)
> 
> $ uname -a
> Linux hyperion 3.3.2-1-ARCH #1 SMP PREEMPT Sat Apr 14 09:48:37 CEST 2012 x86_64 AMD Phenom(tm) II X4 945 Processor AuthenticAMD GNU/Linux
> 
> dmesg:
> 

<snip>

Oh, it slipped my mind and I used the other (identical) mouse for this,
does that matter?  They're the exact same model.

-- 
Hugo Osvaldo Barrera
