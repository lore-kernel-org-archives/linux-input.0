From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils
 ?
Date: Thu, 27 Jan 2011 13:12:48 -0500
Message-ID: <4D41B5A0.70704@teksavvy.com>
References: <20110125205453.GA19896@core.coreip.homeip.net> <4D3F4804.6070508@redhat.com> <4D3F4D11.9040302@teksavvy.com> <20110125232914.GA20130@core.coreip.homeip.net> <20110126020003.GA23085@core.coreip.homeip.net> <4D403855.4050706@teksavvy.com> <4D40C3D7.90608@teksavvy.com> <4D40C551.4020907@teksavvy.com> <20110127021227.GA29709@core.coreip.homeip.net> <4D40E41D.2030003@teksavvy.com> <20110127163931.GA1825@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110127163931.GA1825@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 11-01-27 11:39 AM, Dmitry Torokhov wrote:
> On Wed, Jan 26, 2011 at 10:18:53PM -0500, Mark Lord wrote:
>> No, it does not seem to segfault when I unload/reload ir-kbd-i2c
>> and then invoke it by hand with the same parameters.
>> Quite possibly the environment is different when udev invokes it,
>> and my strace attempt with udev killed the system, so no info there.
>>
> 
> Hmm, what about compiling with debug and getting a core then?

Sure.  debug is easy, -g, but you'll have to tell me how to get it
do produce a core dump.

Cheers
