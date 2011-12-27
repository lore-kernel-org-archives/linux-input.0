From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] Input: mpu3050: add of_match table for device-tree probing
Date: Tue, 27 Dec 2011 10:07:42 -0600
Message-ID: <4EF9ED4E.6000408@gmail.com>
References: <1324607992-2919-1-git-send-email-olof@lixom.net> <20111223092246.GA7120@core.coreip.homeip.net> <CAOesGMiGJmc6FhsDcsmROUgoLD4eDFKK=LE7yYjkJn1O7oiL8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54733 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab1L0QHq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Dec 2011 11:07:46 -0500
Received: by ghbg21 with SMTP id g21so1535025ghb.19
        for <linux-input@vger.kernel.org>; Tue, 27 Dec 2011 08:07:45 -0800 (PST)
In-Reply-To: <CAOesGMiGJmc6FhsDcsmROUgoLD4eDFKK=LE7yYjkJn1O7oiL8Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On 12/23/2011 09:58 AM, Olof Johansson wrote:
> Hi,
> 
> On Fri, Dec 23, 2011 at 1:22 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Olof,
>>
>> On Thu, Dec 22, 2011 at 06:39:52PM -0800, Olof Johansson wrote:
>>> Adding invn,mpu3050 as the initial id.
>>>
>>
>> I believe you also need to add this to
>> Documentation/devicetree/bindings/input/
> 
> For simple i2c devices that only have a name, address and possibly an
> interrupt, there's no need to document a binding (it hasn't been done
> in the past for the vast majority of those devices).

But then how do you find out if there is a existing binding for a device
without searching in the kernel source tree? The binding docs are
planned to be moved out as they are not Linux specific. There needs to
be 1 location to find binding information.

I do wonder if we should have a more structured registry or database of
bindings than free form text files...

Rob
