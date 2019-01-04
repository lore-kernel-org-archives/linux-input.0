From: Andreas Gohr <andi@splitbrain.org>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Fri, 4 Jan 2019 23:31:29 +0100
Message-ID: <CAO00Eh6F4CMF_rPTWjFCon_87wSxA-vRm8DqSw=0sxSbpC_39w@mail.gmail.com>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com> <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Gonzalez <alex.gonzalez@digi.com>
Cc: Bastien Nocera <hadess@hadess.net>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> Designs that only provide the INT line are able to operate the touch on
> the default I2C address but will not be able to reset the touch via
> software or place the device in sleep mode.

This sounds exactly like the problem I'm having with the One-Mix Yoga
2 I described a few days ago.

I applied your patch on top of https://github.com/hadess/gt9xx, built
the goodix_backport module and loaded it successfully. The touchscreen
continued to work fine. Unfortunately, after a suspend and wakeup the
results are the same as without the patch - the touchscreen is
unresponsive. Unloading and loading the module again does not help. No
error messages whatsoever in dmesg.

Andreas
