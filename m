From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: core: clean up indentation issue
Date: Fri, 27 Sep 2019 12:04:04 +0200
Message-ID: <CAO-hwJKpqGBi+9CRn08sNcn+ggQtnefuMgG98bXtW1UiGqneQA@mail.gmail.com>
References: <20190922115054.10880-1-colin.king@canonical.com>
 <nycvar.YFH.7.76.1909231303180.1459@cbobk.fhfr.pm> <20190925114741.GD27389@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190925114741.GD27389@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jiri Kosina <jikos@kernel.org>, Colin King <colin.king@canonical.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 25, 2019 at 1:48 PM Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>
> On Mon, Sep 23, 2019 at 01:04:13PM +0200, Jiri Kosina wrote:
> > On Sun, 22 Sep 2019, Colin King wrote:
> >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > There is an if statement that is indented by one extra space,
> > > fix this by removing the extraneous space.
> > >
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/hid/hid-core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 3eaee2c37931..9469c382a182 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -2329,10 +2329,10 @@ int hid_add_device(struct hid_device *hdev)
> > >     /*
> > >      * Check for the mandatory transport channel.
> > >      */
> > > -    if (!hdev->ll_driver->raw_request) {
> > > +   if (!hdev->ll_driver->raw_request) {
> > >             hid_err(hdev, "transport driver missing .raw_request()\n"=
);
> > >             return -EINVAL;
> > > -    }
> > > +   }
> >
> > Let's not pollute git blame and wait for an ocasion when we need to tou=
ch
> > the code for some more valid reason.
>
> Just use `git blame -w`.
>
> This probably came from a Smatch warning.  Smatch warns very seldom
> warns about style issues, but in this case the indenting is legitimately
> bad.

Well, I tend to agree with Jiri here. Yes, you can use a particular
flag in a tool to 'solve' the git blame/history issue, but this is
putting the workload on the user, while tthe code is fine, in this
case. Why do we need to pollute the history of a file for no good
reasons?

Cheers,
Benjamin
