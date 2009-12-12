From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Fri, 11 Dec 2009 20:44:25 -0800
Message-ID: <20091212044425.GA2956@core.coreip.homeip.net>
References: <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de> <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com> <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de> <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com> <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de> <4B21308F.5070304@canonical.com> <1260541128.3656.6.camel@bede> <4B225601.3080002@canonical.com> <1260572529.3656.12.camel@bede> <4B22F952.6070001@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:54776 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761193AbZLLEoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 23:44:24 -0500
Received: by pzk26 with SMTP id 26so1047220pzk.4
        for <linux-input@vger.kernel.org>; Fri, 11 Dec 2009 20:44:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B22F952.6070001@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Tim Cole <tim.cole@canonical.com>, Stefan Bader <stefan.bader@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Sat, Dec 12, 2009 at 04:00:50AM +0200, Anssi Hannula wrote:
> Tim Cole wrote:
> > On Fri, 2009-12-11 at 15:24 +0100, Stefan Bader wrote:
> >> The problem moved though. For the older kernels it was the tablets that
> >> were incorrectly detected as joysticks. But that patch of you went upstream
> >> and now it is the one joystick model that does not work.
> >> In our tree we reverted the patch in Jaunty, but with Karmic we have the other
> >> behavior. So in essence, someone is always complaining. :-P
> > 
> > I know what you mean, but well -- ideally we want to converge on the
> > correct behavior.  Otherwise we'll just keep spinning and things stay
> > broken.
> > 
> > To my view, blacklisting a joystick which (wrongly) reports itself as a
> > digitizer tablet is an improvement over creating broken joystick devices
> > for anything that reports itself as a tablet.  From that position we can
> > fix the problem with the single device reporting the wrong device type
> > and then everyone can be happy.
> 
> As far as I understood, we do not yet know why the joystick gets
> assigned digitizer keys, as the HID debug information requested has not
> been provided. We do not know for sure what the joystick itself reports
> or whether it is wrong or not.
> 

Well, the thing is reported ot have 39 buttons... HID simply starts at
BTN_TRIGGER and goes form there.

39 buttons.. sheesh.. maybe we need to reclassify it as a keyboard and
be done with it ;)

-- 
Dmitry
