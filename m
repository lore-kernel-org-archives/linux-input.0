From: Tim Schumacher <timschumi@gmx.de>
Subject: Re: [PATCH 01/20] Input: iforce - remove "being used" silliness
Date: Wed, 19 Sep 2018 16:51:26 +0200
Message-ID: <0541f46d-1f4f-05f4-8e93-6663f6c13bd9@gmx.de>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 18.09.18 02:47, Dmitry Torokhov wrote:
> The kernel is supposed to handle multiple devices, static flags
> in packet handling code will never work.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> This is a random assortment of iforce patches that I made a few weeks back.
> 
> Tim, I do not have hardware, so I was bound to screw it up, but if you
> have some time I'd appreciate if you try them out (and if I indeed broke
> things if you could identify issues that would be even more awesome).
> 
> Thanks!
> 
Hello Dmitry,

I tested those patches and I didn't find any obvious issues. The basic functions
do work (i.e. buttons and axes, don't have a HAT so I can't test that), force
feedback seems to work to the extent it was before (I only have fftest though,
no games that support force feedback). I'll go through a few more applications
and see if anything not obvious is broken.

Unfortunately, I only have that one wheel and I can only test USB connections
at the moment (unless I find a proper serial adaptor, but I'm not sure if that
would even work).

Are those patches planned to go into 4.19 or are they intended to be merged in
the next development cycle?
