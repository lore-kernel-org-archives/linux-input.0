From: Jan Kratochvil <honza@jikos.cz>
Subject: Re: [PATCH 4/4] xpad.c - fixed report for dpad and inverted Y and
 RY axes
Date: Wed, 13 Jun 2007 08:26:01 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0706130823460.22353@twin.jikos.cz>
References: <alpine.LRH.0.98.0706031610380.22353@twin.jikos.cz>
 <d120d5000706110736g3a15f86bg75ff57e3170819f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000706110736g3a15f86bg75ff57e3170819f1@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Brian Magnuson <bdmagnuson@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, 11 Jun 2007, Dmitry Torokhov wrote:
> I have some concerns over this patch - when mapping dpad to buttons
> your new mapping follows mapping for classic xbox; however it is still
> different when mapping dpad to axes so this is suspicious. Could you
> please try the attached patch and tell me if it works for you?

Yes your patch is working and I have to admit that it even looks better :)

>
> Also, please avoid constructs like this:
>
>> +               input_report_abs(dev, ABS_HAT0Y, !!((data[2] & 0x08) >> 3) 
>> - !!((data[2] & 0x04) >> 2));
>
> Doing shift is meaningles if you convert result to 0/1. I.e. it is
> exactly the same as !!(data[2] & 0x08) - !!(data[2] &0x04).
>
Ah thanks, it is so obvious. I somehow forget to think.

Jan
