From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND PATCH] Input: joystick/analog - Use get_cycles() on PPC
Date: Sat, 17 Mar 2018 01:00:29 +1100
Message-ID: <87woycglxe.fsf@concordia.ellerman.id.au>
References: <20180314111752.1748-1-mpe@ellerman.id.au> <20180314163913.GC18065@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314163913.GC18065@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> On Wed, Mar 14, 2018 at 10:17:52PM +1100, Michael Ellerman wrote:
>> The analog joystick driver spits a warning at us:
>> 
>>   drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer
>>   not defined for this architecture.
>> 
>> PPC has get_cycles() so use that.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Applied, thank you.

Thanks.

cheers
