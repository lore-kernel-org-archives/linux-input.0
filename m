From: Ali Abdallah <aliov@xfce.org>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
 in driver
Date: Wed, 19 Aug 2009 11:18:30 +0200
Message-ID: <4A8BC366.9070108@xfce.org>
References: <1235992429.3858.58.camel@hughsie-work.lan>	 <20090302112400.GA2356@khazad-dum.debian.net>	 <1236164049.3936.17.camel@hughsie-work.lan>	 <20090304120439.GA31850@khazad-dum.debian.net>	 <1250625730.2257.11.camel@hidalgo>  <20090818201002.GA32638@srcf.ucam.org> <1250627230.2257.15.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1250627230.2257.15.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Matthew Garrett <mjg@redhat.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-acpi <linux-acpi@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Yves-Alexis Perez wrote:
> On mar, 2009-08-18 at 21:10 +0100, Matthew Garrett wrote:
>   
>>> It seems that this patch is still not in master?
>>>       
>> Correct. We can't change the existing semantics without breaking 
>> existing userspace applications.
>>     
>
> Hmh ok, but is it planned?
>   
>>> Currently (on debian unstable), input-events reports on my T61:
>>>
>>> KEY_SLEEP for Fn+F4
>>> KEY_SUSPEND for Fn+F12
>>>
>>> which kind-of breaks xfce4-power-manager, where SLEEP and SUSPEND
>>>       
>> both
>>     
>>> suspend to ram, so I don't have any way to hibernate. Changing xfpm
>>> doesn't seem like a good idea if the way to go is to use SUSPEND for
>>> STR, HIBERNATE for STD and SLEEP for either.
>>>
>>> So what's the status for this?
>>>       
>> KEY_SLEEP is suspend to RAM, KEY_SUSPEND is suspend to disk. xfpm should 
>> be changed to match.
>>
>>     
> Ok, I'm CC:ing the developer to let him know.
>
> Cheers,
>
>   

Dunno if i should ask the question here, now gpm relies completely on X 
to map these buttons, in X there is:

HAVE_XF86XK_SLEEP  (Suspend).

HAVE_XF86XK_HIBERNATE
HAVE_XF86XK_SUSPEND

As i understood These two buttons are suspend two disk, okay, so they 
should have the same keycode right?, or can they be two different keys?

Cheers And thanks,
Ali.
