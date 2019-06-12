From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 2/3] HID: quirks: Refactor ELAN 400 and 401 handling
Date: Wed, 12 Jun 2019 15:37:15 +0100
Message-ID: <20190612143715.GC4660@dell>
References: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
 <20190606161322.47192-1-jeffrey.l.hugo@gmail.com>
 <20190612003507.GG143729@dtor-ws>
 <2282f3e1-e76a-4fe7-d447-51d9a4bee2de@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2282f3e1-e76a-4fe7-d447-51d9a4bee2de@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, benjamin.tissoires@redhat.com, jikos@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 12 Jun 2019, Jeffrey Hugo wrote:

> On 6/11/2019 6:35 PM, Dmitry Torokhov wrote:
> > On Thu, Jun 06, 2019 at 09:13:22AM -0700, Jeffrey Hugo wrote:
> > > There needs to be coordination between hid-quirks and the elan_i2c driver
> > > about which devices are handled by what drivers.  Currently, both use
> > > whitelists, which results in valid devices being unhandled by default,
> > > when they should not be rejected by hid-quirks.  This is quickly becoming
> > > an issue.
> > > 
> > > Since elan_i2c has a maintained whitelist of what devices it will handle,
> > > use that to implement a blacklist in hid-quirks so that only the devices
> > > that need to be handled by elan_i2c get rejected by hid-quirks, and
> > > everything else is handled by default.  The downside is the whitelist and
> > > blacklist need to be kept in sync.
> > > 
> > > Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > > ---
> > >   drivers/hid/hid-quirks.c | 78 ++++++++++++++++++++++++++++++++++------
> > >   1 file changed, 67 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > > index e5ca6fe2ca57..edebd0700e3d 100644
> > > --- a/drivers/hid/hid-quirks.c
> > > +++ b/drivers/hid/hid-quirks.c
> > > @@ -912,8 +912,66 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
> > >   	{ }
> > >   };
> > > +/*
> > > + * List of device names that elan_i2c is handling and HID should ignore.  Must
> > > + * be kept in sync with elan_i2c
> > > + */
> > > +static const char *hid_elan_i2c_ignore[] = {
> > 
> > If this is a copy of elan whitelist, then, if we do not want to bother
> > with sharing it in object form (as a elan-i2c-ids module), can we at
> > least move it into include/linux/input/elan-i2c-ids.h and consume from
> > hid-quirks.c?
> 
> I can put it in a shared header file, however elan-i2c and hid-quirks
> would need to be updated in the same change to prevent a breakage, but
> that would seem to violate a concern Benjamin brought up in v4 given
> that elan-i2c is maintained in your input tree, and hid-quirks is
> maintained in his hid tree.
> 
> Are you ok with the elan-i2c changes going through Benjamin's hid tree?

We co-ordinate cross-subsystem merges all the time.  That is never a
reason to not do the 'right thing (tm)'.  If this information can be
held in a single, central place, without the need for constant
re-alignment, I'm all for it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
