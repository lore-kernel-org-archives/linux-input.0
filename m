From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Sat, 12 Dec 2009 04:00:50 +0200
Message-ID: <4B22F952.6070001@iki.fi>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com>	 <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de>	 <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com>	 <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de>	 <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com>	 <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de>	 <4B21308F.5070304@canonical.com> <1260541128.3656.6.camel@bede>	 <4B225601.3080002@canonical.com> <1260572529.3656.12.camel@bede>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:51766 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbZLLCAq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 21:00:46 -0500
In-Reply-To: <1260572529.3656.12.camel@bede>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tim Cole <tim.cole@canonical.com>
Cc: Stefan Bader <stefan.bader@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tim Cole wrote:
> On Fri, 2009-12-11 at 15:24 +0100, Stefan Bader wrote:
>> The problem moved though. For the older kernels it was the tablets that
>> were incorrectly detected as joysticks. But that patch of you went upstream
>> and now it is the one joystick model that does not work.
>> In our tree we reverted the patch in Jaunty, but with Karmic we have the other
>> behavior. So in essence, someone is always complaining. :-P
> 
> I know what you mean, but well -- ideally we want to converge on the
> correct behavior.  Otherwise we'll just keep spinning and things stay
> broken.
> 
> To my view, blacklisting a joystick which (wrongly) reports itself as a
> digitizer tablet is an improvement over creating broken joystick devices
> for anything that reports itself as a tablet.  From that position we can
> fix the problem with the single device reporting the wrong device type
> and then everyone can be happy.

As far as I understood, we do not yet know why the joystick gets
assigned digitizer keys, as the HID debug information requested has not
been provided. We do not know for sure what the joystick itself reports
or whether it is wrong or not.

-- 
Anssi Hannula
