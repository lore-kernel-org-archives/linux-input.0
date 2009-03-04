From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 0/5] WM97xx updates
Date: Wed, 04 Mar 2009 10:26:07 +0100
Message-ID: <49AE492F.6020006@atmel.com>
References: <20090303182402.GA29542@rakim.wolfsonmicro.main> <20090304091538.GD7394@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756627AbZCDJ0p@vger.kernel.org>
In-Reply-To: <20090304091538.GD7394@dtor-d630.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Tue, Mar 03, 2009 at 06:24:03PM +0000, Mark Brown wrote:
>> This patch series updates the review feedback from the first round and
>> rolls in the additional patches from Mike Rapoport.  I've not addressed
>> any of the comments for the at32 driver since I have no ability to test
>> any changes to that driver but repost it for completeness.
>>
> 
> I applied first 4 patches to 'next' and will wait for Hans-Christian
> comments on the at32 driver.
> 

The only thing catched by review was a leaking irq line, do you plan to 
fixup that Mark?

I also think the header file could go into the source code, to make it 
one file less.

Also, please note that I've gotten a new email address. The old one is 
quite annoying since it sends email back about my new address...

I'll not be able to test the driver immediately, my hardware is out at 
customers and the eight new prototypes needs some resoldering before I 
can work with them. Nothing has changed in hardware though, so it should 
fly out of the box.

-- 
Best regards,
Hans-Christian Egtvedt
