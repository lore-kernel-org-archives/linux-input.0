From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Thu, 26 Feb 2015 16:27:49 +0200
Message-ID: <2747724.u7aGnnSiv7@avalon>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdUwHde0EvbCD574L2tW6qqxLCtZwAb+0M-4QCjB9V6fmQ@mail.gmail.com> <20150126120947.GC1052@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150126120947.GC1052@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Wolfram,

On Monday 26 January 2015 13:09:47 Wolfram Sang wrote:
> > >> If you drop adi,adxl346, checkpatch will start complaining if it
> > >> encounters
> > >> it in a .dts.
> > > 
> > > Boah, this is annoying. That means we need an 346 entry even if it is
> > > not different from 345 (which is fine by me).
> > 
> > To be clear: you need the entry in the documentation. It can be omitted
> > from the driver if it's not (yet) used for matching.
> 
> Well, I don't really like that behaviour, but I don't like
> i2c/trivial-devices.txt as well, so I'll just apply the patch and live
> with it :)

What happened to this patch ?

-- 
Regards,

Laurent Pinchart

