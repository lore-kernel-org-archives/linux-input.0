Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469475;
	b=kFNSz6smWSheHXRleAsSkOKqrJk9updNeiZ5xo+g4/IxAfzVqQI6McD884l0PY1/d+9H
	 yXKs/V3cvSWJ94orSmlmlJtjys2/HX7ogyKARMfx6ycjVGbwxaOoFl7TWzkeNYP6XqIZ9
	 5j/u7J7NjaEHEMvo8d/tUagE84pie/AMvFPc7LX3H2qaJfRtJQmIljiwPwPw4hxAkPHcv
	 td07rnyp7VIiqlt3klGhzkJb8tueTE51kz2bkW7kRNsIz4yozMcC+XnYcqndQFbVTYkoY
	 YoyDNeqr28XqDEJu5t+getqA7YWBaa3cdN/CHJRPImxgDcK7FEc82us2kbFUcVuLvGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z1UTqLrSnJ/ilqOfiP/8Q9WO04oOyp4hqqJ39ZW1PVo=;
	b=kmCgeBVUykcv9Odtw/+aAAJwpvYJxX0iuDxyxkVPP0wNmv68jBcY4hIKqajZ363GKYo9
	 sm3sgo4XynSHfFhRKl748H+e1dGdzJDawYRqec9usib5lT4M+DijdQTTIak4CFWjGp6TM
	 syvT7IXkiX/s2DzoGQxHnoh0gyIpPuYYnjfoB0Prpap7AgPmmDHDrwj9e2TWIrlcM07+J
	 ItHFzNEESzLPWvOkqvxT6Isr7knCreq8ijdqfnrXe/h/CJekuzhQbKkumfWXXcPTJ+HSJ
	 i5l5XxhSfRK1q1o4SVRV2q7HAWvykJGv5LWZ19JWh+D+nCweNO5ifdt+95p+PQVztoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faAlMOVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08741606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faAlMOVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39261F000C1;
	Sat, 31 Oct 2026 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469474;
	bh=Z1UTqLrSnJ/ilqOfiP/8Q9WO04oOyp4hqqJ39ZW1PVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=faAlMOVOouIxyja3maXxzBPowMKY+W22VQS4wGNc8GonoymCnXYjnvxEH5SHSGoH5
	 1s1jsu8QeS3TcXHbrgDE5kZJilNQqhkC2XNkZhB/wFIrYKvKOaUD4g4zf/sbCEMye0
	 jGQTSKmMA8NhixKZIcGh/oUOyGzTUVBtfBgHvfsAMJUTk6OTfi4RQzDr984FNZEdES
	 gXIzvAnDc9nYq6ffrDq/qdXVTspNZQ+3lQ5Q6oNcIR6ghEzJWkN7hYbP5Um8wt+Rpw
	 kZmlRngknueZea00yLferPYJgHiTa5N5Kj0kVqodOQCHeShQlz05HNt60/np0GGPX+
	 4WLrx60SWEShg==
Message-ID: <sashiko-outbox-192085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/17] HID: asus: add joysticks inner and outer
 range configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261031174130.208240-6-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-6-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:57:54 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] HID: asus: ABBA deadlock holding ally_prefs.lock in ally_sysfs_rem=
ove()
- [Low] HID: asus: inconsistent threshold defines and callback duplication
--

commit 21c1f6aa8c8abefa0a006966f1d360a594341b9e
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks inner and outer range configuration

This commit adds sysfs attributes under left_joystick_axis and
right_joystick_axis on ROG Ally devices to configure and restore the inner
and outer thresholds for both joysticks.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index fe2008f9d51d1..50b0e60405958 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -98,6 +98,9 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> =20
>  #define ASUS_HID_INPUT_KBD_REPORT_ID 0x01
> =20
> +#define ASUS_ALLY_OUTER_THRESHOLD_MIN 70
> +#define ASUS_ALLY_OUTER_THRESHOLD_MAX 100
> +

[ ... ]

> @@ -826,7 +834,6 @@ static int ally_detect_capabilities(struct hid_device=
 *hdev)
>  	return 0;
>  }
> =20
> -/* Caller holds ally_prefs.lock. The packet is sent on @hdev. */
>  static int ally_set_xbox_controller(struct hid_device *hdev, bool enable=
d)
>  {
>  	const u8 payload[] =3D { enabled ?
> @@ -1042,6 +1049,304 @@ static struct attribute *ally_right_vibration_att=
rs[] =3D {

[ ... ]

> +static ssize_t left_joystick_inner_threshold_store(struct device *dev,
> +						   struct device_attribute *attr,
> +						   const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	u8 value;
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > 50)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!ally_prefs.user_cal_support)
> +			return -EOPNOTSUPP;
> +
> +		ret =3D ally_set_joystick_thresholds(hdev, value,
> +						   ally_prefs.left_outer_threshold,
> +						   ally_prefs.right_deadzone,
> +						   ally_prefs.right_outer_threshold);
> +		if (ret)
> +			return ret;
> +
> +		ally_prefs.left_deadzone =3D value;
> +	}
> +
> +	sysfs_notify(&dev->kobj, "left_joystick_axis", "inner_threshold");
> +
> +	return count;
> +}
> +
> +static ssize_t left_joystick_inner_threshold_range_show(struct device *d=
ev,
> +							struct device_attribute *attr,
> +							char *buf)
> +{
> +	return sysfs_emit(buf, "0 50\n");
> +}
> +
> +static ssize_t left_joystick_outer_threshold_show(struct device *dev,
> +						  struct device_attribute *attr,
> +						  char *buf)
> +{
> +	guard(mutex)(&ally_prefs.lock);
> +
> +	if (!ally_prefs.user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	return sysfs_emit(buf, "%u\n", ally_prefs.left_outer_threshold);
> +}
> +
> +static ssize_t left_joystick_outer_threshold_store(struct device *dev,
> +						   struct device_attribute *attr,
> +						   const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	u8 value;
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value < 70 || value > 100)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!ally_prefs.user_cal_support)
> +			return -EOPNOTSUPP;
> +
> +		ret =3D ally_set_joystick_thresholds(hdev, ally_prefs.left_deadzone,
> +						   value, ally_prefs.right_deadzone,
> +						   ally_prefs.right_outer_threshold);
> +		if (ret)
> +			return ret;
> +
> +		ally_prefs.left_outer_threshold =3D value;
> +	}
> +
> +	sysfs_notify(&dev->kobj, "left_joystick_axis", "outer_threshold");
> +
> +	return count;
> +}
> +
> +static ssize_t left_joystick_outer_threshold_range_show(struct device *d=
ev,
> +							struct device_attribute *attr,
> +							char *buf)
> +{
> +	return sysfs_emit(buf, "70 100\n");
> +}

[ ... ]

> +static ssize_t right_joystick_inner_threshold_store(struct device *dev,
> +						    struct device_attribute *attr,
> +						    const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	u8 value;
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > 50)
> +		return -EINVAL;

[ ... ]

> +static ssize_t right_joystick_inner_threshold_range_show(struct device *=
dev,
> +							 struct device_attribute *attr,
> +							 char *buf)
> +{
> +	return sysfs_emit(buf, "0 50\n");
> +}

[ ... ]

> +static ssize_t right_joystick_outer_threshold_store(struct device *dev,
> +						    struct device_attribute *attr,
> +						    const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	u8 value;
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value < ASUS_ALLY_OUTER_THRESHOLD_MIN || value > ASUS_ALLY_O=
UTER_THRESHOLD_MAX)
> +		return -EINVAL;

[ ... ]

> +static ssize_t right_joystick_outer_threshold_range_show(struct device *=
dev,
> +							 struct device_attribute *attr,
> +							 char *buf)
> +{
> +	return sysfs_emit(buf, "%u %u\n", ASUS_ALLY_OUTER_THRESHOLD_MIN,
> +			  ASUS_ALLY_OUTER_THRESHOLD_MAX);
> +}

[Severity: Low]
As reported by Ilpo J=C3=A4rvinen on v11 [1], this isn't a bug, but
ASUS_ALLY_OUTER_THRESHOLD_MIN and ASUS_ALLY_OUTER_THRESHOLD_MAX are only
used in right_joystick_outer_threshold_store() and
right_joystick_outer_threshold_range_show(), while
left_joystick_outer_threshold_store() and
left_joystick_outer_threshold_range_show() still use literal 70 and 100.

Similarly, the inner threshold upper bound of 50 is hardcoded in
left_joystick_inner_threshold_store(),
left_joystick_inner_threshold_range_show(),
right_joystick_inner_threshold_store(), and
right_joystick_inner_threshold_range_show(), and the left and right range
show callbacks are identical.

Could these threshold bounds all use shared defines, share the range show
callbacks between left and right joysticks, and keep the locking comment
above ally_set_xbox_controller()?

[ ... ]

> @@ -1093,6 +1399,27 @@ static int ally_prefs_setup(struct hid_device *hde=
v)
>  		}
>  	}
> =20
> +	/* Skip the calibration groups when the capability is missing. */
> +	if (ally_prefs.user_cal_support) {
> +		int cal_i;
> +
> +		for (cal_i =3D 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups); cal_i++) {
> +			ret =3D sysfs_create_group(&hdev->dev.kobj,
> +						 ally_cal_attr_groups[cal_i]);
> +			if (ret) {
> +				hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
> +					ally_cal_attr_groups[cal_i]->name, ret);
> +				while (cal_i--)
> +					sysfs_remove_group(&hdev->dev.kobj,
> +							   ally_cal_attr_groups[cal_i]);
> +				for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
> +					sysfs_remove_group(&hdev->dev.kobj,
> +							   &ally_attr_groups[i]);
> +				return ret;
> +			}
> +		}
> +	}
> +
>  	ally_prefs.sysfs_live =3D true;
>  	return 0;
>  }
> @@ -1104,15 +1431,21 @@ static void ally_sysfs_remove(struct hid_device *=
hdev)
>  	if (ally_get_endpoint_address(hdev) !=3D HID_ALLY_INTF_CFG_IN)
>  		return;
> =20
> -	scoped_guard(mutex, &ally_prefs.lock) {
> -		if (!ally_prefs.sysfs_live)
> -			return;
> +	guard(mutex)(&ally_prefs.lock);
> =20
> -		ally_prefs.sysfs_live =3D false;
> -	}
> +	if (!ally_prefs.sysfs_live)
> +		return;
> +
> +	ally_prefs.sysfs_live =3D false;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
>  		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +
> +	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support ||
> +	    ally_prefs.resp_curve_support) {
> +		for (i =3D 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
> +			sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[i]);
> +	}
>  }

[Severity: High]
Can changing scoped_guard(mutex, &ally_prefs.lock) to
guard(mutex)(&ally_prefs.lock) in ally_sysfs_remove() (and calling
sysfs_remove_group() under ally_prefs.lock in the error path of
ally_prefs_setup()) cause an ABBA deadlock with concurrent sysfs reads or
writes?

When userspace reads or writes an Ally sysfs attribute such as
left_joystick_inner_threshold_show() or
left_joystick_inner_threshold_store(), kernfs acquires the active reference
on the kernfs_node before invoking the callback, which then locks
ally_prefs.lock:

  kernfs_fop_read_iter() / kernfs_fop_write_iter()
    kernfs_get_active()
      left_joystick_inner_threshold_show()
        mutex_lock(&ally_prefs.lock)

When ally_sysfs_remove() or the error rollback in ally_prefs_setup() runs
concurrently, it holds ally_prefs.lock while calling sysfs_remove_group(),
which waits in kernfs_drain() for all active references on those attributes
to finish:

  ally_sysfs_remove()
    mutex_lock(&ally_prefs.lock)
    sysfs_remove_group()
      __kernfs_remove()
        kernfs_drain()

Should ally_prefs.lock be released before calling sysfs_remove_group()?

[1] https://lore.kernel.org/r/2bf5c5f8-185e-c322-dd76-ec182514c93c@linux.in=
tel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174130.2082=
40-1-denis.benato@linux.dev?part=3D5
