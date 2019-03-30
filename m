From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] HID: intel-ish-hid: ISH firmware loader client driver
Date: Sat, 30 Mar 2019 09:27:32 -0700
Message-ID: <e2d8ab93c97acf1254830e6f51edb8f19c8767d6.camel@perches.com>
References: <1553889813-17677-1-git-send-email-rushikesh.s.kadam@intel.com>
         <CAHX4x85jFVYhOpRCKfvhYEqhXFwpKaK3_5gEit1EMaXY3L4Z4g@mail.gmail.com>
         <20190330102230.GB19202@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330102230.GB19202@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>, Nick Crews <ncrews@chromium.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, benjamin.tissoires@redhat.com, jikos@kernel.org, jettrink@chromium.org, Gwendal Grignou <gwendal@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2019-03-30 at 15:52 +0530, Rushikesh S Kadam wrote:
> On Fri, Mar 29, 2019 at 04:30:18PM -0700, Nick Crews wrote:
> > On Fri, Mar 29, 2019 at 1:03 PM Rushikesh S Kadam
> > <rushikesh.s.kadam@intel.com> wrote:
> > > +       ldr_xfer_ipc_frag = kzalloc(LOADER_SHIM_IPC_BUF_SIZE, GFP_KERNEL);
> > > +       if (!ldr_xfer_ipc_frag) {
> > Log error here.
> The error code is logged in calling function
> load_fw_from_host(). Is that good enough?
> 
> I believe the checkpatch script too, would
> recommend against adding debug print for ENOMEM
> error.

The generic kernel allocation functions already do
a dump_stack() on OOM conditions when called without
__GFP_NOWARN so any additional OOM message isn't
particularly useful.

> Again, I thought it was against practise to log
> "out of memory" debug prints in probe()

Or anywhere else given the generic OOM stack dump.

> But will add if you tell me this is the right way.
> 
> > > +               return -ENOMEM;
> > > +
> > > +       loader_ishtp_cl = ishtp_cl_allocate(cl_device);
> > > +       if (!loader_ishtp_cl)
> > 
> > log error here

The ishtp_cl_allocate function just calls kmalloc then
initializes the struct so an additional OOM message
isn't useful here either.
