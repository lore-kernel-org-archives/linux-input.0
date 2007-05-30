From: Jan Kratochvil <honza@jikos.cz>
Subject: Re: [PATCH] new driver for wireless xbox receiver for review
Date: Wed, 30 May 2007 16:24:45 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0705301614040.22353@twin.jikos.cz>
References: <20070529043957.GB6157@rcn.com>
 <d120d5000705290859k63f9110akba428332a5557a21@mail.gmail.com>
 <20070530002846.GA8595@rcn.com>  <d120d5000705300540v32b2f32eub8e74b88fea6a593@mail.gmail.com>
 <bafd4ab0705300647w3d54aaa6meee94c98005650d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <bafd4ab0705300647w3d54aaa6meee94c98005650d7@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Brian Magnuson <bdmagnuson@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hello,

>> > Knew that was coming :).  Should be able to manage it.  Since the
>> wireless
>> > model returns a expanded data format it needs to be handled specially.
>> > Another flag in the xpad_device struct?
>> 
>> We have xtype field, I think it should be used.
>
>
> I don't see this field in xpad_device in your tree or Linus'.

It is not yet in Linus' tree, but it definitely is in Dmitry input tree. 
http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=bad058541d848500b5f2cc049c1082d0b2935b7d

I noticed in your patch that you worked on some old version of xpad. You'll 
see that in dmitry tree there is support for rumble as well as other minor 
changes. (And I submited support for controlling leds yesterday)
Btw you are stating that it process packet is based on information from 
http://euc.jp/periphs/xbox-controller.en.html, which I doubt, because this page 
is actually about xbox (1) controller. Not xbox 360. But on the other hand you 
are interpreting the report correctly. :)

>
> In any case I'll take these changes and your earlier ones, merge it into
> xpad.c and
> resubmit.

Good luck,
Jan

>
> Thanks,
> Brian
>
