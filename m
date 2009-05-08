From: Jeremy Huddleston <jeremyhu@freedesktop.org>
Subject: Re: [PATCH] appletouch: Improved finger detection
Date: Thu, 07 May 2009 23:13:26 -0700
Message-ID: <4A03CD86.4010402@freedesktop.org>
References: <3AC3E247-D85C-4D8A-A73B-34677C32C2D5@freedesktop.org> <20090508025839.GC30616@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:53192 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbZEHGNj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2009 02:13:39 -0400
In-Reply-To: <20090508025839.GC30616@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> HI Jeremy,
> 
> On Tue, May 05, 2009 at 12:10:34PM -0700, Jeremy Huddleston wrote:
>> The appletouch driver is prone to reporting multiple fingers when only  
>> one is
>> pressing.  The appletouch driver queries an array of pressure sensors  
>> and
>> counts local maxima in pressure to determine the number of fingers.  It 
>> just
>> does this on the raw values, so a data stream like:
>>
>> 0 100 250 300 299 300 250 100 0
>>
>> actually registers as 2 fingers.
>>
>> This patch updates the logic to ignore small dips in pressure that are  
>> less
>> than the threshold.
>>
> 
> Does it still detect 2 fingers as 2 fingers when they are held together?
> 

Yes... and 3 when 3 are there.  Before, it would frequently report 3
instead of 2 or 2 instead of 1.  I have found the behavior with this
patch very reliable... the old behavior was not reliable for me (perhaps
due to a precision issue in hardware... or a dent in my finger).
