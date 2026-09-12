Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588430DEBA
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222080; cv=none; b=sNdFFfU+gG7rGPbWcHtVYL5GGZbgSy5IhKUQ0h1ictJ+Ys/xWoj/qvjKZLPAhfFvuSQTd9Edy/am7fVZMK7vslEUnqVQrXKQIq0cqYOdQB1wcfBOenfEALzHKx8k7ioCD4lrgoKAlshsBs2aRWCFvu0xzBkrg8NyNebZopDFlc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222080; c=relaxed/simple;
	bh=N5pN1DI1Bpg+NRDQIZl0zY7ixBv/obs7rvlGbXuLJdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOt3wD3cuvTFlL3iHofT9wcvO7vlw7ANIaaihXgIQcBczkEbER98B8dqPFsx6t2XCMTa5x9NhLF7Z/EGWQPa6uf0Lrc1Dbs9C4xLeDp96XFeqscrsg5GR0osOD9+JG2lwzEEmE9/62+3x7wBH5JpAL/7DJ9wwq/EAkIhwdoibXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oypVNYaZ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oypVNYaZ"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a0fd41a7bso14518385a.1
        for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789222078; x=1789826878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UTCfdkP73gLXJ25CwDT//d6Us1e6esblg46ABiyVDOM=;
        b=oypVNYaZ10+Ns2AR1h2Lf7Itf/Qa9WLDzZiaunwOwzVAXsGbvZQgoPNjCL8tjM23Xc
         4bDl/LniBSWUJhAfjEGmdtlXhHf6EbCspP4Qoi1M27efXG27nG11NXGxN6hD3ysKhTjy
         qe69tS591RoRoiT9fhC3jwUy9y2p+zcd5C2ZdrvhzGl/OQrQ0nOAcIPDVvGxaMLLvPYr
         FCjZTtX6vr8fMX2W0e4FeOPSQp12A4TPvNK0pdpy3ZhJX3wZoBs8M/6b0cvP7NCLSI41
         W/e0WDeXtWw/mb+DZ7WbXo+a54SWn3sQ19RLBRLBOCL4bNFwNR6brDzKfOHPbvnDm8Zm
         TpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789222078; x=1789826878;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTCfdkP73gLXJ25CwDT//d6Us1e6esblg46ABiyVDOM=;
        b=Mv/rmPsf2jZ/SA7byCPY18QKlDN4+LEpf3Gz1/P+btS/zKBPcHoJ9vdppOE1CmDk8k
         2i8ezNVhK8F7tLIIy9ZSpwJ5jlIuMeVJr96Mlu+qa/4wNAZ6CWkbGMFN5S3Mpq/pMozk
         L5P+dexR6rG+AiivKAk+feF28zZDhjxGKzmSgSj3JKRUoYIiSdWiuMryT00a2TLKVHhA
         /faeu84UshCpU5+Reo2M5oHmuVDLli9zTsFAkcR5JfFLM34/LKk9fJdAJq9nvVUivF83
         PJ2BYvqrysoPbNISbirlXWcSrGGc7U+0HvGfSNaHGxFm7EXaNO8oysvsSuFJ4bsKmTI5
         6QdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvwHjOn5OuRu1SG7J+x6UH2zZpYvHU5kA8DD+q91GBGv0YSnuLZky4q6CP6ew9O6zJhYKNhkLdJIZNrw==@vger.kernel.org
X-Gm-Message-State: AFuF++k75I65d7g1Ji5pkA+WPzs78Yt+dqj5tNZEr7ebb1QCuL7jJq4l
	paUAr9H0IY426SNoa2ZtWtP6K8QvL2Pj0+m25g1dExbWiCbZruKy13jqVccVjWtU
X-Gm-Gg: AYBFou2BSVvEuY4I33slF7SNBWVN2Zj3/dDj5QaFqU4BhX4vy5tZYMH1hGhwwZpeVl9
	iKqteohJbQniDnhuslJRyB/MIrb4xGKKp3QMjy3SZS3UkbaxzA/hVCFBqhzWW5fDu6hFbSBlUYZ
	uVAPB9CI/iooHu6PISIZgBtu/81SAlXwc8L6WOkhuPyNA1l2YrP741/loeXe0FC1aRnYrcj/b3T
	gIWv4XvCM9XXkOeX82x1ZyOc1bZEIjHalLJ+tKjIyuepp957Wek+cnYhamYlb9LT35scjcyD/5e
	XL16/KDk06gkYMNzlZWLQmCYB9BdxIOCcN1QxhdQxRIBM18iN3kvTTFug4gyzaWPvGY514YBgrh
	PJxSDh+B6aihOOapHuz9u7ml4VrwGezNzHsEZ8geOuoW3NU2Mz9mR+gObQPtCccbeNd0lMysHA7
	lpVFT6kwE8I+tezCzsKYNGA5zxUS5kgIzax2G9Bq9wzj6d+58bCas3CKx1fUlv7DhY8Lz7iChzD
	Wwdd67SiQHjHMUKCXSve9VoRmFyRkA=
X-Received: by 2002:a05:620a:3182:b0:939:6dea:374c with SMTP id af79cd13be357-93a038efc6fmr409029785a.48.1789222077789;
        Sat, 12 Sep 2026 07:07:57 -0700 (PDT)
Received: from dhoja (S01067483c248479d.wp.shawcable.net. [50.72.244.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939fc4a9455sm292155585a.31.2026.09.12.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 07:07:56 -0700 (PDT)
Date: Sat, 12 Sep 2026 09:07:54 -0500
From: Curtis Vogt <curtis.vogt@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Message-ID: <aqVcun3-ksMgzb9z@dhoja>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <20260910220421.40356e51.michal.pecio@gmail.com>
 <55918a70-72c9-4f55-934b-81a692d4619b@amd.com>
 <20260910225259.66b480c6.michal.pecio@gmail.com>
 <cb4d4f93-2e34-4c5b-b400-06fb01b6b04c@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb4d4f93-2e34-4c5b-b400-06fb01b6b04c@amd.com>

On Thu, Sep 10, 2026 at 03:58:27PM -0500, Mario Limonciello wrote:
> 
> 
> On 9/10/26 15:52, Michal Pecio wrote:
> > On Thu, 10 Sep 2026 15:43:18 -0500, Mario Limonciello wrote:
> > > > > +/*
> > > > > + * The headset's EDID service is lost when the host disables the DisplayPort
> > > > > + * PHY during system suspend, so it needs the reboot on the way out of
> > > > > + * suspend.  Doing it on the way in does not work: the headset dropping off
> > > > > + * USB is a remote-wakeup event from its hub and aborts the suspend.
> > > > > + */
> > > > 
> > > > The internal hub which will be quirked by the next patch, or its parent?
> > > 
> > > It has to be the internal hub if quirking it works, no?

The parent needs to be quirked: the breakout box's own hub, 28de:2613,
sits above Microchip USB2744 (0424:2744). Only the 28de:2613 hub ever
registered wakeup events, and quirking it alone is enough.

I also tested the quirk using a stock kernel (7.2.3) using the kernel
param `usbcore.quirks=28de:2613:j` which stopped the headset from waking
the host. Without that param I found that the headset would wake the
host when healthy but not when wedged.

> > I believe there are two separate problems here:
> > 
> > 1. resetting the device at suspend causes instant wakeup
> > 2. a few seconds later the system wakes up anyway
> > 
> > 1. is solved by resetting on resume rather than suspend
> > 2. is solved by the quirk
> > 
> > Questions:
> > 
> > Any chance that 2 also solves 1?

It does. With the quirk from 3/3 and the driver rebooting from the suspend
hook instead of resume the headset reboots during suspend entry and the
host stays asleep.

> > Would resetting on suspend be preferable, as the comment suggests?
> > Maybe it would, if the reset can race with DP seeing empty EDID?

Yes, and the log bears out the ordering concern. With the reboot on
suspend the headset is already back and so the EDID reads cleanly the
first time. With the headset reboot on resume a re-enumeration occurs.
There was no "EDID err" upon resume with either variant. We can go back to
Mario's implementation of headset reboot on suspend.

> I do think that resetting on suspend makes a lot more sense for that exact
> reason.  That's why my original PoC did it that way.
> 
> That's a very good idea to see if the quirk + moving it back to suspend
> works.

I've validated this approach works. Happy to return to it.

Diff against 2/3 moving the headset reboot back to the suspend hook:

---8<---
 drivers/hid/hid-valve-index.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-valve-index.c b/drivers/hid/hid-valve-index.c
index 43c1142b7215..f6941dd04910 100644
--- a/drivers/hid/hid-valve-index.c
+++ b/drivers/hid/hid-valve-index.c
@@ -103,14 +103,18 @@ static struct attribute *valve_index_attrs[] = {
 ATTRIBUTE_GROUPS(valve_index);
 
 /*
- * The headset's EDID service is lost when the host disables the DisplayPort
- * PHY during system suspend, so it needs the reboot on the way out of
- * suspend.  Doing it on the way in does not work: the headset dropping off
- * USB is a remote-wakeup event from its hub and aborts the suspend.
+ * Disabling the DisplayPort PHY during system suspend leaves the headset
+ * unable to serve its EDID until it is rebooted, so send the reboot from
+ * the suspend hook.  The headset drops off USB about a second later; that
+ * does not abort the suspend because its breakout box hub is quirked to
+ * not be a wakeup source.  On resume the hub finds the rebooted headset on
+ * the same port and resets it in place, and the connector detection reads
+ * a fresh EDID.  Runtime autosuspend is left alone.
  */
-static int valve_index_resume(struct hid_device *hdev)
+static int valve_index_suspend(struct hid_device *hdev, pm_message_t message)
 {
-	valve_index_reboot(hdev, false);
+	if (!PMSG_IS_AUTO(message))
+		valve_index_reboot(hdev, false);
 
 	return 0;
 }
@@ -130,8 +134,7 @@ MODULE_DEVICE_TABLE(hid, valve_index_devices);
 static struct hid_driver valve_index_driver = {
 	.name = "valve-index",
 	.id_table = valve_index_devices,
-	.resume = valve_index_resume,
-	.reset_resume = valve_index_resume,
+	.suspend = valve_index_suspend,
 	.shutdown = valve_index_shutdown,
 	.driver.dev_groups = valve_index_groups,
 };
