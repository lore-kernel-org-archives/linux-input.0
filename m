From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 2/2] Input: rotaty-encoder - Add DT binding document
Date: Tue, 15 Jan 2019 14:29:48 -0600
Message-ID: <20190115202948.GA26482@bogus>
References: <20190107164249.2342-1-nazgul33@gmail.com>
 <20190107164249.2342-3-nazgul33@gmail.com>
 <20190115035221.GA151157@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115035221.GA151157@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Donghoon Han <nazgul33@gmail.com>, linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 14, 2019 at 07:52:21PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 08, 2019 at 01:42:49AM +0900, Donghoon Han wrote:
> > Add DT binding document for rotary-encoder, keycode options.
> > 
> > Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Daniel Mack <daniel@caiaq.de>
> > Cc: devicetree@vger.kernel.org
> > To: linux-input@vger.kernel.org
> > ---
> >  .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > index f99fe5cdeaec..9986ec2af2d4 100644
> > --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > @@ -12,6 +12,10 @@ Optional properties:
> >  - rotary-encoder,relative-axis: register a relative axis rather than an
> >    absolute one. Relative axis will only generate +1/-1 events on the input
> >    device, hence no steps need to be passed.
> > +- rotary-encoder,relative-keys : generate pair of key events. This setting
> > +  behaves just like relative-axis, generating key events instead.
> > +  (Keycodes[2] corresponds to -1/1 events.)
> > +- rotary-encoder,relative-keycodes : keycodes for relative-keys
> 
> Given that keycodes are linux-specific, I think the property should be
> linux,keycodes. Also, I am not sure we need separate
> rotary-encoder,relative-keys property as we can infer that we want to
> generate keys from presence of linux,keycodes property.
> 
> Rob, any comments?

Yes, I had similar thoughts.
