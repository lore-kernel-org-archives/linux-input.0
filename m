From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Thu, 10 Dec 2009 18:31:59 +0100
Message-ID: <4B21308F.5070304@canonical.com>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com>  <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de>  <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com>  <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de> <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com> <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:47924 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761290AbZLJRb4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 12:31:56 -0500
In-Reply-To: <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tim Cole <tim.cole@canonical.com>

Jiri Kosina wrote:
> On Wed, 9 Sep 2009, Sergey Kolesnikov wrote:
> 
>> Yes, reverting this commit helps. I've tried jstest and succeeded to 
>> change the state of each available button/axis.
> 
> Thanks for verifying.
> 
>> May be there is another way to distinguish between such joysticks and 
>> digitizers?  
> 
> Well, first I'll need the report descriptor dump (i.e. the HID debugging 
> output, see one of the previous mails), to see how the device is 
> presenting itself to the system. And then possibly fix the input mapping 
> in HID code, so that we don't infringe on mappings of different device 
> classes.
> 

I know this is quite a long time ago now, but has there be any outcome
on how to handle those joysticks?

-Stefan
