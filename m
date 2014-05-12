From: "Patni, Archana" <archana.patni@intel.com>
Subject: RE: [PATCH] HID: i2c-hid: hid report descriptor retrieval changes
Date: Mon, 12 May 2014 09:39:34 +0000
Message-ID: <C6E4BB9533783C4B9F391CD7AD09A49B45EB600D@BGSMSX104.gar.corp.intel.com>
References: <1399555579-10747-1-git-send-email-archana.patni@linux.intel.com>
 <CAN+gG=E7sU6rf0XR1_FkSqEejcSwNYqkLkpQBwSj7Xm53iTtRg@mail.gmail.com>
 <alpine.LNX.2.00.1405121056000.5813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55220 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754944AbaELJkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 05:40:04 -0400
In-Reply-To: <alpine.LNX.2.00.1405121056000.5813@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Archana Patni <archana.patni@linux.intel.com>, "jic23@kernel.org" <jic23@kernel.org>, linux-input <linux-input@vger.kernel.org>, "Westerberg, Mika" <mika.westerberg@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "Sesha, Subramony" <subramony.sesha@intel.com>



> -----Original Message-----
> From: Jiri Kosina [mailto:jkosina@suse.cz]
> Sent: Monday, May 12, 2014 2:27 PM
> To: Benjamin Tissoires
> Cc: Archana Patni; jic23@kernel.org; linux-input; Westerberg, Mika;
> Pandruvada, Srinivas; Patni, Archana; Sesha, Subramony
> Subject: Re: [PATCH] HID: i2c-hid: hid report descriptor retrieval changes
> 
> On Thu, 8 May 2014, Benjamin Tissoires wrote:
> 
> > > Reading the partial HID Descriptor is causing a firmware lockup in
> > > some sensor hubs. Instead of a partial read, this patch implements
> > > the i2c hid fetch using a fixed descriptor size (30 bytes) followed
> > > by a verification of the BCDVersion (V01.00), and value stored in
> > > wHIDDescLength (30 Bytes) for V1.00 descriptors.
> > >
> > > As per i2c hid spec, this is the preferred model.
> > >
> > > From hid-over-i2c-protocol-spec-v1-0:
> > >
> > >   There are a variety of ways a HOST may choose to retrieve
> > >   the HID Descriptor from the DEVICE. The following is a preferred
> > >   implementation but should not be considered the only implementation.
> > >   A HOST may read the entire HID Descriptor in a single read by
> > >   issuing a read for 30 Bytes to get the entire HID Descriptor
> > >   from the DEVICE.However, the HOST is responsible for validating
> > > that
> > >
> > >   1. The BCDVersion is V01.00 (later revisions may have different
> > >      descriptor lengths), and
> > >
> > >   2. The value stored in wHIDDescLength is 30 (Bytes) for V1.00
> > >      descriptors.
> > >
> > > Reported-by: Joe Tijerina <joe.tijerina@st.com>
> > > Signed-off-by: Archana Patni <archana.patni@intel.com>
> > > Signed-off-by: Subramony Sesha <subramony.sesha@intel.com>
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> >
> > This one is Reviewed-by: Benjamin Tissoires
> > <benjamin.tissoires@redhat.com>
> 
> Do we have any indication about how frequently are the lockups actually
> happening in the wild? Is this a regression? (I don't think so).
For a few devices, this behavior always occurs. This is not a regression.

> 
> The reason I am asking is whether I should rush this in for 3.15 still, but as the
> patch doesn't have stable annotation anyway, my understanding is that 3.16
> is enough?
3.16 is fine.

Thanks
Archana
> 
> Thanks,
> 
> --
> Jiri Kosina
> SUSE Labs
