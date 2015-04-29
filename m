From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V2 1/2] input: misc: da9063: OnKey driver
Date: Wed, 29 Apr 2015 16:00:20 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B217B43@SW-EX-MBX02.diasemi.com>
References: <cover.1429272200.git.stwiss.opensource@diasemi.com>
 <b9068c6e41a08b620c9e1674e17e508ab0d76d55.1429272200.git.stwiss.opensource@diasemi.com>
 <20150417161555.GB27440@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150417161555.GB27440@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On 17 April 2015 17:16 Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] wrote:

> On Fri, Apr 17, 2015 at 01:03:20PM +0100, S Twiss wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> > Add OnKey driver support for DA9063
> >
> 
> Isn't this almost to the letter identical to da9062 that I just looked
> at? Please find a way to not make a brand new driver for the slightest
> variation of the chip...
> 
> Thanks.
> 

Hi Dmitry,

Yes it is functionally identical. I would like to drop the DA9062 component from
my other submission attempt and concentrate on this DA9063 OnKey driver
instead.

I have applied the review comments that you made on the DA9062 to this
DA9063 driver (since they are the same). Please find the review comments listed
in the thread here: https://patchwork.ozlabs.org/patch/462107/

The next patch set for the DA9063 will follow shortly.

Regards,
Steve
