From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RESEND] Lenovo Yoga 900 touchpad issues
Date: Wed, 16 Dec 2015 11:28:58 +0200
Message-ID: <20151216092858.GP1762@lahna.fi.intel.com>
References: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56952 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbbLPJ3E (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 04:29:04 -0500
Content-Disposition: inline
In-Reply-To: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Dec 15, 2015 at 11:14:32AM -0800, Nish Aravamudan wrote:
> [Apologies for the resend, didn't realize I hadn't changed my GMail settings
> to not use HTML.]
> 
> I have recently purchased a Lenovo Yoga 900 and most everything is working
> with a slightly modified 4.4-rc5 (https://lkml.org/lkml/2015/11/30/441 applied
> to enable the touchpad itself), I am seeing two issues:
> 
> 1) On suspend/resume, the touchpad is non-functional. A `modprobe -r i2c-hid;
>  modprobe i2c-hid` "fixes" it.
> 
> The kernel emits:
> 
> i2c_hid i2c-SYNA2B29:00: failed to reset device.
> dpm_run_callback(): i2c_hid_resume+0x0/0xc0 [i2c_hid] returns -61
> PM: Device i2c-SYNA2B29:00 failed to resume: error -61
> 
> During the resume. So perhaps this is a timing issue (given that once
> resumed, the
> module reload does work?).

Linus noticed this as well and Jiri suggested the below patch which
seemed to fix the issue (although it increased resume time a bit).

I was supposed to get one Lenovo Yoga 900 here to debug this issue but
I'm still waiting for it (sloow big corporation bureaucracy takes some
time to get things purchased outside).

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 55d8f9d..52dd03a0 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1121,10 +1121,16 @@ static int i2c_hid_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
-	int wake_status;
+	int wake_status, tries = 3;
 
 	enable_irq(ihid->irq);
-	ret = i2c_hid_hwreset(client);
+
+	do {
+		ret = i2c_hid_hwreset(client);
+		if (ret)
+			msleep(1000);
+	} while (tries-- > 0 && ret);
+
 	if (ret)
 		return ret;
