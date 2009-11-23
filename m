From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: 23 Nov 2009 22:10:00 +0100
Message-ID: <BDRabhTZjFB@christoph>
References: <BDC6A41E-67C0-4952-94E9-D405C7209394@wilsonet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <BDC6A41E-67C0-4952-94E9-D405C7209394@wilsonet.com>
Sender: linux-media-owner@vger.kernel.org
To: jarod@wilsonet.com
Cc: dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Hi Jarod,

on 23 Nov 09 at 14:17, Jarod Wilson wrote:
>> Krzysztof Halasa wrote:
[...]
>> If you see patch 3/3, of the lirc submission series, you'll notice a driver
>> that has hardware decoding, but, due to lirc interface, the driver
>> generates pseudo pulse/space code for it to work via lirc interface.

> Historically, this is true.

No, it's not.
I think you misunderstood the code. The comment may be a bit misleading,
too.
Early iMON devices did not decode in hardware and the part of the driver
that Krzystof is referring to is translating a bit-stream of the sampled  
input data into pulse/space durations.

Christoph
