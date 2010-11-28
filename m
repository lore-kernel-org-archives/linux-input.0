From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sun, 28 Nov 2010 00:01:10 -0800
Message-ID: <20101128080110.GD14499@core.coreip.homeip.net>
References: <4CEE6D2A.9040408@euromail.se>
 <4CEE6EE8.4060805@gmail.com>
 <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
 <4CF0BC13.2010800@gmail.com>
 <20101127083229.GA28745@core.coreip.homeip.net>
 <4CF0C69D.9080904@gmail.com>
 <20101127091533.GA27213@core.coreip.homeip.net>
 <4CF0D35B.4030807@gmail.com>
 <20101127233901.GA29981@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:46634 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0K1IBR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Nov 2010 03:01:17 -0500
Received: by iwn7 with SMTP id 7so643525iwn.1
        for <linux-input@vger.kernel.org>; Sun, 28 Nov 2010 00:01:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101127233901.GA29981@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Sat, Nov 27, 2010 at 03:39:02PM -0800, Dmitry Torokhov wrote:
> On Sat, Nov 27, 2010 at 12:46:03PM +0300, Nikolai Kondrashov wrote:
> > On 11/27/2010 12:15 PM, Dmitry Torokhov wrote:
> > >2000LPI == about 79 l/mm. How is it not useable?
> > TBH, I didn't make any real calculations.
> > The introduced error isn't very high, indeed. The vertical size of 4x3 inch
> > tablet becomes 75 mm instead of 76 mm. So maybe it's alright.
> > 
> > >In mainline synaptics is the only one that does this. We do not know how
> > >many drivers in vendor trees fill and use this data nor we do not know
> > >about userspace. The fact that we were not able to locate them does not
> > >mean they do not exist. The units/mm are part of input ABI now.
> > Well, I can't argue with you here.
> > I didn't think about 3rd party drivers, TBH.
> > 
> > >Right, standarize on existing UOM (which are per/mm) and then implement
> > >other UOM if theya re really needed.
> > Will this fix qualify for inclusion into 2.6.37?
> 
> Yes, I believe it does.
> 
> > Also, what do you think about units per radians for rotational axis?
> 

How about the following?

-- 
Dmitry


Input: document struct input_absinfo

Add documentation for struct input_absinfo that is used in EVIOCGABS
and EVIOCSABS ioctl and specify units of measure used for reporting
resolution for an axis.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 include/linux/input.h |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)


diff --git a/include/linux/input.h b/include/linux/input.h
index a50046f..a8af21d 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -47,6 +47,25 @@ struct input_id {
 	__u16 version;
 };
 
+/**
+ * struct input_absinfo - used by EVIOCGABS/EVIOCSABS ioctls
+ * @value: latest reported value for the axis.
+ * @minimum: specifies minimum value for the axis.
+ * @maximum: specifies maximum value for the axis.
+ * @fuzz: specifies fuzz value that is used to filter noise from
+ *	the event stream.
+ * @flat: values that are within this value will be discarded by
+ *	joydev interface and reported as 0 instead.
+ * @resolution: specifies resolution for the values reported for
+ *	the axis.
+ *
+ * Note that input core does not clamp reported values to the
+ * [minimum, maximum] limits, such task is left to userspace.
+ *
+ * Resolution for main axes (ABS_X, ABS_Y, ABS_Z) is reported in
+ * units per millimeter (units/mm), resolution for rotational axes
+ * (ABS_RX, ABS_RY, ABS_RZ) is reported in units per radian.
+ */
 struct input_absinfo {
 	__s32 value;
 	__s32 minimum;
@@ -1134,7 +1153,7 @@ struct input_mt_slot {
  *	of tracked contacts
  * @mtsize: number of MT slots the device uses
  * @slot: MT slot currently being transmitted
- * @absinfo: array of &struct absinfo elements holding information
+ * @absinfo: array of &struct input_absinfo elements holding information
  *	about absolute axes (current value, min, max, flat, fuzz,
  *	resolution)
  * @key: reflects current state of device's keys/buttons
