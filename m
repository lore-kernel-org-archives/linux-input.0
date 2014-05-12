From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: i2c-hid: hid report descriptor retrieval changes
Date: Mon, 12 May 2014 10:57:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405121056000.5813@pobox.suse.cz>
References: <1399555579-10747-1-git-send-email-archana.patni@linux.intel.com> <CAN+gG=E7sU6rf0XR1_FkSqEejcSwNYqkLkpQBwSj7Xm53iTtRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52026 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbaELI53 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 04:57:29 -0400
In-Reply-To: <CAN+gG=E7sU6rf0XR1_FkSqEejcSwNYqkLkpQBwSj7Xm53iTtRg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Archana Patni <archana.patni@linux.intel.com>, jic23@kernel.org, linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, Archana Patni <archana.patni@intel.com>, Subramony Sesha <subramony.sesha@intel.com>

On Thu, 8 May 2014, Benjamin Tissoires wrote:

> > Reading the partial HID Descriptor is causing a firmware lockup in some
> > sensor hubs. Instead of a partial read, this patch implements the
> > i2c hid fetch using a fixed descriptor size (30 bytes) followed by a
> > verification of the BCDVersion (V01.00), and value stored in
> > wHIDDescLength (30 Bytes) for V1.00 descriptors.
> >
> > As per i2c hid spec, this is the preferred model.
> >
> > From hid-over-i2c-protocol-spec-v1-0:
> >
> >   There are a variety of ways a HOST may choose to retrieve
> >   the HID Descriptor from the DEVICE. The following is a preferred
> >   implementation but should not be considered the only implementation.
> >   A HOST may read the entire HID Descriptor in a single read by
> >   issuing a read for 30 Bytes to get the entire HID Descriptor
> >   from the DEVICE.However, the HOST is responsible for validating that
> >
> >   1. The BCDVersion is V01.00 (later revisions may have different
> >      descriptor lengths), and
> >
> >   2. The value stored in wHIDDescLength is 30 (Bytes) for V1.00
> >      descriptors.
> >
> > Reported-by: Joe Tijerina <joe.tijerina@st.com>
> > Signed-off-by: Archana Patni <archana.patni@intel.com>
> > Signed-off-by: Subramony Sesha <subramony.sesha@intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> 
> This one is Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Do we have any indication about how frequently are the lockups actually 
happening in the wild? Is this a regression? (I don't think so).

The reason I am asking is whether I should rush this in for 3.15 still, 
but as the patch doesn't have stable annotation anyway, my understanding 
is that 3.16 is enough?

Thanks,

-- 
Jiri Kosina
SUSE Labs
