From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: hid report descriptor retrieval changes
Date: Thu, 8 May 2014 10:16:10 -0400
Message-ID: <CAN+gG=E7sU6rf0XR1_FkSqEejcSwNYqkLkpQBwSj7Xm53iTtRg@mail.gmail.com>
References: <1399555579-10747-1-git-send-email-archana.patni@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:46076 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbaEHOQM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 10:16:12 -0400
Received: by mail-lb0-f178.google.com with SMTP id w7so3578597lbi.23
        for <linux-input@vger.kernel.org>; Thu, 08 May 2014 07:16:11 -0700 (PDT)
In-Reply-To: <1399555579-10747-1-git-send-email-archana.patni@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Archana Patni <archana.patni@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, jic23@kernel.org, linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, Archana Patni <archana.patni@intel.com>, Subramony Sesha <subramony.sesha@intel.com>

On Thu, May 8, 2014 at 9:26 AM, Archana Patni
<archana.patni@linux.intel.com> wrote:
> Reading the partial HID Descriptor is causing a firmware lockup in some
> sensor hubs. Instead of a partial read, this patch implements the
> i2c hid fetch using a fixed descriptor size (30 bytes) followed by a
> verification of the BCDVersion (V01.00), and value stored in
> wHIDDescLength (30 Bytes) for V1.00 descriptors.
>
> As per i2c hid spec, this is the preferred model.
>
> From hid-over-i2c-protocol-spec-v1-0:
>
>   There are a variety of ways a HOST may choose to retrieve
>   the HID Descriptor from the DEVICE. The following is a preferred
>   implementation but should not be considered the only implementation.
>   A HOST may read the entire HID Descriptor in a single read by
>   issuing a read for 30 Bytes to get the entire HID Descriptor
>   from the DEVICE.However, the HOST is responsible for validating that
>
>   1. The BCDVersion is V01.00 (later revisions may have different
>      descriptor lengths), and
>
>   2. The value stored in wHIDDescLength is 30 (Bytes) for V1.00
>      descriptors.
>
> Reported-by: Joe Tijerina <joe.tijerina@st.com>
> Signed-off-by: Archana Patni <archana.patni@intel.com>
> Signed-off-by: Subramony Sesha <subramony.sesha@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

This one is Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
