From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] HID: multitouch: Fetch feature reports on demand for
 Win8 devices
Date: Wed, 30 Sep 2015 11:45:57 +0300
Message-ID: <20150930084557.GE1551@lahna.fi.intel.com>
References: <1443451630-144023-1-git-send-email-mika.westerberg@linux.intel.com>
 <20150929090431.GA30386@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150929090431.GA30386@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Sep 29, 2015 at 05:04:31AM -0400, Benjamin Tissoires wrote:
> > +static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
> > +{
> > +	int ret, size = hid_report_len(report);
> > +	u8 *buf;
> > +
> > +	/*
> > +	 * Only fetch the feature report if initial reports are not already
> > +	 * been retrieved. Currently this is only done for Windows 8 touch
> > +	 * devices.
> > +	 */
> > +	if (!(hdev->quirks & HID_QUIRK_NO_INIT_REPORTS))
> > +		return;
> 
> Some Win 7 panels have this quirk set too because they do not support
> either querying random feature or input reports.
> 
> I think this test is safe given that this is, I think, what the Windows
> driver does (I remember that it queries for the features it needs).
> However I am not 100% sure if this will not break one low quality
> touchscreen.
> 
> I would be in favor of applying the patch in its current shape, but if
> Jiri thinks we need a little bit more caution here, we would need to add
> a test regarding the Win8 capability here.

What about adding following on top of this patch? It checks the device
in question belongs to "win8 class".

I can send a new version of the patch if this seems reasonable.

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index d9ca2b96ab68..72c55a3f650f 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -311,6 +311,7 @@ static struct attribute_group mt_attribute_group = {
 
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
+	struct mt_device *td = hid_get_drvdata(hdev);
 	int ret, size = hid_report_len(report);
 	u8 *buf;
 
@@ -319,7 +320,8 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 	 * been retrieved. Currently this is only done for Windows 8 touch
 	 * devices.
 	 */
-	if (!(hdev->quirks & HID_QUIRK_NO_INIT_REPORTS))
+	if (!(hdev->quirks & HID_QUIRK_NO_INIT_REPORTS) ||
+	    td->mtclass.name != MT_CLS_WIN_8)
 		return;
 
 	buf = hid_alloc_report_buf(report, GFP_KERNEL);
