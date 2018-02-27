From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH v3] input: bcm5974 - Add driver for Apple Magic Trackpad 2
Date: Tue, 27 Feb 2018 17:37:45 +0100
Message-ID: <1566223.3I8hjEaRec@tauon.chronox.de>
References: <40764439.8xGR6LbaWR@positron.chronox.de> <2305311.UGlXl2onVb@positron.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2305311.UGlXl2onVb@positron.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, marek.wyborski@emwesoft.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Sonntag, 21. Januar 2018, 23:06:55 CET schrieb Stephan Müller:

Hi Jiri, Dimity, Henrik,

> Hi,
> 
> Changes v3:
> * port to 4.15-rc8
> * small code cleanups (isolation of type casts to functions pertaining
>   to the Apple Magic Trackpad 2
> * clean up all checkpatch.pl errors and warnings (except those
>   where the patch uses the structure of existing code fragments)
> * updated horizontal and vertical limits to capture start of movements
>   in the outer areas of the pad
> 
> ---8<---
> 
> Add support for Apple Magic Trackpad 2 in bcm5974 (MacBook Tochpad) driver.
> The Magic Trackpad 2 needs to be switched into the finger-reporting-mode,
> just like the other macbook touchpads as well. But the format is different
> to the ones before. The Header is 12 Bytes long and each reported finger
> is additional 9 Bytes. The data order reported by the hardware is
> different as well.

May I ask whether there is an issue in the patch? I have not received any 
feedback and would like to inquire about the status of the patch.

I would like to have Touchpad 2 properly supported.

Thanks a lot
Stephan
