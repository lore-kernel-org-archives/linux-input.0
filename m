From: Oliver Neukum <oneukum@suse.de>
Subject: Re: USB keyboard occasional key stuck
Date: Tue, 25 Feb 2014 14:51:25 +0100
Message-ID: <1393336285.3114.8.camel@linux-fkkt.site>
References: <CAMVG2ss9nA4zcOT3c47EwEMrR7Z_gAQU-HTYGjdWcdYzihSnbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMVG2ss9nA4zcOT3c47EwEMrR7Z_gAQU-HTYGjdWcdYzihSnbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel J Blueman <daniel@quora.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, 2014-02-17 at 21:23 +0800, Daniel J Blueman wrote:
> Across 5+ years of kernels, I've been seeing occasional (1-2 times per
> day) key-stuck issues where eg a fn+delete combo repeats delete until
> I press delete again. I've seen this happen with fn+ctrl+left, leaving
> left held and likewise with right.

I saw something like this during the development of runtime PM
for HID. It turns out that keyboards don't assert remote wakeup
upon key release.

Just to rule this out can you deactivate runtime PM and recompile
to switch of LPM?

	Regards
		Oliver
