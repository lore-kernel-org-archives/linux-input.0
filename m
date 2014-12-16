From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/2] Input: atmel_mxt_ts - Add support for T100 multi-touch
Date: Tue, 16 Dec 2014 16:39:13 +0000
Message-ID: <54906031.8020309@itdev.co.uk>
References: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk> <54905AD7.4070205@itdev.co.uk> <54905F00.4020107@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54905F00.4020107@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 16/12/14 16:34, Javier Martinez Canillas wrote:
> On 12/16/2014 05:16 PM, Nick Dyer wrote:
>>> Nick Dyer (1):
>>>   Input: atmel_mxt_ts - Implement support for T100 touch object
>> I posted an updated version of this patch on 9th December and would prefer
>> you apply that rather than this version, since it contains some useful
>> additional work.
>>
>> A link to it:
>> http://www.spinics.net/lists/kernel/msg1885519.html
> 
> Great, I didn't know about your patch since I was not in the cc list.
> 
> Thanks for posting and feel free to discard these patches.

No worries! Do you want me to put you on CC in future?

I will add a todo to pick up your second change "Split out touchpad
initialisation logic" into patches I have waiting for upstream, it is a
sensible refactoring I think.
