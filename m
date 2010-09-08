From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] identify firmware version
Date: Wed, 08 Sep 2010 11:42:36 -0400
Message-ID: <4C87AEEC.3000309@seas.upenn.edu>
References: <4C7EB3A3.7050402@gmail.com> <1283791362-27780-1-git-send-email-rafi@seas.upenn.edu> <20100906194838.GB31384@core.coreip.homeip.net> <4C855BAA.4000900@gmail.com> <20100906233203.GA18048@seas.upenn.edu> <4C85E1A7.2010906@gmail.com> <alpine.LNX.2.00.1009081147070.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1009081147070.26813@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, rydberg@euromail.se, chatty@enac.fr
List-Id: linux-input@vger.kernel.org

On 09/08/10 05:47, Jiri Kosina wrote:
> On Tue, 7 Sep 2010, Jiri Slaby wrote:
> 
>>>>>> +
>>>>>> +		ret = ntrig_version_string(&data[2], buf);
>>>>>> +
>>>>>> +		dev_info(&hdev->dev,
>>>>>> +			 "Firmware version: %s (%02x%02x %02x%02x)\n",
>>>>>> +			 buf, data[2], data[3], data[4], data[5]);
>>>>>> +
>>>>>> +		kfree(buff);
>>>>
>>>> In any case, this doesn't compile...
>>>>
>>>>>> +	}
>>>
>>> Jiri, I moved the code to a separate function as Dmitry suggested, and compiled a kernel from a clean tree using 
>>> gcc-3.4 (I think).
>>
>> This version is OK. In the previous one, there was
>> char *buf;
>> ...
>> kfree(buff);
> 
> Dmitry, Jiri, thanks a lot for taking care reviewing the patch while I 
> have been lagging behind.
> 
> Now applied, thanks Rafi.

Thanks Jiri, and thanks for all the feedback.
