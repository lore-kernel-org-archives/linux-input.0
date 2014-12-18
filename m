From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 18 Dec 2014 21:23:46 +0200
Message-ID: <10011053.aypz0IuTJG@avalon>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1492007.8cQN1myWLD@avalon> <CAMuHMdXcfe0JQhZzGSAoqjKR346-QJrvyi=afHF7cAaHKa56pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXcfe0JQhZzGSAoqjKR346-QJrvyi=afHF7cAaHKa56pw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Geert,

On Thursday 18 December 2014 14:03:18 Geert Uytterhoeven wrote:
> On Thu, Dec 18, 2014 at 1:49 PM, Laurent Pinchart wrote:
> > There are three compatible strings defined for the ADXL345 and ADXL346 in
> > Documentation/devicetree/bindings/i2c/trivial-devices.txt: "adi,adxl345",
> > "adi,adxl346", "adi,adxl34x". Given that the last one is a fallback for
> > the first two I don't see a need to add the specific compatible strings to
> > the driver for now. If a new totally incompatible chip named ADXL347 comes
> > out we will need a new driver which won't be allowed to use the
> > "adi,adxl34x" compatible string.
> 
> FWIW, I'm the evil person who added the adxl entries to that file...

git-blame had already reported you.

Do you think we should remove that compatible string ?

-- 
Regards,

Laurent Pinchart
