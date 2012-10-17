From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG] capslock works across all keyboards but LED does not
Date: Wed, 17 Oct 2012 10:30:51 -0700
Message-ID: <21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
References: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38828 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382Ab2JQRbB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Oct 2012 13:31:01 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so7357324pad.19
        for <linux-input@vger.kernel.org>; Wed, 17 Oct 2012 10:31:01 -0700 (PDT)
In-Reply-To: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-input@vger.kernel.org

Hi Ming,

On Wednesday, October 17, 2012 08:44:12 PM Ming Lei wrote:
> Hi,
> 
> There is one report on the below problem:[1]
> 
>         - connect one usb keyboard into laptop
>         - press capslock on internal ps/2 keyboard
>         - input from both two keyboards  becomes upper case state
>         - but only capslock led is on in ps/2 keyboard and not on in
> usb keyboard
> 
> or
>         - connect one usb keyboard into laptop
>         - press capslock on usb keyboard
>         - input from both two keyboards  becomes upper case state
>         - but only capslock led is on in usb keyboard and not on in
> internal ps/2 keyboard
> 
> No such problem on windows, and capslock input is always consistent with the
> led state on both keyboards.
> 
> I can reproduce the above problem 100% on my T410 laptop.

I see it is broken in X, but it works for me if I am using the console.
Does it work for you as well if you switch into the console? If so then
you need to file a bug against X.

Thanks.

-- 
Dmitry
