From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 00/20] cleanup atmel_mxt_ts
Date: Tue, 20 Mar 2012 07:33:02 -0700
Message-ID: <4F68951E.2020601@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Bowens, Alan" <Alan.Bowens@atmel.com>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>
List-Id: linux-input@vger.kernel.org

Daniel Kurtz wrote:
> This patchset cleans up the atmel_mxt_ts touchscreen driver.
> In particular, it addresses the following issues:

Hi Daniel-

Thanks for your work on this, some of it looks very useful. I will go
through and review each patch in turn.

I have been working on Atmel's version of this driver. You can find most of
that work on our github site: as you know we are intending to push it
upstream as much as possible:
https://github.com/atmel-maxtouch

The main overlap between your changes and ours is in your approach to
writing config from userspace. There is a lot of complexity in these chips
and providing a sysfs node for each function would end up being a
never-ending task.

So we have implemented an interface using a sysfs binary attribute which I
think is considerably more general and flexible than the interface that you
suggest. You can find a set of utilities on the same github that uses our
interface. I would argue that we should try and converge the mainline
driver on our approach rather than inventing something new unless there are
significant advantages.

cheers

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
