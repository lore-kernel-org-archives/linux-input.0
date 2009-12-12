From: david@lang.hm
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR  system?
Date: Sat, 12 Dec 2009 14:52:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0912121445290.3370@asgard.lang.hm>
References: <20091204220708.GD25669@core.coreip.homeip.net> <BEJgSGGXqgB@lirc> <9e4733910912041628g5bedc9d2jbee3b0861aeb5511@mail.gmail.com> <1259977687.27969.18.camel@localhost> <9e4733910912041945g14732dcfgbb2ef6437ef62bb6@mail.gmail.com>
 <1260066624.3105.33.camel@palomino.walls.org> <m3aaxw6mjz.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932966AbZLMBRj@vger.kernel.org>
In-Reply-To: <m3aaxw6mjz.fsf@intrepid.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Andy Walls <awalls@radix.net>, Jon Smirl <jonsmirl@gmail.com>, Christoph Bartelmus <lirc@bartelmus.de>, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Sun, 6 Dec 2009, Krzysztof Halasa wrote:

> Andy Walls <awalls@radix.net> writes:
>
>> Yes, I agree.  I do not know what percentage of current Linux users are
>> technical vs non-technical, so I cannot gauge the current improtance.
>>
>> I can see the trend line though: as time goes by, the percentage of all
>> linux users that have a technical bent will only get smaller.
>
> This IMHO shouldn't matter. If users can configure their keymaps for
> e.g. games with a graphical utility (and  they easily can), they can do
> the same with their remotes, at least with these using common sane
> protocols. The only thing needed is a good GUI utility. Ergo - it's not
> a kernel issue.
>
> The "default bundled", or PnP, won't work well in comparison to a GUI
> utility, I wouldn't worry about it too much (though adding it to udev
> and co is trivial and we should do it - even if not PnP but asking first
> about the actual remote used).

how is this problem any different from figuring out the keymap of a 
keyboard?

there are many defined keymaps (including cases where keys are labled 
different things on the keyboard but send identical codes)

currently in linux distros the user can either select the keymap, or the 
installer will ask the user to press specific keys (or indicate that they 
don't exist) until the installer can guess the keymap to use.

why would this not work for IR remotes as well?

and just like linux has some default keymaps that it uses that mostly work 
for the common case, there could be default IR keymaps that map the common 
keys for all remotes to the appropriate keycodes. it will mean that by 
default you won't see a difference between a DVD, VCR, DVR, etc play 
button, but it will mean that someone picking up a random remote and 
pointing it at the linux box will probably get minimal functionality.

then with a utility to tweak the keymap (or load a more specific one) the 
user can do better.

this would also integrate very nicely with they 'multimedia keyboards' 
that have lots of buttons on them as well, unless you tell it otherwise, 
play is play is play no matter which play button is pressed.

David Lang
