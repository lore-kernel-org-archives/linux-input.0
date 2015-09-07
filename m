From: Stephan Mueller <smueller@chronox.de>
Subject: Re: USB HID devices not linked to RNG
Date: Mon, 07 Sep 2015 02:12:51 +0200
Message-ID: <1461912.H1d3XDk5sm@myon.chronox.de>
References: <1735492.1FWVU9y0M8@myon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1735492.1FWVU9y0M8@myon.chronox.de>
Sender: linux-crypto-owner@vger.kernel.org
To: linux-crypto@vger.kernel.org
Cc: linux-input@vger.kernel.org, tytso@mit.edu
List-Id: linux-input@vger.kernel.org

Am Montag, 7. September 2015, 02:10:16 schrieb Stephan Mueller:

Hi Stephan,

> Hi,
> 
> While analyzing the entropy sources for the random number generator in
> drivers/char/random.c, I saw that a USB mouse and a USB keyboard does
> trigger the add_input_randomness function to be triggered.

I need to reread what I write :-)

I mean that the USB mouse and USB keyboard does *not* trigger the 
add_input_randomness function.

> 
> Is that intended?


-- 
Ciao
Stephan
