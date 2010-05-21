From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev3)
Date: Fri, 21 May 2010 18:56:35 +0200
Message-ID: <4BF6BB43.2020405@euromail.se>
References: <1274457354-5570-1-git-send-email-rydberg@euromail.se> <AANLkTikBWzgRmso0oQNXcTxeExdKZORXYbIwK9CcMl85@mail.gmail.com> <4BF6B673.1080507@euromail.se> <20100521165218.GA26439@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100521165218.GA26439@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Friday 21 May 2010 09:36:03 am Henrik Rydberg wrote:
>> Ping Cheng wrote:
>>> Hi Henrik,
>>>
>>> Thank you for your quick turnaround. Two minor comments in line.
>>>
>>> Ping
>> Thanks for those, yes, both mistakes. Dmitry, in case you find these last
>> versions acceptable, perhaps one could change them manually:
>>
>> 1. Patch description: s/SYN_MT_SLOT/ABS_SLOT/
> 
> Not ABS_MT_SLOT?

I wrote an argument for ABS_SLOT in the first patch, in short there is a
namespace clash I would like to avoid.

Henrik
