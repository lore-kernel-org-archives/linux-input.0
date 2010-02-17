From: <pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add =?UTF-8?Q?KEY=5FRFKILL?=
Date: Wed, 17 Feb 2010 16:12:08 -0500
Message-ID: <f1e18b6637067d769e473052a945c37b@127.0.0.1>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com>
 <20100217052247.GD7160@core.coreip.homeip.net>
 <20100217180342.GA22522@srcf.ucam.org>
 <22ee4e771002171043u2aaf97vd73c1090c2fce901@mail.gmail.com>
 <20100217191708.GA15554@core.coreip.homeip.net>
 <22ee4e771002171142q1496842ap4079026a5c0be8c6@mail.gmail.com>
 <20100217195435.GA15742@core.coreip.homeip.net>
 <22ee4e771002171218t69cc4348ia0300a645ce9763d@mail.gmail.com>
 <069C4DAE-598D-45F1-99B5-DA5BAF718179@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <069C4DAE-598D-45F1-99B5-DA5BAF718179-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Christian Lamparter <chunkeey-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 17 Feb 2010 12:52:06 -0800, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Feb 17, 2010, at 12:18 PM, Christian Lamparter
<chunkeey-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org 
>  > wrote:
> 
>> On Wed, Feb 17, 2010 at 8:54 PM, Dmitry Torokhov
>> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> Is there anything currently in works that would make use of this  
>>> button?
>>> I do not want to allocate keycode "for the future" which may never  
>>> come.
>>> We did it with KEY_BATTERY but I do not think anyone actually uses  
>>> it.
>>
>> Of course, there are lots of routers:
>>
>> Linksys: wrt160nl
>> Netgear: wnr2000, wndr3700
>> TP-Link: wr1043n, ... wr741nd
>> TrendNET: TEW-632BRP
>> Planex: MZK-W300NH,  MZK-W04NU
>> ...
>>
>> And a few new client adapters, I know about:
>> TP-Link: WN821 v2, WN721N, WN727N
>> Netgear: WNDA3100 v2
>> ...
>>
>> (Not to mention all the coming products).
> 
> Sorry, I was not clear enough. I meant something in works in Linux  
> software stack, I was aware that certain router have these buttons  
> already.

I know that the hostapd config file has an entire WPS section, but
have no experience using WPS, so can't speak as to how to configure
or use it.  I don't know if it's planned to include support for a
push button trigger.

from hostapd.conf in git:

# Config Methods
# List of the supported configuration methods
# Available methods: usba ethernet label display ext_nfc_token
int_nfc_token
#       nfc_interface push_button keypad
#config_methods=label display push_button keypad

Pat Erley
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
