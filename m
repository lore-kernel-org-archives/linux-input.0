From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR  system?
Date: 08 Dec 2009 23:25:00 +0100
Message-ID: <BEVhz2BHqgB@lirc>
References: <9e4733910912080534m1fe8c5bakb9219c6a55f0bcaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <9e4733910912080534m1fe8c5bakb9219c6a55f0bcaa@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: jonsmirl@gmail.com
Cc: awalls@radix.net, dmitry.torokhov@gmail.com, hermann-pitton@arcor.de, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Hi Jon,

on 08 Dec 09 at 08:34, Jon Smirl wrote:
[...]
> The point of those design review questions was to illustrate that the
> existing LIRC system is only partially designed. Subsystems need to be
> fully designed before they get merged.

I'd say that a system that has proven itself in real world applications  
for >10 years, does not deserve to be called partially designed.

> For example 36-40K and 56K IR signals are both in use. It is a simple
> matter to design a receiver (or buy two receivers)  that would support
> both these frequencies. But the current LIRC model only supports  a
> single IR receiver. Adjusting it to support two receivers is going to
> break the ABI.

Really? When we added support for multiple transmitters, we somehow  
managed to do without breaking the ABI. Do I miss something?

Your example could even now be solved by using the LIRC_SET_REC_CARRIER  
ioctl. The driver would have to choose the receiver that best fits the  
requested frequency.

[...]
> We need to think about all of these use cases before designing the
> ABI.  Only after we think we have a good ABI design should code start
> being merged. Of course we may make mistakes and have to fix the ABI,
> but there is nothing to be gained by merging the existing ABI if we
> already know it has problems.

The point is that we did not get up this morning and started to think  
about how the LIRC interface should look like. That happened 10 years ago.

I'm not saying that the interface is the nicest thing ever invented, but  
it works and is extendable. If you see that something is missing please  
bring it up.

Christoph
