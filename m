From: Avraham Shukron <avraham.shukron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: usbkbd: fix checkpatch.pl issues
Date: Wed, 1 Mar 2017 22:55:29 +0200
Message-ID: <aeea6c53-e865-38b2-5ed6-f2f057ac30a5@gmail.com>
References: <48d55583-6f2d-cfda-c6dd-0e789f4bf6f1@gmail.com>
 <20170301181628.GD30349@dtor-ws>
 <3c67c4db-9b59-82f1-9406-3dfdb2ac0a48@gmail.com>
 <1488401182.20731.11.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488401182.20731.11.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


On 01/03/17 22:46, Joe Perches wrote:
> On Wed, 2017-03-01 at 21:59 +0200, Avraham Shukron wrote:
>>>
>>> This kind of change is definitely not helpful. The original table was
>>> Nx16, you converted it to Nx14. Why do you think original table used 16
>>> columns?
>>>
>>> Regardless, it's a very old driver, just let it be.
>>>
>>> Thanks.
>>>
>>
>> I can make it Nx8 :)
>>
>> Seriously now - I don't understand what is so wrong with checkpatch fixes?
> 
> Some say is makes following logical changes more difficult.
> git blame, etc...  I'm not a big adherent of that though.
> 
>> I'm a new to kernel development, and the natural place to start is to do some
>> coding style fixes.
>> I thought fixing a driver that I actually use daily will be more satisfying.
>> Why driver being old is a good reason to ignore the coding style conventions?
> 
> The space after comma rule _should_ be broken when
> alignment is more obvious.  The existing code is just fine.
> 
> Conventions are just that.  It's OK to be unconventional.
> 
> It's better to know when to follow and when not to follow
> those conventions.
> 
> checkpatch messages should be considered guides and not
> dicta that must be followed to the last letter.
> 
> To me, the rest of the patch was OK though.
> 
> If you want to learn the kernel patch process, modifying files
> in drivers/staging is a good place to start.
> 
> Otherwise, it's probably best to find/fix some actual defect
> and suggest actual logical changes that reduce code size,
> improve performance, expand test coverage, better document
> the code, etc..
> 
> cheers, Joe
> 

Thanks you very much for the the answer.
That explains the matter.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
