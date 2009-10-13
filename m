From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: New driver for Altera PS/2 controller
Date: Mon, 12 Oct 2009 18:08:51 -0700
Message-ID: <20091013010850.GC21626@core.coreip.homeip.net>
References: <1254985152-32407-1-git-send-email-thomas@wytron.com.tw> <20091010045603.GA9914@core.coreip.homeip.net> <4AD060D0.7090502@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758509AbZJMBJd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AD060D0.7090502@wytron.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Chou <thomas@wytron.com.tw>
Cc: linux-input@vger.kernel.org, Nios2 development list <nios2-dev@sopc.et.ntust.edu.tw>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Oct 10, 2009 at 06:24:16PM +0800, Thomas Chou wrote:
> On 10/10/2009 12:56 PM, Dmitry Torokhov wrote:
>> Hi Thomas,
>>
>> On Thu, Oct 08, 2009 at 02:59:12PM +0800, Thomas Chou wrote:
>>    
>>> This patch adds a new SERIO driver to support the Altera University
>>> Program PS/2 controller.
>>>
>>>      
>> Thank you for the patch, it looks like it is reasonable written although
>> it should do request_mem_region for the IO memory region it tries to
>> remap and also IO addresses should not be cast to unsigned int but
>> rather 'void __iomem *'. I also don;t see the reason for it to depend on
>> EMBEDDED since the things that depend on EMBEDDED are usually features
>> that are used almost by everyone and only in case of embedded arch you
>> may want to turn them off to save some memory.
>>
>> I also prefer even static functions to have the driver name as their
>> prefix - this way if I see a backtrace I know exactly which module is
>> involved.
>>
>> I made a small patch on top of yours, please give it a try and if it did
>> not break anything then I will fold it all together and queue for
>> 2.6.33.
>>
>> Thanks!
>>
>>    
> Hi Dmitry,
>
> Thank you very much for your help. I have tested the updated driver with  
> PS/2 keyboard and mouse on boards. They all worked well.
>

Great, tahnk you for giving it a spin. I'll queue the driver for 2.6.33.

-- 
Dmitry
