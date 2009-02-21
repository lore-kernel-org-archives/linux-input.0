From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: keyboard: introduce lm8323 driver
Date: Sat, 21 Feb 2009 13:20:00 +0530
Message-ID: <5d5443650902202350p206e58ebvcd9becfd04a4133@mail.gmail.com>
References: <1235046677-29959-1-git-send-email-me@felipebalbi.com>
	 <20090220141505.d1d53e4b.akpm@linux-foundation.org>
	 <20090220222911.GV32564@gandalf> <20090220225247.GY32564@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:50393 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbZBUHuC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Feb 2009 02:50:02 -0500
In-Reply-To: <20090220225247.GY32564@gandalf>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: me@felipebalbi.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, felipe.balbi@nokia.com

Hi Felipe,

On Sat, Feb 21, 2009 at 4:22 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sat, Feb 21, 2009 at 12:29:12AM +0200, Felipe Balbi wrote:
>> On Fri, Feb 20, 2009 at 02:15:05PM -0800, Andrew Morton wrote:
>> > On Thu, 19 Feb 2009 14:31:17 +0200
>> > Felipe Balbi <me@felipebalbi.com> wrote:
>> >
>> > > +struct lm8323_platform_data {
>> > > + int debounce_time; /* Time to watch for key bouncing, in ms. */
>> > > + int active_time; /* Idle time until sleep, in ms. */
>> > > +
>> > > + int size_x;
>> > > + int size_y;
>> > > + int repeat : 1;
>> >
>> > lm8323_platform_data.repeat appears to be never-written-to?
>>
>> Nobody is using that yet, still it's used in the driver:
>>       if (pdata->repeat)
>>               __set_bit(EV_REP, idev->evbit);
>>

Thanks for addressing my review comments to this patch and of course Andrew's.

Happy to add

Reviewed-by: Trilok Soni <soni.trilok@gmail.com>

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
