From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Uhid lock issue
Date: Wed, 30 Mar 2016 11:31:50 -0700
Message-ID: <CAEc3jaCATKZ=LF-S9DAj3PO9g-3wOKR=7v3OeVE67RZyAxzZHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35544 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbcC3Sbv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Mar 2016 14:31:51 -0400
Received: by mail-pf0-f172.google.com with SMTP id n5so49099895pfn.2
        for <linux-input@vger.kernel.org>; Wed, 30 Mar 2016 11:31:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi David,

I'm debugging an issue related to uhid in combination with HID
drivers, which perform HID feature requests as part of a uhid
initiated HID request, which results in a deadlock situation. As the
maintainer of uhid I would like to ask on how to deal with this
situation.

The uhid driver has a lock 'devlock', which is held during read and
write operations to uhid. As an uhid_write holds this lock during for
example UHID_CREATE. During this operation a HID driver's '.probe' can
kick off. As part of .probe, it is common for a HID driver to do a
hid_hw_start, which results in uhid sending UHID_START, which
userspace can pick up after UHID_CREATE is complete, because a
uhid_read call can't complete due to the devlock, which is still held
by uhid_write. In general this is not really a problem I think.

Problems happen if for example the .probe call sends a feature report
to the device e.g. to obtain some device information. Such an
operation triggers a request to userspace through uhid, but userspace
can't pick it up, because the devlock is held. There is a temporary
deadlock until some long timeout.

In general this issue happens for any HID request by userspace, for
which the kernel driver triggers another HID request as part of
handling the original HID request from userspace. This is probably
somewhat rare and the situation during .probe is likely the most
common one.

I'm not entirely sure what the proper way of addressing this issue is.
The single devlock kept uhid simple, but I have a feeling it may need
to be made more granular or maybe there is another way. I don't know
the pitfalls you have seen with uhid over the years, so I'm wondering
if you have some ideas.

Thanks,
Roderick
