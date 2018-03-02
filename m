From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event
 action
Date: Fri, 02 Mar 2018 11:57:21 +0800
Message-ID: <5A98CBA1.6090801@rock-chips.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com> <20180210110907.5504-2-jeffy.chen@rock-chips.com> <20180212221309.GA66974@ban.mtv.corp.google.com> <5A8FE726.6080903@rock-chips.com> <20180302023229.GA164361@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180302023229.GA164361@rodete-desktop-imager.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, dtor@google.com, dianders@google.com, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Brain,

Thanks for your reply.

On 03/02/2018 10:32 AM, Brian Norris wrote:
>>> > >What about the 'else' case? Shouldn't we try to handle that?
>> >i think the else case is for irq key, which would generate down and up
>> >events in one irq, so it would use the same trigger type for all these 3
>> >cases.
> Not necessarily. It uses whatever trigger was provided in
> platform/DT/etc. data. You could retrieve that with
> irq_get_trigger_type() and try to interpret that. Or you could just
> outlaw using that combination (e.g., in the binding documentation).
i think for the IRQ button case the assert/deassert/any are using the 
same irq trigger type, so it should be ok to leave the wakeup trigger 
type to be 0(not reconfigure the trigger type)...

i've made a v3 to add a comment about that, but forgot to send it :(

>
> Brian
>
