From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: rfkill-input understanding help
Date: Sat, 12 Jan 2008 00:32:40 +0000
Message-ID: <200801120032.41263.carlos@strangeworlds.co.uk>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <200801112008.00927.IvDoorn@gmail.com> <d120d5000801111234k5c0faaeeya0c5487ede8f0c19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:52800 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757416AbYALAcp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2008 19:32:45 -0500
In-Reply-To: <d120d5000801111234k5c0faaeeya0c5487ede8f0c19@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-input@vger.kernel.org

On Friday 11 January 2008 20:34:09 Dmitry Torokhov wrote:
> On Jan 11, 2008 2:08 PM, Ivo van Doorn <ivdoorn@gmail.com> wrote:
> > Perhaps the rfkill-input needs to be registered before input
> > devices are being registered. But I am not sure, Dmitry propably
> > knows more about possible ordering requirements for input
> > device and input trigger registration.
>
> No, it is ok for rfkill-input handler to be installed later, but of
> course it will miss any events that happen before.

Unfortunately, moving the load order of rfkill-input doesn't solve my acer-wmi 
problems:

1) If I build rfkill-input in, it does nothing (since the load order code is 
obviously only for the module) - KEY_WLAN and KEY_BLUETOOTH are just ignored 
by it.

2) If I build rfkill-input as a module, it won't work when autoloaded. If I 
unload then reload it, it will:

i) If b43 is not loaded, it will just toggle both states. (the software only 
toggle also changes to start toggling both states after reloading 
rfkill-input).

ii) If b43 is loaded, after one or two KEY_WLAN or KEY_BLUETOOTH presses, I  
end up in a vicious cycle of rfkill non-stop changing the states of both the 
bluetooth and wireless rapidly, until I unload either b43 or acer-wmi and get 
the same result as (i) (I can also stop this nasty loop by commenting out the 
input_report_key lines in b43 - so this probably isn't a b43 specific issue, 
it's just an example of a problem).

Of course, if I completely ignore rfkill-input, I can happily toggle my 
wireless and bluetooth devices via their respective 'state' files to my 
hearts content, and they work fine. But after loading rfkill-input (as 
described above), even the 'state' file toggle causes the nasty 
toggle-all-devices-and-loop-endlessly.

So I suppose the real question is: what exactly is going on with rfkill-input 
on my laptop?

Is there anywhere in particular I can shove some printk's or some such to find 
out if, and where, rfkill-input may be going wrong (I'm assuming the failing 
to run properly on the first load is the real issue, and the rest of it is 
just a side effect of something having gone wrong)?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
