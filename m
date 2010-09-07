From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] identify firmware version
Date: Tue, 07 Sep 2010 08:54:31 +0200
Message-ID: <4C85E1A7.2010906@gmail.com>
References: <4C7EB3A3.7050402@gmail.com> <1283791362-27780-1-git-send-email-rafi@seas.upenn.edu> <20100906194838.GB31384@core.coreip.homeip.net> <4C855BAA.4000900@gmail.com> <20100906233203.GA18048@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100906233203.GA18048@seas.upenn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, rydberg@euromail.se, chatty@enac.fr
List-Id: linux-input@vger.kernel.org

On 09/07/2010 01:32 AM, Rafi Rubin wrote:
> On Mon, Sep 06, 2010 at 11:22:50PM +0200, Jiri Slaby wrote:
>>>> +
>>>> +		ret = ntrig_version_string(&data[2], buf);
>>>> +
>>>> +		dev_info(&hdev->dev,
>>>> +			 "Firmware version: %s (%02x%02x %02x%02x)\n",
>>>> +			 buf, data[2], data[3], data[4], data[5]);
>>>> +
>>>> +		kfree(buff);
>>
>> In any case, this doesn't compile...
>>
>>>> +	}
> 
> Jiri, I moved the code to a separate function as Dmitry suggested, and compiled a kernel from a clean tree using 
> gcc-3.4 (I think).

This version is OK. In the previous one, there was
char *buf;
...
kfree(buff);

thanks,
-- 
js
