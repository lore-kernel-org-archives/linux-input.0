From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [GIT PULL RFC] directly poll battery strength when reading power_supply
Date: Wed, 07 Dec 2011 09:25:38 -0800
Message-ID: <4EDFA192.7000602@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz> <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org> <alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz> <CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com> <4ED90E6D.8090402@goop.org> <CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com> <4ED9BDF8.3010600@goop.org> <CAD2FfiE-rg-1bMmVpYzBhnQcBMKKKO4WPnu0bvx+pvdFnpARrQ@mail.gmail.com> <4EDE4C7A.1010802@goop.org> <CAD2FfiHWuEmVTa54YqfJDk5zHpSQuM_nwPT=mR6NoWpajpydpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:57632 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166Ab1LGRZn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Dec 2011 12:25:43 -0500
In-Reply-To: <CAD2FfiHWuEmVTa54YqfJDk5zHpSQuM_nwPT=mR6NoWpajpydpg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On 12/07/2011 04:51 AM, Richard Hughes wrote:
> On 6 December 2011 17:10, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> Something like  HID UPS would appear to be in the middle of the USB
>> devices, but actually powers the whole machine (or more).
> Right, although I think we still need an explicit
> "is_powering_computer" flag or something exposed to userspace
> ortherwise we're back to heuristics and hand coded quirks.

Something like this?

diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index e15d4c9..21178eb 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -63,6 +63,9 @@ static ssize_t power_supply_show_property(struct device *dev,
 	static char *capacity_level_text[] = {
 		"Unknown", "Critical", "Low", "Normal", "High", "Full"
 	};
+	static char *scope_text[] = {
+		"Unknown", "System", "Device"
+	};
 	ssize_t ret = 0;
 	struct power_supply *psy = dev_get_drvdata(dev);
 	const ptrdiff_t off = attr - power_supply_attrs;
@@ -95,6 +98,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 		return sprintf(buf, "%s\n", capacity_level_text[value.intval]);
 	else if (off == POWER_SUPPLY_PROP_TYPE)
 		return sprintf(buf, "%s\n", type_text[value.intval]);
+	else if (off == POWER_SUPPLY_PROP_SCOPE)
+		return sprintf(buf, "%s\n", scope_text[value.intval]);
 	else if (off >= POWER_SUPPLY_PROP_MODEL_NAME)
 		return sprintf(buf, "%s\n", value.strval);
 
@@ -167,6 +172,7 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(time_to_full_now),
 	POWER_SUPPLY_ATTR(time_to_full_avg),
 	POWER_SUPPLY_ATTR(type),
+	POWER_SUPPLY_ATTR(scope),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(model_name),
 	POWER_SUPPLY_ATTR(manufacturer),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a28f2df..2e3c827 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -74,6 +74,12 @@ enum {
 	POWER_SUPPLY_CAPACITY_LEVEL_FULL,
 };
 
+enum {
+	POWER_SUPPLY_SCOPE_UNKNOWN = 0,
+	POWER_SUPPLY_SCOPE_SYSTEM,
+	POWER_SUPPLY_SCOPE_DEVICE,
+};
+
 enum power_supply_property {
 	/* Properties of type `int' */
 	POWER_SUPPLY_PROP_STATUS = 0,
@@ -116,6 +122,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
+	POWER_SUPPLY_PROP_SCOPE,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,


>> And if the device being pointed to is a mouse, then upower knows its
>> powering a mouse.
> Define "mouse" -- an input devices with two axis? I think an explicit
> type might be clearer.

Well, what are you really trying to represent?  Is it enough for upower
to say "here are some devices with batteries, this is everything I know
about them", and let its clients work out what they really are?  Does
upower need to work out what kind of device it is?

Thanks,
    J
