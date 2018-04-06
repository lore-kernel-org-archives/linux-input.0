From: Ben Caradoc-Davies <ben@transient.nz>
Subject: Re: Commit *driver core: emit uevents when device is bound to a
 driver* causes regression
Date: Sat, 7 Apr 2018 00:47:33 +1200
Message-ID: <f097066f-8880-fb89-44ae-01ede7c0a06a@transient.nz>
References: <8d22cfe6-90b6-eb86-d82e-0e037bfbed4e@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d22cfe6-90b6-eb86-d82e-0e037bfbed4e@molgen.mpg.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>, Michael Tokarev <mjt@tls.msk.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Paul,

I agree that this is a regression in user space, but I would also like 
to note that, as I reported in Debian Bug#883425 ([3] and [4] below), I 
was able to restore user space functionality by upgrading to gvfs 
1.35.90-1. This later gvfs appears to support (i.e. survive) these uevents.

Kind regards,
Ben.

On 07/04/18 00:20, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Commit 1455cf8 (driver core: emit uevents when device is bound to a
> driver) [1], introduced in Linux 4.14-rc1, causes a regression in user 
> space.
> 
> After disconnecting USB devices, they are still shown as plugged in [2][3].
> 
>> I seem to be having a similar issue, but with an iPhone X using USB
>> to provide internet access. Even after the phone is disconnected, it
>> still shows up as "loaded active plugged". The only way to fix this
>> is to reboot or use a different USB port.
> 
> `git bisect` shows that commit 1455cf8 (driver core: emit uevents when 
> device is bound to a driver) is at fault [4].
> 
> As user space should not break with newer Linux kernels, do you know 
> what to do about that or can you think of a fix?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1455cf8dbfd06aa7651dcfccbadb7a093944ca65 
> 
> [2] https://github.com/systemd/systemd/issues/7587
> [3] https://bugs.debian.org/883425
> [4] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=883425#68
> 

-- 
Ben Caradoc-Davies <ben@transient.nz>
Director
Transient Software Limited <https://transient.nz/>
New Zealand
