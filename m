From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: 3.12.x looses serial mouse over hibernate + resume
Date: Mon, 02 Dec 2013 12:30:57 -0700
Message-ID: <529CDFF1.2080807@samsung.com>
References: <52951E69.7090602@netscape.net>
 <529B591F.1020909@hurleysoftware.com> <529CB07C.2040609@netscape.net>
 <19253701.sgP3OieFUq@dtor-d630.eng.vmware.com>
 <20131202164525.GA32406@core.coreip.homeip.net>
 <529CD303.4040103@netscape.net> <529CD528.9000709@samsung.com>
 <20131202190824.GB5245@core.coreip.homeip.net>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-reply-to: <20131202190824.GB5245@core.coreip.homeip.net>
Sender: linux-serial-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Manuel Krause <manuelkrause@netscape.net>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>
List-Id: linux-input@vger.kernel.org

On 12/02/2013 12:08 PM, Dmitry Torokhov wrote:
> On Mon, Dec 02, 2013 at 11:44:56AM -0700, Shuah Khan wrote:

>>>
>>
>> I am glad the problem is fixed. But I am puzzled. pnp_bus_resume()
>> didn't handle restore prior to this change. state doesn't get passed
>> in to legacy resume routines. I had to add freeze to handle
>> PMSG_FREEZE case, sounds like restore is needed as well, however I
>> don't see where how restore is handled prior to this change.
>
> Take a look at drivers/base/platform.c::platform_pm_restore()
>
> Thanks.
>

Yes I see it now. Before the conversion, platform_legacy_resume() path 
is taken since pnp didn't have pm.

        if (drv->pm) {
                 if (drv->pm->restore)
                         ret = drv->pm->restore(dev);
        } else {
                 ret = platform_legacy_resume(dev);
         }

Thanks for fixing the problem.

-- Shuah

-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
