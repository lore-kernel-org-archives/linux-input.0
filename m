From: Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH v3] HID: intel-ish-hid: ISH firmware loader client driver
Date: Mon, 1 Apr 2019 15:17:13 -0600
Message-ID: <CAHX4x85=Sot62T=DtGPLkyFhudyp=jvxcU_W-oShg8iKTach+Q@mail.gmail.com>
References: <1553889813-17677-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CAHX4x85jFVYhOpRCKfvhYEqhXFwpKaK3_5gEit1EMaXY3L4Z4g@mail.gmail.com>
 <20190330102230.GB19202@intel.com> <e2d8ab93c97acf1254830e6f51edb8f19c8767d6.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e2d8ab93c97acf1254830e6f51edb8f19c8767d6.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, benjamin.tissoires@redhat.com, jikos@kernel.org, jettrink@chromium.org, Gwendal Grignou <gwendal@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

I tried to send the last message from my phone, and surprise it wasn't
formatted correctly, so it may have been marked as spam. repeating
myself again...

Ah, I guess I was wrong about logging OOM. I hadn=E2=80=99t hear about the
recommendations against it, but they make sense. Thanks for the
clarifications!

On Sat, Mar 30, 2019 at 10:27 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2019-03-30 at 15:52 +0530, Rushikesh S Kadam wrote:
> > On Fri, Mar 29, 2019 at 04:30:18PM -0700, Nick Crews wrote:
> > > On Fri, Mar 29, 2019 at 1:03 PM Rushikesh S Kadam
> > > <rushikesh.s.kadam@intel.com> wrote:
> > > > +       ldr_xfer_ipc_frag =3D kzalloc(LOADER_SHIM_IPC_BUF_SIZE, GFP=
_KERNEL);
> > > > +       if (!ldr_xfer_ipc_frag) {
> > > Log error here.
> > The error code is logged in calling function
> > load_fw_from_host(). Is that good enough?
> >
> > I believe the checkpatch script too, would
> > recommend against adding debug print for ENOMEM
> > error.
>
> The generic kernel allocation functions already do
> a dump_stack() on OOM conditions when called without
> __GFP_NOWARN so any additional OOM message isn't
> particularly useful.
>
> > Again, I thought it was against practise to log
> > "out of memory" debug prints in probe()
>
> Or anywhere else given the generic OOM stack dump.
>
> > But will add if you tell me this is the right way.
> >
> > > > +               return -ENOMEM;
> > > > +
> > > > +       loader_ishtp_cl =3D ishtp_cl_allocate(cl_device);
> > > > +       if (!loader_ishtp_cl)
> > >
> > > log error here
>
> The ishtp_cl_allocate function just calls kmalloc then
> initializes the struct so an additional OOM message
> isn't useful here either.
>
>
