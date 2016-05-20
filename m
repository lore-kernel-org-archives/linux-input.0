From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2 V3] dt: add Atmel Captouch bindings
Date: Fri, 20 May 2016 09:16:03 -0700
Message-ID: <20160520161603.GA14951@dtor-ws>
References: <1463432094-146726-1-git-send-email-grundler@chromium.org>
 <20160518164404.GA31862@rob-hp-laptop>
 <20160518215914.GA4081@dtor-ws>
 <CAL_Jsq+zBQ-Z3eEouQHxSiH9jxbTMYuGUurnXwiAoXijgC3MfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+zBQ-Z3eEouQHxSiH9jxbTMYuGUurnXwiAoXijgC3MfA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Grant Grundler <grundler@chromium.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hung-yu Wu <hywu@google.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-input@vger.kernel.org

On Fri, May 20, 2016 at 07:56:51AM -0500, Rob Herring wrote:
> On Wed, May 18, 2016 at 4:59 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, May 18, 2016 at 11:44:04AM -0500, Rob Herring wrote:
> >> On Mon, May 16, 2016 at 01:54:53PM -0700, Grant Grundler wrote:
> >> > From: Daniel Hung-yu Wu <hywu@google.com>
> >> >
> >> > Add binding for Atmel Capacitive Touch Button device.
> >> >
> >> > Signed-off-by: Daniel Hung-yu Wu <hywu@google.com>
> >> > Signed-off-by: Grant Grundler <grundler@chromium.org>
> >> > ---
> >> >  .../devicetree/bindings/input/atmel,captouch.txt   | 36 ++++++++++++++++++++++
> >> >  1 file changed, 34 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.txt
> >>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >
> > Folded into the driver patch and applied.
> 
> Folded why? Please don't do that. You should be committing what is
> posted as is for the most part. We specifically ask that binding
> changes are kept separate commits. It also messes up the ability to

I know that you ask for binding docs to be posted separately (I guess
so that devicetree list is not overrun with driver code mails), but
logically driver patch and binding doc patch are a single change and
should be committed together, so that when I am researching the history
I can easily see what was introduced and when. You do not require header
changes to be submitted separately form .c files, do you?

> correlate git commits to patchworks or mail searches.

The fact that it was applied can be found in mail archives.

Thanks.

-- 
Dmitry
