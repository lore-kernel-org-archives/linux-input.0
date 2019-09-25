From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] HID: core: clean up indentation issue
Date: Wed, 25 Sep 2019 14:47:41 +0300
Message-ID: <20190925114741.GD27389@kadam>
References: <20190922115054.10880-1-colin.king@canonical.com>
 <nycvar.YFH.7.76.1909231303180.1459@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1909231303180.1459@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Colin King <colin.king@canonical.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 23, 2019 at 01:04:13PM +0200, Jiri Kosina wrote:
> On Sun, 22 Sep 2019, Colin King wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is an if statement that is indented by one extra space,
> > fix this by removing the extraneous space.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/hid/hid-core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 3eaee2c37931..9469c382a182 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2329,10 +2329,10 @@ int hid_add_device(struct hid_device *hdev)
> >  	/*
> >  	 * Check for the mandatory transport channel.
> >  	 */
> > -	 if (!hdev->ll_driver->raw_request) {
> > +	if (!hdev->ll_driver->raw_request) {
> >  		hid_err(hdev, "transport driver missing .raw_request()\n");
> >  		return -EINVAL;
> > -	 }
> > +	}
> 
> Let's not pollute git blame and wait for an ocasion when we need to touch 
> the code for some more valid reason.

Just use `git blame -w`.

This probably came from a Smatch warning.  Smatch warns very seldom
warns about style issues, but in this case the indenting is legitimately
bad.

regards,
dan carpenter
