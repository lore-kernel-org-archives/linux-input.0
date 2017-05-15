From: Arek Burdach <arek.burdach@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Mon, 15 May 2017 20:49:00 +0200
Message-ID: <ab18c087-febd-12e7-56c1-660b9b90c5e6@gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <8c492623-d37c-e8e1-2445-cf86109dad44@ginzinger.com>
 <aa5cb000-7e8a-2f9b-30de-a35b0c44db96@gmail.com>
 <9e370d9b-a2d4-9fcd-9b0d-2d97e225188a@ginzinger.com>
 <CAN+gG=EchYSE4=iZU9NPOvQy6PHZVSZcA2YkoH01nhg81E+Xsw@mail.gmail.com>
 <8566ae03-faad-a1ee-2156-db49d36cea71@ginzinger.com>
 <CAN+gG=Frvd0bJ62xBp+sGFgqB5=mdYwJGo7L+MZiscNbPb4K_w@mail.gmail.com>
 <540cd246-d72f-a9eb-9618-ff2449384a21@ginzinger.com>
 <a4766146-3edb-31c6-16dd-99eee28bdd63@gmail.com>
 <CAN+gG=F8kaWaS81L9uxON-ZDQoHe6eS2puauAofJxGKkhEeCcg@mail.gmail.com>
 <8d690a3d-88f6-cef9-b271-da5dcc87741b@gmail.com>
 <12ac2e90-ba7b-8a29-bb35-40d50841a63b@ginzinger.com>
 <27a556e7-2045-2d6a-3b13-287d314375d5@gmail.com>
 <CAN+gG=G3KbhTFcXZEmiYuOmFsjADvHuwXRxz=FOKf6F9ctB8gg@mail.gmail.com>
 <e87c0744-ff24-d6f5-090b-ab96a478f674@gmail.com>
 <c2492242-71c3-1bd5-8e1e-0f282e9ab0d1@gmail.com>
 <CAN+gG=H_B_Y9WspjJKJCLKyAHCfLfQgazifeQ_hPMm8o4nqJow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35722 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934309AbdEOStD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 15 May 2017 14:49:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id v4so30731998wmb.2
        for <linux-input@vger.kernel.org>; Mon, 15 May 2017 11:49:03 -0700 (PDT)
In-Reply-To: <CAN+gG=H_B_Y9WspjJKJCLKyAHCfLfQgazifeQ_hPMm8o4nqJow@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>, Andrew Duggan <aduggan@synaptics.com>, =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>

Hi Benjamin,

I found out what was wrong in the change that you've provided:

On 12.05.2017 16:28, Benjamin Tissoires wrote:
 >>
 >>     + if (td->mtclass.quirks & MT_QUIRK_STICKY_FINGERS) + 
mod_timer(&td->release_timer, msecs_to_jiffies(250)); }
Should be:
mod_timer(&td->release_timer, jiffies + msecs_to_jiffies(100));

Delay should be added to current jiffies value. Also I found out that 
250 ms is too long delay - xserver recognize such a delay as a drag 
gesture. Using 100 ms everything works perfectly!

What do you think that should be changed more in the patch to make it 
ready for being submitted as an official patch? I thought about some 
unit tests, but can't find any for hid drivers also I don't know how to 
mock timers.

One more time, thank you for your support!

Cheers, Arek
