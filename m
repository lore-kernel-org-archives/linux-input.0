Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038926;
	b=3K43j2peuSxlH1F/KU2s9P/WB9QcnaK5hIFOhyxwIwP1nO7iRc9iMxZHwwPpJ515KrpQ
	 2hP2LCqC3gGAH8kBlWzCL16b9zSL9hwmRf1iVekK3N5jP5mf3RVJvTn2nSvRDIzlboR/6
	 96Fm9MVU0zQLkETncQNg5faOh3IK2yNKwYdxQSjKcxrcMO1KHNkM1pONP/sm4KMydMYdi
	 ti1eY/7iMmUtYE4KHI4ZI8DJIraIxMDpPzSN51oAflWNYbngpIBPGOV6s0E5JU69Eww7y
	 OqmP3G/qnmhtIjxxFILa1TXSbTiMyN8keMsu5O9qFfXOPysKuB//FD+bkgiuL2JZw4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038926;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=6XL6YcX8cL37HBNREbXC4Z1+wZEs5Q469sUSJUjSMy4=;
	b=PyQJozqx+L90zDK3RKyVxTu53Bo59CKJt7lMOXK6Bek3nZdQmYPOSgCaGTUgxvPyO8sC
	 75zgcTucOz63/mLixAgJI5+uMFXY4jK2q7oVDGmwWssI/mvZK8U4H3zGOS14melGnniB+
	 fqev5x3tmaBYxcRyvt22jZT+qWaeFWrU4q3RcUODyDIGBZmk2wDaceGxzx5hW6SCJcrHE
	 ASjaNXoqaHv9bTePfQGXOhl29iOyBDOuzxPLALHJkn7IpuA0yJfIJTu38TwW7moK9eA4D
	 Y2Sz+/Zs2IqNiiPMS448LyZjbdIxOl8DBZGIv3/Q9Kzrr6T4rrqYlb8yjxbDSzdg+uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="k2/1Iat4";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699B606A31A;
	Mon, 26 Oct 2026 18:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B699B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k2/1Iat4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793038925; x=1824574925;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W58r7ddDUpnAk7HTNMuAQzfTn6aAlqEu+z1t7GbR9Og=;
  b=k2/1Iat450hCLtFFKBx7KtLj7lI/6/nae/U7B/toleZovAJw0XmB6vx6
   LGnCnulS3JopXhD45Z8gn4L4YiKAavhloWNUFYDfUVOSRgj3KiTi8FLv0
   BdRMDxLexUNL4hT+wp3RDWIiYB/RWcRgo62qh2Q4rSBYriK2/uUU98zOt
   fIwJXRaYelE7yn8Y/zHwGlSxVMtvF66S1D5ioPeRI7KVNHFepS8FNCDTz
   MtJUL8qPCUE63Sg5VWrS+8Ebe5XkWVcOw+qjBZm33Vz8+aUWx1/79ixpL
   cMR4fnCtEfByJvLZW7DokQxEJOyfnQzeTOZncleqtLFRJ4xh/xZuv8xUg
   g==;
X-CSE-ConnectionGUID: FpZQW2TCSqaWM36wOeRrgQ==
X-CSE-MsgGUID: XGgi/VVnSt2v9GX6+ieMUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1747053"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1747053"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:22:03 -0700
X-CSE-ConnectionGUID: K+l3cBvSSGmXyI6SxfTf8g==
X-CSE-MsgGUID: pwLIt1CWRyG9WIcAOjS9Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4474684"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:21:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 20:21:54 +0200 (EET)
To: Sakari Ailus <sakari.ailus@iki.fi>
cc: Denis Benato <denis.benato@linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, 
    kernel@lists.opengamingcollective.org, 
    Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, 
    Mateusz Schwartz <matthew.schwartz@linux.dev>, 
    Denis Benato <benato.denis96@gmail.com>, 
    Jonathan LoBue <jlobue10@gmail.com>, 
    Khamunetri Clark <khamunetriclark@gmail.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Joshua Leivenzon <hacker1024@users.sourceforge.net>, 
    Nathan Chancellor <nathan@kernel.org>, 
    =?ISO-8859-15?Q?Rebecca_Mara_M=FCller?= <rebecca.mara@posteo.de>, 
    Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>, 
    Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v11 08/18] HID: asus: add support to force feedback
In-Reply-To: <at9JNgMf8EZdCHEh@valkosipuli.retiisi.eu>
Message-ID: <1c017f49-bc69-fc68-20f8-0c66a2c85719@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-9-denis.benato@linux.dev> <at9JNgMf8EZdCHEh@valkosipuli.retiisi.eu>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 26 Oct 2026, Sakari Ailus wrote:

> Hi Denis,
> 
> I tested this on Asus T100TA, it seems to work fine.
> 
> Please see my other comments below.
> 
> On Sun, Oct 25, 2026 at 11:52:21PM +0000, Denis Benato wrote:
> > Unlike ROG ally the X version and following ones uses DInput protocol
> > and the force feedback needs to be implemented as its protocol is
> > vendor-specific, therefore add support for FF_RUMBLE with magnitude
> > scaling on a work-queue based approach to avoid using possibly
> > sleeping calls in atomic context.
> > 
> > Signed-off-by: Denis Benato <denis.benato@linux.dev>
> > Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
> > Signed-off-by: Luke Jones <luke@ljones.dev>
> > ---
> >  drivers/hid/Kconfig    |   1 +
> >  drivers/hid/hid-asus.c | 321 +++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 297 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 2481bc01c435..042e3bb0d817 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -189,6 +189,7 @@ config HID_ASUS
> >  	depends on USB_HID
> >  	depends on LEDS_CLASS
> >  	depends on ASUS_WMI || ASUS_WMI=n
> > +        select INPUT_FF_MEMLESS
> 
> Tabs, please.
> 
> >  	select POWER_SUPPLY
> >  	help
> >  	Support for Asus notebook built-in keyboard and touchpad via i2c, and
> > diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > index e1883ee20413..a3a21a1493aa 100644
> > --- a/drivers/hid/hid-asus.c
> > +++ b/drivers/hid/hid-asus.c
> > @@ -244,6 +244,23 @@ struct ally_config {
> >   */
> >  static struct ally_config *ally_config;
> >  
> > +/* XInput force-feedback report (output report 0x0d, gamepad interface) */
> > +struct ff_data {
> > +	u8 enable;
> > +	u8 magnitude_left;
> > +	u8 magnitude_right;
> > +	u8 magnitude_strong;
> > +	u8 magnitude_weak;
> > +	u8 pulse_sustain_10ms;
> > +	u8 pulse_release_10ms;
> > +	u8 loop_count;
> > +} __packed;
> > +
> > +struct ff_report {
> > +	u8 report_id;
> > +	struct ff_data ff;
> > +} __packed;
> > +
> >  struct ally_handheld {
> >  	/* All read/write to IN interfaces must lock */
> >  	struct mutex intf_mutex;
> > @@ -269,6 +286,13 @@ struct ally_handheld {
> >  	bool ally_x_probe_in_progress;
> >  	bool keyboard_probe_in_progress;
> >  
> > +	struct ff_report ff_packet;
> > +	struct work_struct ff_work;
> > +	/* Serializes ff_packet and update_ff between play_effect and ff_work */
> > +	spinlock_t ff_lock;
> > +	bool ff_work_initialized;
> > +	bool update_ff;
> 
> Arranging these with the rest of the bools would save some memory.
> 
> > +
> >  	struct hid_device *keyboard_hdev;
> >  	struct input_dev *keyboard_input;
> >  
> > @@ -384,10 +408,15 @@ enum ally_command_codes {
> >  	CMD_SET_ANTI_DEADZONE           = 0x18,
> >  };
> >  
> > +/* XInput rumble magnitudes use the hardware's 0..100 intensity range. */
> > +#define ALLY_FF_MAX_INTENSITY 100
> > +
> >  static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
> >  	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
> >  };
> >  
> > +static_assert(sizeof(struct ff_report) == sizeof(ALLY_FORCE_FEEDBACK_OFF));
> > +
> >  /*
> >   * The ROG Ally device presents multiple USB interfaces (keyboard, mouse, gamepad,
> >   * and custom configuration interface) that bind to the same module. Since only
> > @@ -395,6 +424,7 @@ static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
> >   * ally_handheld structure to share state across these separate HID interfaces.
> >   */
> >  static void ally_resume_work_fn(struct work_struct *work);
> > +static void ally_x_ff_work_fn(struct work_struct *work);
> >  
> >  /*
> >   * Changes to ally_drvdata must lock: the raw_event callbacks, which may
> > @@ -410,6 +440,13 @@ static struct ally_handheld ally_drvdata = {
> >  	 */
> >  	.resume_work = __DELAYED_WORK_INITIALIZER(ally_drvdata.resume_work,
> >  						  ally_resume_work_fn, 0),
> > +	/*
> > +	 * Initialised statically for the same reason as resume_work: remove()
> > +	 * drains the work whichever of the interfaces probed or failed to
> > +	 * probe, so it must be safe to cancel unconditionally.
> > +	 */
> > +	.ff_work = __WORK_INITIALIZER(ally_drvdata.ff_work, ally_x_ff_work_fn),
> > +	.ff_lock = __SPIN_LOCK_UNLOCKED(ally_drvdata.ff_lock),
> >  };
> >  
> >  /*
> > @@ -2425,7 +2462,8 @@ static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
> >  	 * create them, so a device without those capabilities does not
> >  	 * trigger a "not found" warning.
> >  	 */
> > -	if (cfg->user_cal_support || cfg->anti_deadzone_support) {
> > +	if (cfg->user_cal_support || cfg->anti_deadzone_support ||
> > +	    cfg->resp_curve_support) {
> >  		for (i = 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
> >  			sysfs_remove_group(&hdev->dev.kobj,
> >  					   ally_cal_attr_groups[i]);
> > @@ -2611,6 +2649,106 @@ static void ally_x_input_close(struct input_dev *dev)
> >  	hid_hw_close(input_get_drvdata(dev));
> >  }
> >  
> > +/**
> > + * ally_x_send_ff_report() - Send a force-feedback report to the gamepad
> > + * @hdev: HID device
> > + * @buf: buffer containing the report to send
> > + * @len: length of the report
> > + *
> > + * The gamepad interface consumes force-feedback packets as output reports,
> > + * unlike the config interface which expects feature reports: a rumble packet
> > + * sent as HID_REQ_SET_REPORT would be rejected by the hardware.
> > + *
> > + * The caller must hold ally->intf_mutex, so that a send cannot race with
> > + * the gamepad interface being unbound and its transport being stopped.
> > + *
> > + * Return: count of data transferred, negative if error
> > + */
> > +static int ally_x_send_ff_report(struct hid_device *hdev,
> > +				 const u8 *buf, size_t len)
> > +{
> > +	u8 *dmabuf __free(kfree) = kmemdup(buf, len, GFP_KERNEL);
> 
> It's not very nice to assign variables and then check for errors. I'd thus
> separate the declaration and the assignment.

I actually thought the same thing first.

But then stopped and realized, it's mid-function declaration of a cleanup 
variable exactly following the guidelines (the long comment in cleanup.h).

So this function doesn't really have variable declaration block at all, 
making the mid-function variable declaration look like one. I understand 
it looks confusing when encountering this for the first time, it was for 
me as well.

> > +	if (!dmabuf)
> > +		return -ENOMEM;
> > +
> > +	return hid_hw_output_report(hdev, dmabuf, len);
> > +}

-- 
 i.

