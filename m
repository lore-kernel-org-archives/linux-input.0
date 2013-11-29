From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [Patch] Fix for so that recent Elantech touchpads are recognized
 as such
Date: Fri, 29 Nov 2013 22:26:45 +0100
Message-ID: <52990695.5000203@hauke-m.de>
References: <CA+X2d=AuAm3ENDbrfk7L5fXoSiLwVU5xxKVo+MbbCf_aWu=cyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+X2d=AuAm3ENDbrfk7L5fXoSiLwVU5xxKVo+MbbCf_aWu=cyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Walker <matt.g.d.walker-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 11/29/2013 01:00 AM, Matt Walker wrote:
> Hello,
> 
> Attached is a patch for drivers/input/mouse/elantech.c.  It allows
> recent Elantech touchpads to be detected.  I have tested it on the
> touchpad that comes with the Acer Aspire S7-392 (released ~August
> 2013)
> 
> I figure it could be backported with little effort and no danger,
> since all it does it add one to the number of values that were
> previously recognized as valid "firmware version numbers".
> 
> Begin Patch:
> 1315a1316
>>         case 8:
> End Patch
> 
> Best,
> Matt
> 
This is not a patch, I do not know what you want to do.

This is the documentation for hacking on backprts:
https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking

This is the guideline for patch submission to the linux kernel which
mostly also applies for backports:
https://www.kernel.org/doc/Documentation/SubmittingPatches

Hauke
