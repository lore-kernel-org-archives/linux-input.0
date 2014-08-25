From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Second batch of cleanups for cros_ec
Date: Mon, 25 Aug 2014 19:28:01 +0200
Message-ID: <53FB7221.8090804@collabora.co.uk>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk> <20140825170533.GA29350@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140825170533.GA29350-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

On 08/25/2014 07:05 PM, Dmitry Torokhov wrote:
>> 
>> Patches #1, #2, #6 and #7 do not depend of others so they can be
>> merged independently but patches #3, #4 and #5 have to be merged
>> in that specific order since they depend on the previous one. 
> 
> #7 does not apply to my tree (I guess it depends on the 1st batch which I
> expect will go through MFD tree?). Maybe you could rebase it on top of my next
> so it can be applied sooner? Or it really needs parts of patchset #1?
> 

The first batch sent by Doug did indeed touch this driver and the patches
were merged through the MFD tree for 3.17 as you said. I see that your
next branch is based on 3.16-rc6 and that is why it does not apply cleanly.

I guess you will rebase your next branch for 3.18 on top of 3.17-rc1
anyways which will fix this issue? If not please let me know and I can of
course re-spin the patch so it applies cleanly on top of 3.16-rc6.

> Thanks.
> 

Best regards,
Javier
