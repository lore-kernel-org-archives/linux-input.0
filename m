From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 0/2] Input: atmel_mxt_ts - Add support for T100 multi-touch
Date: Tue, 16 Dec 2014 17:49:09 +0100
Message-ID: <54906285.3060907@collabora.co.uk>
References: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk> <54905AD7.4070205@itdev.co.uk> <54905F00.4020107@collabora.co.uk> <54906031.8020309@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54906031.8020309@itdev.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Nick,

On 12/16/2014 05:39 PM, Nick Dyer wrote:
> On 16/12/14 16:34, Javier Martinez Canillas wrote:
>> On 12/16/2014 05:16 PM, Nick Dyer wrote:
>>>> Nick Dyer (1):
>>>>   Input: atmel_mxt_ts - Implement support for T100 touch object
>>> I posted an updated version of this patch on 9th December and would prefer
>>> you apply that rather than this version, since it contains some useful
>>> additional work.
>>>
>>> A link to it:
>>> http://www.spinics.net/lists/kernel/msg1885519.html
>> 
>> Great, I didn't know about your patch since I was not in the cc list.
>> 
>> Thanks for posting and feel free to discard these patches.
> 
> No worries! Do you want me to put you on CC in future?
> 

Yes, please cc me and also to Sjoerd since we are working on machines
that have Atmel maxtouch chips.

> I will add a todo to pick up your second change "Split out touchpad
> initialisation logic" into patches I have waiting for upstream, it is a
> sensible refactoring I think.
> 

Awesome, what do you think about the change to have a common input device
initialization function that I squashed in your original patch?
mxt_initialize_t100_input_device() and mxt_initialize_t9_input_device()
are very similar so I think that is a sensible refactoring as well.

If you agree with the change I can post it on top of your patch once it
lands in mainline.

Best regards,
Javier
