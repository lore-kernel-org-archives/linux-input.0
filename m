From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V2 1/2] input: misc: da9063: OnKey driver
Date: Fri, 24 Apr 2015 13:36:22 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B21756B@SW-EX-MBX02.diasemi.com>
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

On 17 April 2015 17:16 Dmitry Torokhov wrote

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

Hi Dmitry 

Well, the two chips DA9063 and DA9062 are very different even though their
numbers are sequentially 62 and 63. They are different chips and not a simple
variation. However the OnKey components to these chips *are* functionally
similar which is why I am using the same code.  In this case the 62 OnKey driver
works the same way as 63 OnKey driver. 

Has the combined approach been done before? Are there any examples of this
that you would like me to follow?

I guess I'll drop the OnKey patch for 62 and just concentrate on your comments for
63 instead. After 63 is in a good state then I will work at getting 62 to use a combined
driver.

Regards,
Steve
