From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR  system?
Date: 06 Dec 2009 13:12:00 +0100
Message-ID: <BENh5lRHqgB@lirc>
References: <9e4733910912041628g5bedc9d2jbee3b0861aeb5511@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <9e4733910912041628g5bedc9d2jbee3b0861aeb5511@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: jonsmirl@gmail.com
Cc: awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Hi Jon,

on 04 Dec 09 at 19:28, Jon Smirl wrote:
>> BTW, I just came across a XMP remote that seems to generate 3x64 bit
>> scan codes. Anyone here has docs on the XMP protocol?
>
> Assuming a general purpose receiver (not one with fixed hardware
> decoding), is it important for Linux to receive IR signals from all
> possible remotes no matter how old or obscure? Or is it acceptable to
[...]
> Of course transmitting is a completely different problem, but we
> haven't been talking about transmitting. I can see how we would need
> to record any IR protocol in order to retransmit it. But that's in the
> 5% of users world, not the 90% that want MythTV to "just work".  Use
> something like LIRC if you want to transmit.

I don't think anyone here is in the position to be able to tell what is  
90% or 5%. Personally I use LIRC exclusively for transmit to my settop box  
using an old and obscure RECS80 protocol.
No, I won't replace my setup just because it's old and obscure.

Cable companies tend to provide XMP based boxes to subscribers more often  
these days. Simply not supporting these setups is a no-go for me.

Christoph
