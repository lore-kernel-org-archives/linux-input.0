From: "Vadim Klishko" <vadim@cirque.com>
Subject: Re: ALPS: Cirque Smart Cat Pro AG Touchpad Support
Date: Mon, 20 Jan 2014 13:01:26 -0700
Message-ID: <96BD1741C22B446CAA6FA3ABC0B6724B@cirque.local>
References: <52D6B45A.4050202@gmail.com>	<CA+F6ckMgiF-TrCf1rxNGvGrPHubxdVCtTBsLOKHpg=StRt8BvA@mail.gmail.com>	<52D955A3.9040802@gmail.com>	<CA+F6ckPDkigiy1qKPTXE7Ec1xgj3Jk-fXa-vrpjwd_vJmzU2Yg@mail.gmail.com> <CA+F6ckP1JHJF0q8HZXKFPf1on8PB+QX6suNmavu8eWT4gSK0rA@mail.gmail.com> <52DCA136.5030207@gmail.com> <9A2D41DC5C294BAE8568615F106C72F2@HITLER> <52DCAC4D.40206@gmail.com> <B087429E37D344BD9FB56A029514CADB@HITLER> <52DCB323.6070200@gmail.com> <4451DE5582E243FDA7455A649E172C7F@HITLER> <52DCB922.7020300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from p01c11o148.mxlogic.net ([208.65.144.71]:44623 "EHLO
	p01c11o148.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaATUB2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jan 2014 15:01:28 -0500
Received: by mail-ie0-f173.google.com with SMTP id e14so8778447iej.18
        for <linux-input@vger.kernel.org>; Mon, 20 Jan 2014 12:01:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: AJ Guillon <aj.guillon@gmail.com>
Cc: linux-input@vger.kernel.org, Tommy Will <tommywill2011@gmail.com>

Hello AJ,

I have heard from our customers before that using a touchpad is easier on one's hand than a mouse. Using a touchpad for moving and pointing should already reduce the strain. Being able to adjust touchpad settings may not give you any additional strain reduction benefits, but it could certainly make the experience of using a touchpad more pleasant.

But that is really beside the point. I am not trying to tell you what you need or don't need. You have the right to want a driver for your touchpad for whatever reason, and I sincerely apologize that we don't have one for Linux. We would really love to be able to provide one, but, unfortunately, we don't have one available. If we had, it would be a closed source user-space driver.

I can raise the question of reviving our Linux driver project with our management, but it might take a while before it is completed.

Can you suggest any other solution?

Sincerely,

Vadim


----- Original Message ----- 
From: "AJ Guillon" <aj.guillon@gmail.com>
To: "Vadim Klishko" <vadim@cirque.com>
Cc: <linux-input@vger.kernel.org>; "Tommy Will" <tommywill2011@gmail.com>
Sent: Sunday, January 19, 2014 10:50 PM
Subject: Re: ALPS: Cirque Smart Cat Pro AG Touchpad Support


> Hi Vadim,
> 
> I'm a professional developer and it was suggested to me that I use a
> Cirque touchpad to reduce strain based on my work habits.  Since 100% of
> my development is done on Linux systems, this touchpad is only useful to
> me in that environment.
> 
> I'm not entirely sure what features this touchpad actually supports, but
> it would be nice if I could use it to its full potential.  The side
> buttons, I suppose, are programmable so it would be nice for me to be
> able to set them to switch desktops or something.  Ideally, I would like
> to script this touchpad as much as I can to reduce potential for injury.
> 
> AJ
> 
> On 14-01-20 12:40 AM, Vadim Klishko wrote:
>> Hi AJ,
>> 
>> Apparently, the Linux kernel doesn't have support for that touchpad. In fact, I am not sure it has support for any USB touchpads.
>> 
>> At one point, Cirque tried to create a driver for Linux, but we ran into legal issues with the GPL. We then started working on a user-space driver, but there didn't seem to be enough demand or interest in it, so we have never finished it.
>> 
>> What kind of interesting things are you looking to do with the touchpad?
>> 
>> Vadim
>> 
>> 
>> ----- Original Message ----- 
>> From: "AJ Guillon" <aj.guillon@gmail.com>
>> To: "Vadim Klishko" <vadim@cirque.com>
>> Cc: <linux-input@vger.kernel.org>; "Tommy Will" <tommywill2011@gmail.com>
>> Sent: Sunday, January 19, 2014 10:24 PM
>> Subject: Re: ALPS: Cirque Smart Cat Pro AG Touchpad Support
>> 
>> 
>> USB.  Model GP415U-5321.
>> 
>> AJ
>> 
>> On 14-01-20 12:23 AM, Vadim Klishko wrote:
>>> Is it a USB or PS/2 touchpad?
>>>
>>>
>>> ----- Original Message ----- 
>>> From: "AJ Guillon" <aj.guillon@gmail.com>
>>> To: "Vadim Klishko" <vadim@cirque.com>
>>> Cc: <linux-input@vger.kernel.org>; "Tommy Will" <tommywill2011@gmail.com>
>>> Sent: Sunday, January 19, 2014 9:55 PM
>>> Subject: Re: ALPS: Cirque Smart Cat Pro AG Touchpad Support
>>>
>>>
>>> Hi Vadim,
>>>
>>> I am currently on Kubuntu 12.04 (3.2.0-29-generic), and this device is
>>> not recognized as a touchpad.  I have not yet tested a nightly build
>>> with a recent kernel to see if that works.
>>>
>>> It is detected and works as a mouse right now, but my understanding is
>>> that if it is recognized as a touchpad I can do more interesting things
>>> with it ;-)
>>>
>>> AJ
>>>
>>> On 14-01-19 11:41 PM, Vadim Klishko wrote:
>>>> Hello AJ,
>>>>
>>>> I thought it was I who was supposed to be helping. :-)
>>>>
>>>> Can you please describe the problem?
>>>>
>>>> Vadim
>>>>
>>>>
>>>> ----- Original Message ----- 
>>>> From: "AJ Guillon" <aj.guillon@gmail.com>
>>>> To: "Tommy Will" <tommywill2011@gmail.com>; <vadim@cirque.com>
>>>> Cc: <linux-input@vger.kernel.org>
>>>> Sent: Sunday, January 19, 2014 9:08 PM
>>>> Subject: Re: ALPS: Cirque Smart Cat Pro AG Touchpad Support
>>>>
>>>>
>>>> Hi,
>>>>
>>>> Thanks Tommy!
>>>>
>>>> Vadim: Let me know what I can do to help.
>>>>
>>>> AJ
>>>>
>>>> On 14-01-19 08:06 PM, Tommy Will wrote:
>>>>> Hi AJ,
>>>>>
>>>>> Sorry for reply late. I have got the positive reply from my Cirque's
>>>>> colleague and please allow me to introduce Vadim to you.
>>>>> He's now main for S/W development of Cirque's product and he would
>>>>> help you of your "Cirque Smart Cat Pro AG Touchpad".
>>>>>
>>>>> Thanks
>>>>>
>>>>
>>>
>>

-- 
This message and any attachment are confidential. It may also be privileged 
or otherwise protected by work product immunity or other legal rules. If 
you have received it by mistake, please let us know by e-mail reply and 
delete it from your system, you may not copy this message or disclose its 
contents to anyone.
Cirque Corporation
