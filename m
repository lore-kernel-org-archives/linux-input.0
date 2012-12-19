From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] Input: Add ChromeOS EC keyboard driver
Date: Wed, 19 Dec 2012 10:16:43 -0800
Message-ID: <20121219181643.GA31435@core.coreip.homeip.net>
References: <1355348028-19017-1-git-send-email-sjg@chromium.org>
 <1355348028-19017-6-git-send-email-sjg@chromium.org>
 <20121215011345.9D5973E0BEE@localhost>
 <2990462.l5jY89jKQx@dtor-d630.eng.vmware.com>
 <20121219125722.DCD3E3E0AD7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121219125722.DCD3E3E0AD7@localhost>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Luigi Semenzato <semenzato-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 19, 2012 at 12:57:22PM +0000, Grant Likely wrote:
> On Fri, 14 Dec 2012 17:43:31 -0800, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Saturday, December 15, 2012 01:13:45 AM Grant Likely wrote:
> > > On Wed, 12 Dec 2012 13:33:48 -0800, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> > > > Use the key-matrix layer to interpret key scan information from the EC
> > > > and inject input based on the FDT-supplied key map. This driver registers
> > > > itself with the ChromeOS EC driver to perform communications.
> > > > 
> > > > Additional FDT bindings are provided to specify rows/columns and the
> > > > auto-repeat information.
> > > > 
> > > > Signed-off-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > Signed-off-by: Luigi Semenzato <semenzato-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > Signed-off-by: Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/input/cros-ec-keyb.txt     |   77 ++++
> > > >  drivers/input/keyboard/Kconfig                     |   10 +
> > > >  drivers/input/keyboard/Makefile                    |    1 +
> > > >  drivers/input/keyboard/cros_ec_keyb.c              |  413
> > > >  ++++++++++++++++++++ 4 files changed, 501 insertions(+), 0 deletions(-)
> > > >  create mode 100644
> > > >  Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> > > >  create mode 100644 drivers/input/keyboard/cros_ec_keyb.c
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> > > > b/Documentation/devicetree/bindings/input/cros-ec-keyb.txt new file mode
> > > > 100644
> > > > index 0000000..67f51d8
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> > > > @@ -0,0 +1,77 @@
> > > > +ChromeOS EC Keyboard
> > > > +
> > > > +Google's ChromeOS EC Keyboard is a simple matrix keyboard implemented on
> > > > +a separate EC (Embedded Controller) device. It provides a message for
> > > > reading +key scans from the EC. These are then converted into keycodes
> > > > for processing +by the kernel.
> > > > +
> > > > +Required properties:
> > > > +- compatible: "google,cros-ec-keyb"
> > > > +- google,key-rows: Number of keyboard rows (must be <= 8)
> > > > +- google,key-columns: Number of keyboard columns (must be <= 13)
> > > > +- google,repeat-delay-ms: Key repeat delay in milliseconds
> > > > +- google,repeat-rate-ms: Key repeat rate in milliseconds
> > > 
> > > Hmmm, these should probably be in a common binding. Take a look at
> > > the other input bindings and make a proposal for properties to add to
> > > matrix-keymap.txt.
> > 
> > Actually these are not essentia for bringup and can be set from userspace,
> > so I'd say simply drop them.
> 
> Aren't they needed for a working keyboard? If so, I would really think
> they should be set correctly without userspace intervention.

I am sorry if I was unclear, but I was actually talking about the last
2: repeat-delay-ms and repeat-rate-ms. Input core has I believe sane
defaults (250 msec delay, 33 cps autorepeat) and user can adjust if
other rate is preferred.

Thanks.

-- 
Dmitry
