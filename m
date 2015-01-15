From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 2/2] input: adxl34x: Add OF match support
Date: Fri, 16 Jan 2015 01:05:13 +0300
Message-ID: <54B83999.30407@cogentembedded.com>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20150115185431.GG33214@dtor-ws> <CAMuHMdXrRtgAahaEUh8x61E-koE25VL-6LOJrkjx4_fohKQtwQ@mail.gmail.com> <6357346.RjFSG892rq@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <6357346.RjFSG892rq@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-input@vger.kernel.org

Hello.

On 01/15/2015 11:34 PM, Laurent Pinchart wrote:

>>> I still do not understand what we are trying to fix here. Why is
>>> "adi,adxl34x" compatible string no good anymore? If we start using exact
>>> models and the physical device does not match do we abort probe? What is
>>> the problem that we are solving here?

>> Because there's no guarantee that the driver actually supports all
>> "adi,adxl34<x>" with <x> = 0..9, some of which don't exist yet.

> That's one of the reasons. Another one is that the adxl34x driver won't match
> DT nodes that list the "adi,adxl34x" compatible value in positions other than
> the first.

    Let's also not forget that wildcards in the "compatible" prop are not 
really allowed.

WBR, Sergei

