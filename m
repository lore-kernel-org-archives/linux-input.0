From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Report DS4 version info through sysfs
Date: Tue, 23 Jan 2018 15:39:11 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801231539030.11852@cbobk.fhfr.pm>
References: <20171219190443.52950-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbeAWOjO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 09:39:14 -0500
In-Reply-To: <20171219190443.52950-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Tue, 19 Dec 2017, Roderick Colenbrander wrote:

> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Report DS4 firmware and hardware version through sysfs for both
> USB and Bluetooth. This information is important for userspace
> in particular for device specific quirks (e.g. in Bluetooth stacks).
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

